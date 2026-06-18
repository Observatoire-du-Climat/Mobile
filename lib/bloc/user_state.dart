abstract class UserState {}

class UserNotConnected extends UserState {}

class UserLoading extends UserState {}

class UserConnected extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}