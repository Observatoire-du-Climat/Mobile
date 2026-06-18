import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/user.dart';


class UserProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];

  Future<User> getUser(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/users/0'));

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
      print("reponse recue");
      print(response);

      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to login');
    }

  }

}