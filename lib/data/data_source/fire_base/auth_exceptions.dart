// Login exception
class UserNotFound implements AuthException {}
class WrongPassword implements AuthException {}
class InvalidEmail implements AuthException {}
class UserDisabled implements AuthException {}
// Register exception
class WeakPassword implements AuthException {}
class UserAlreadyExists implements AuthException {}
// Not have user
class UserNotLogIn implements AuthException {}
// Send password change exception
class MissingEmail implements AuthException {}
//Send email verification exception
class TooManyRequest implements AuthException {}
class InvalidRecipientEmail implements AuthException {}
// Forgot password exception
class InvalidEmailForgotPassword implements AuthException {}
// Generic exception
class GenericException implements AuthException {}

class AuthException implements Exception {}