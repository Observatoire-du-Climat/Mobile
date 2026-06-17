import 'package:mobile/web_providers/user_provider.dart';

class UserRepository {

  final userProvider = UserProvider();

  Future getUser(int id) => userProvider.getUser(id);

  Future createUser(String name, String email, String password) => userProvider.createUser(name, email, password);

  Future loginUser(String email, String password) => userProvider.loginUser(email, password);

}