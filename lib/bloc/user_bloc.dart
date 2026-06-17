import 'dart:async';

import 'package:mobile/repositories/user_repository.dart';

class UserBloc {

  final _userRepository = UserRepository();
  final _userController = StreamController();
  get user => _userController.stream;

  UserBloc() {
    refreshUser();
  }

  refreshUser({int? id}) async {
    _userController.sink.add(await _userRepository.getUser(0));
  }

  addUser(String name, String email, String password) async {
    await _userRepository.createUser(name, email, password);
    refreshUser();
  }

}