/// Base class for all user-related states.
abstract class UserState {}

/// Initial state before a was connected.
class UserNotConnected extends UserState {}

/// Indicates that a user is currently being connected.
class UserLoading extends UserState {}

/// Indicates that a user is connected successfully.
class UserConnected extends UserState {
  final String name;
  final String email;
  final bool isValid;

  UserConnected({
    required this.name,
    required this.email,
    required this.isValid
  });
}

/// Indicates that a user could not be connected.
class UserError extends UserState {
  final String message;

  UserError(this.message);
}

/// Indicates that a user has been disconnected.
class UserDisconnected extends UserState {}

/// Indicates that a user data was updated.
class UserUpdated extends UserState {}