import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/user.dart';
import 'package:mobile/utils/secure_storage.dart';

/// Provides remote access to user-related API endpoints.
///
/// This provider communicate with the web server to create User account and login to them,
/// as well as retrieving the current connected user data.
class UserProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];
  final SecureStorage storage;
  final http.Client client;

  UserProvider(this.storage, this.client);

  /// Retrieves the current connected user data.
  ///
  /// Returns the current [User].
  /// Throws an [Exception] if no user is connected or if the request failed
  Future<User> getCurrentUser() async {
    final String? userId = await storage.getUserId();
    if (userId == null) {
      throw Exception('No User connected');
    }

    final response = await client.get(Uri.parse('$apiUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch user');
    }

  }

  /// Create a new user.
  ///
  /// The id of the new user is written in the [SecureStorage] to use it in other methods.
  /// Returns the new [User].
  /// Throws an [Exception] if the creation failed.
  Future<User> createUser(String name, String email, String password) async {
    try {
      String uri = '$apiUrl/register';

      final response = await client.post(
          Uri.parse(uri),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password
          })).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        storage.writeUserId(user.id);
        return user;
      } else {
        throw Exception('Failed to create user');
      }

    } catch (e) {
      throw Exception();
    }
  }

  /// Authenticate as a user.
  ///
  /// The id of the user is written in the [SecureStorage] to use it in other methods.
  /// Returns the [User].
  /// Throws an [Exception] if the login failed.
  Future<User> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json',},
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      storage.writeUserId(user.id);
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

  /// Log out
  ///
  /// It deletes the user id in the [SecureStorage]
  Future<void> logout() async {
    await storage.deleteUserId();
  }

  /// Update the current user.
  ///
  /// Returns the updated [User].
  /// Throws an [Exception] if the update failed.
  Future<User> updateUser(String name, String email, String password) async {
    final String? userId = await storage.getUserId();
    if (userId == null) {
      throw Exception('No User connected');
    }

    final response = await client.put(
        Uri.parse('$apiUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password
        })).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

}