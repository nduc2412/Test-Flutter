class AuthUserEntity {
  final String id;
  final String email;
  final bool isEmailVerified;
  AuthUserEntity({required this.id, required this.email, required this.isEmailVerified});
}