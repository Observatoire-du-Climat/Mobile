/// Base class for all user-related events
abstract class UserEvent {}

/// Requests the registration of a user.
class RegisterRequest extends UserEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password
  });
}

/// Requests the authentication of a user.
class LoginRequest extends UserEvent {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password
  });
}

/// Requests the retrieval of the connected user data.
class UserRequest extends UserEvent {}

/// Requests the log out of the current user.
class LogoutRequest extends UserEvent {}

/// Requests the update of the connected user data.
class UserUpdateRequest extends UserEvent {
  final String name;
  final String email;
  final String password;

  UserUpdateRequest({
    required this.name,
    required this.email,
    required this.password
  });
}