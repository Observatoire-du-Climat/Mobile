import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/secure_storage.dart';


class MeasureProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];
  final SecureStorage storage;
  final dateFormat = DateFormat('yyyy-MM-dd');
  
  MeasureProvider(this.storage);
  
  Future<List<Measure>> getUserMeasures() async {
    final String? userId = await storage.getUserId();
    if (userId == null) {
      throw Exception('No user connected');
    }
    
    final response = await http.get(Uri.parse('$apiUrl/measures/user/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['measures'].map((m) => Measure.fromJson(m)).toList();
    } else {
      throw Exception('Failed to fetch measures');
    }
  }

  //get one measure in details

  Future<Temperature> createTemperature(DateTime date, String location, int degree) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.post(
          Uri.parse('$apiUrl/measures/temperature'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'userId': userId,
            'date': dateFormat.format(date),
            'location': location,
            'degree': degree
          })
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 201) {
        final temperature = Temperature.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return temperature;
      } else {
        throw Exception('Failed to create Temperature measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }


}