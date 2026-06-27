abstract class UserState {}

class UserNotConnected extends UserState {}

class UserLoading extends UserState {}

class UserConnected extends UserState {
  final String name;
  final String email;

  UserConnected({
    required this.name,
    required this.email
  });
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserDisconnected extends UserState {}

class UserUpdated extends UserState {}