part of 'auth_bloc.dart';

abstract class AuthBlocEvents extends Equatable {
  const AuthBlocEvents();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthBlocEvents {
  final AuthPayload payload;

  const LoginEvent({required this.payload});

}

class SignUpEvent extends AuthBlocEvents {
  final AuthPayload payload;

  const SignUpEvent({required this.payload});
}
