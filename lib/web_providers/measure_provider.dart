import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/snow_height.dart';
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
    print('response code :  ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      //return json.decode(response.body).map((m) => Measure.fromJson(m)).toList();
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded
          .map((m) => Measure.fromJson(m as Map<String, dynamic>))
          .toList();
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

      print('response code : ${response.statusCode}');
      print(response);

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

  Future<SnowHeight> createSnowHeight(DateTime date, String location, int height, WeatherType weather, int precipitation) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.post(
          Uri.parse('$apiUrl/measures/snow-height'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'userId': userId,
            'date': dateFormat.format(date),
            'location': location,
            'height': height,
            'weather': weather.name,
            'precipitation': precipitation
          })
      ).timeout(Duration(seconds: 10));

      print('response code : ${response.statusCode}');
      print(response);

      if (response.statusCode == 201) {
        final snowHeight = SnowHeight.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return snowHeight;
      } else {
        throw Exception('Failed to create Temperature measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }


}