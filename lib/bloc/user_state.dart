abstract class UserState {}

class UserNotConnected extends UserState {}

class UserLoading extends UserState {}

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

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserDisconnected extends UserState {}

class UserUpdated extends UserState {}