import 'package:atemkraft/features/auth/domain/entity/user_entity.dart';
import 'package:atemkraft/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'auth_bloc_events.dart';
part 'auth_bloc_states.dart';

class AuthBloc extends Bloc<AuthBlocEvents, AuthBlocStates> {
  LoginUseCase loginUseCase;
  SignUpUseCase signUpUseCase;

  AuthBloc(this.loginUseCase, this.signUpUseCase) : super(AuthBlocInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
  }
  _onLogin(LoginEvent event, Emitter<AuthBlocStates> emit) async {
    emit(LoginLoading());

    Either<Failure, UserCredential> response =
        await loginUseCase(event.payload);

    response.fold(
        (Failure failure) =>
            emit(LoginFailure(errorMessage: failure.errorMessage)),
        (UserCredential success) =>
            emit(LoginSuccess(userCredential: success)));
  }

  _onSignUp(SignUpEvent event, Emitter<AuthBlocStates> emit) async {
    emit(SignUpLoading());

    Either<Failure, UserCredential> response =
        await signUpUseCase(event.payload);

    response.fold(
        (Failure failure) =>
            emit(SignUpFailure(errorMessage: failure.errorMessage)),
        (UserCredential success) =>
            emit(SignUpSuccess(userCredential: success)));
  }
}
