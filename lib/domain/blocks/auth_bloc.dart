import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:vk/domain/api_client/account_api_client.dart';
import 'package:vk/domain/api_client/auth_api_client.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';

abstract class AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {

  // --- ШАБЛОН ---
  // @override
  // bool operator ==(Object other) =>
  //   identical(this, other) || 
  //   other is AuthAuthorizedState && runtimeType == other.runtimeType;

  //   @override 
  // int get hashCode => 0;
}


class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;
  AuthLoginEvent({
    required this.login,
    required this.password,
  });
}

class AuthLogoutEvent extends AuthEvent {}




abstract class AuthState {}

class AuthAuthorizedState extends AuthState {

  @override // означает, что два авторизованных стейта будут равны, если это один и тот же объект/класс. Если прилетит два подряд - обработается один
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthAuthorizedState && runtimeType == other.runtimeType;
  
  @override 
  int get hashCode => 0;
  
}

class AuthNotAuthorizedState extends AuthState{
  @override // означает, что два авторизованных стейта будут равны, если это один и тот же объект/класс. Если прилетит два подряд - обработается один
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthNotAuthorizedState && runtimeType == other.runtimeType;
  
  @override 
  int get hashCode => 0;
}

class AuthFailState extends AuthState {
  final Object error;
  AuthFailState(this.error);

  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthFailState && 
      runtimeType == other.runtimeType &&
      error == other.error;
  
  @override 
  int get hashCode => error.hashCode;
}

class AuthInProgressState extends AuthState {
  @override
    bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthInProgressState && runtimeType == other.runtimeType;
  
  @override 
  int get hashCode => 0;
}

class AuthCheckStatusInProgressState extends AuthState {
  @override
    bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthCheckStatusInProgressState && runtimeType == other.runtimeType;
  
  @override 
  int get hashCode => 0;
}



class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  AuthBloc(AuthState initialState) : super(initialState) {

    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    },
    transformer: sequential()
    );
    add(AuthCheckStatusEvent());
  }


  Future<void> onAuthCheckStatusEvent(AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProgressState());
    final sessionId = await _sessionDataProvider.getSessionId();
        final newState = sessionId != null ? AuthAuthorizedState() : AuthNotAuthorizedState();
        emit(newState);
  }

    Future<void> onAuthLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgressState());
      final sessionId = await _authApiClient.auth(
        username: event.login, 
        password: event.password,
      );
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
      } catch (e) {
        emit(AuthFailState(e));
      }
  }

    Future<void> onAuthLogoutEvent(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
          await _sessionDataProvider.deleteSessionId();
          await _sessionDataProvider.deleteAccountId();
        }
        catch (e) {
          emit(AuthFailState(e));
        }
  }
}
