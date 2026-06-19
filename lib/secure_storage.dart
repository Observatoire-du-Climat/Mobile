import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  final _storage = FlutterSecureStorage();

  Future<void> writeUserId(int id) async {
    print('new user id in storage : $id');
    await _storage.write(key: 'userId', value: id.toString());
  }

  Future<String?> getUserId() async {
    String? id = await _storage.read(key: 'userId');
    return id;
  }

  //ajout de token plus tard
}