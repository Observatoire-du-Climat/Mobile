import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provides a local secure storage.
///
/// It is used to store the connected user id to use this id in the rest of the application.
class SecureStorage {

  final _storage = FlutterSecureStorage();

  /// Store the id of the connected user.
  Future<void> writeUserId(int id) async {
    await _storage.write(key: 'userId', value: id.toString());
  }

  /// Returns the id the of the connected user.
  Future<String?> getUserId() async {
    String? id = await _storage.read(key: 'userId');
    return id;
  }

  /// Delete the id of the user when logged out.
  Future<void> deleteUserId() async {
    await _storage.delete(key: 'userId');
  }

}