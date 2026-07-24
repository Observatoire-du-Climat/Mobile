import 'package:mobile/web_providers/user_provider.dart';

/// Repository responsible for user operations.
///
/// This repository acts as an abstraction between the business logic and the web provider.
class UserRepository {

  final UserProvider userProvider;

  UserRepository(this.userProvider);

  /// Retrieves the current user data.
  Future getCurrentUser() => userProvider.getCurrentUser();

  /// Creates a new user
  Future createUser(String name, String email, String password) => userProvider.createUser(name, email, password);

  /// Authenticate as a user in the application.
  Future loginUser(String email, String password) => userProvider.loginUser(email, password);

  /// Log out.
  Future logout() => userProvider.logout();

  /// Update the current user.
  Future updateUser(String name, String email, String password) => userProvider.updateUser(name, email, password);

}