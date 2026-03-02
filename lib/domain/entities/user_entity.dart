class AuthUserEntity {
  final String id;
  final String email;
  final bool isEmailVerified;
  final String userName;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> favourite;

  AuthUserEntity({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.favourite,
  });
}
