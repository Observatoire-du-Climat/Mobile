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

//class LoginRequest
}