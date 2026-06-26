abstract class UserEvent {}

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

class LoginRequest extends UserEvent {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password
  });
}

class UserRequest extends UserEvent {}

class LogoutRequest extends UserEvent {}