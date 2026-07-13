class User {
  final int id;
  final String name;
  final String email;
  final bool isValid;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.isValid
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name, 'email': String email, 'isValid': bool isValid} => User(
        id: id,
        name: name,
        email: email,
        isValid: isValid
      ),
      _ => throw const FormatException('Failed to load User.')
    };
  }
}