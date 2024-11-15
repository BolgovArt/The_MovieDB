import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vk/domain/blocks/auth_bloc.dart';

enum LoaderViewCubitState {unknown, authorized, notAuthorized}

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription; 
  LoaderViewCubit(
    LoaderViewCubitState initialState,
    this.authBloc,
    ) : super(initialState) {
      Future.microtask(
        () {
          _onState(authBloc.state);
          authBlocSubscription = authBloc.stream.listen(_onState);
          authBloc.add(AuthCheckStatusEvent());
        }
      );
    }

  // кубит переключает состояние 
  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthNotAuthorizedState) {
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}