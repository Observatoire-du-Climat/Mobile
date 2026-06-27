import 'package:mobile/web_providers/user_provider.dart';

class UserRepository {

  final UserProvider userProvider;

  UserRepository(this.userProvider);

  Future getCurrentUser() => userProvider.getCurrentUser();

  Future createUser(String name, String email, String password) => userProvider.createUser(name, email, password);

  Future loginUser(String email, String password) => userProvider.loginUser(email, password);

  Future logout() => userProvider.logout();

  Future updateUser(String name, String email, String password) => userProvider.updateUser(name, email, password);

}