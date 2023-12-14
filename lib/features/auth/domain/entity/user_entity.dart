class AuthPayload {
  final String? fullName;
  final String email;
  final String password;

  AuthPayload({required this.email, required this.password, this.fullName});
}
