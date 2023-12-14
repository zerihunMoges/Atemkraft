part of 'auth_bloc.dart';

abstract class AuthBlocStates extends Equatable {
  const AuthBlocStates();

  @override
  List<Object> get props => [];
}

class AuthBlocInitial extends AuthBlocStates {}

class LoginLoading extends AuthBlocStates {}

class SignUpLoading extends AuthBlocStates {}

class LoginFailure extends AuthBlocStates {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
}

class SignUpFailure extends AuthBlocStates {
  final String errorMessage;

  const SignUpFailure({required this.errorMessage});
}

class LoginSuccess extends AuthBlocStates {
  final UserCredential userCredential;

  const LoginSuccess({required this.userCredential});
}

class SignUpSuccess extends AuthBlocStates {
  final UserCredential userCredential;

  const SignUpSuccess({required this.userCredential});
}
