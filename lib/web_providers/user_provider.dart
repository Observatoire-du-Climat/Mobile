import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/user.dart';
import 'package:mobile/utils/secure_storage.dart';


class UserProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];
  final SecureStorage storage;

  UserProvider(this.storage);

  Future<User> getCurrentUser() async {
    final String? userId = await storage.getUserId();
    if (userId == null) {
      throw Exception('No User connected');
    }

    final response = await http.get(Uri.parse('$apiUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch user');
    }

  }

  Future<User> createUser(String name, String email, String password) async {
    try {
      print("provider test creation");
      String uri = '$apiUrl/register';
      print('Uri : $uri');

      final response = await http.post(
          Uri.parse(uri),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password
          })).timeout(const Duration(seconds: 10));
      print("reponse recue : ${response.statusCode}");
      print(response);

      if (response.statusCode == 201) {
        final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        storage.writeUserId(user.id);
        return user;
      } else {
        throw Exception('Failed to create user');
      }

    } catch (e) {
      print("Exception");
      print(e);
      throw Exception();
    }


  }
  
  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json',},
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      print('reussite, status code : ${response.statusCode}');
      final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      storage.writeUserId(user.id);
      print(user);
      return user;
    } else {
      print("status code recu : ${response.statusCode}");
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    await storage.deleteUserId();
  }

  Future<User> updateUser(String name, String email, String password) async {
    final String? userId = await storage.getUserId();
    if (userId == null) {
      throw Exception('No User connected');
    }

    final response = await http.put(
        Uri.parse('$apiUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password
        })).timeout(const Duration(seconds: 10));
    print("reponse recue : ${response.statusCode}");
    print(response);

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return user;
    } else {
      print("status code recu : ${response.statusCode}");
      throw Exception('Failed to login');
    }
  }

}