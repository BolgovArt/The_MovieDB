import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vk/domain/api_client/api_client_exception.dart';
import 'package:vk/domain/blocks/auth_bloc.dart';

// стейты не пересекаются, поэтому можно их разделить

abstract class AuthViewCubitState {}

class AuthViewCubitFormFillInProgressState extends AuthViewCubitState { 

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthViewCubitFormFillInProgressState && runtimeType == other.runtimeType;

    @override 
  int get hashCode => 0;
}

class AuthViewCubitErrorState extends AuthViewCubitState{
  final String? errorMessage;
  AuthViewCubitErrorState(this.errorMessage);
  
  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthViewCubitErrorState && runtimeType == other.runtimeType;

    @override 
  int get hashCode => 0;
}

class AuthViewCubitAuthInProgressState extends AuthViewCubitState{

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthViewCubitAuthInProgressState && runtimeType == other.runtimeType;

    @override 
  int get hashCode => 0;
}
class AuthViewCubitSuccessAuthState extends AuthViewCubitState{

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is AuthViewCubitSuccessAuthState && runtimeType == other.runtimeType;

    @override 
  int get hashCode => 0;
}

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription; 
  AuthViewCubit(
    AuthViewCubitState initialState,
    this.authBloc,
    ) : super(initialState) {
      authBloc.add(AuthCheckStatusEvent());
      _onState(authBloc.state);
      authBlocSubscription = authBloc.stream.listen(_onState);
    }

    bool _isValid(String login, String password) => 
    login.isNotEmpty || password.isNotEmpty;

    void authorization({required String login, required String password}) {
      if (!_isValid(login, password)) { // если не валиден
        final state = AuthViewCubitErrorState('Заполните логин и пароль');
        emit(state);
        return;
      }
      // emit(AuthViewCubitState(null, true)); // все окей
      authBloc.add(AuthLoginEvent(login: login, password: password));
    }

    void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(AuthViewCubitSuccessAuthState());
      authBlocSubscription.cancel(); // два виджета работают одновременно. Прежде чем закрывается один экран, открывался другой, оба работали с AuthBloc и оба кидали в него эвенты. Тот блок слушал, начинал делать проверку авторизации, другой виджет подхватывает -> уход в бесконечную петлю. Поэтому здесь написана эта строчка
    } else if (state is AuthNotAuthorizedState) {
      emit(AuthViewCubitFormFillInProgressState()); // если не авторизован, пользователь может заполнить поле
    } else if (state is AuthFailState) {
      final message = _mapErrorToMessage(state.error);
      emit(AuthViewCubitErrorState(message));
    } else if (state is AuthInProgressState) {
      emit(AuthViewCubitAuthInProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(AuthViewCubitAuthInProgressState());
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiClientException) {
      return 'sessionId или accountId = null';
    }
    switch (error.type) {
        case ApiClientExceptionType.network:
          return 'Сервер недоступен. Проверьте подключение к интернету.';
        case ApiClientExceptionType.auth:
          return 'Неверный логин/пароль';
        case ApiClientExceptionType.other:
          return 'Произошла ошибка, попробуйте ещё раз.';
        case ApiClientExceptionType.sessionExpired:
          return 'Ошибка сессии';
      }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
