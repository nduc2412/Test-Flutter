// Login exception
class UserNotFound implements Exception {}
class WrongPassword implements Exception {}
class InvalidEmail implements Exception {}
class UserDisabled implements Exception {}
// Register exception
class WeakPassword implements Exception {}
class UserAlreadyExists implements Exception {}
// Not have user
class UserNotLogIn implements Exception {}
// Generic exception
class GenericException implements Exception {}