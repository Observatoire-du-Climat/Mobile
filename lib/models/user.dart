/// Represents a User
///
/// It contains basic informations about a user in the application
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

  /// Create a [User] from a JSON object
  ///
  /// Throws a [FormatException] if the JSON object does not contain all the expected values
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