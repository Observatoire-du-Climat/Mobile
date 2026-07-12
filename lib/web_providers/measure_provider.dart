import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/request/bird_migration_request.dart';
import 'package:mobile/models/request/eggs_laying_request.dart';
import 'package:mobile/models/request/snow_height_request.dart';
import 'package:mobile/models/request/temperature_request.dart';
import 'package:mobile/models/snow_height.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/utils/secure_storage.dart';


class MeasureProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];
  final SecureStorage storage;
  final http.Client client;
  final dateFormat = DateFormat('yyyy-MM-dd');
  
  MeasureProvider(this.storage, this.client);

  Future<http.Response> sendMultipart(String endpoint, Map<String, dynamic> jsonObject, File? picture) async {

    final request = http.MultipartRequest('POST', Uri.parse('$apiUrl/measures/$endpoint'));
    request.files.add(
      http.MultipartFile.fromString('request', jsonEncode(jsonObject), contentType: http.MediaType('application', 'json'))
    );
    if (picture != null) {
      request.files.add(
        await http.MultipartFile.fromPath('picture', picture.path)
      );
    }
    final response = await request.send();
    return http.Response.fromStream(response);

  }
  
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

  Future getSingleMeasure(int id) async {

    final response = await http.get(Uri.parse('$apiUrl/measures/$id'));
    print('response code :  ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      switch (body['type'] as String) {
        case 'TEMPERATURE':
          return Temperature.fromJson(body);
        case 'SNOW_HEIGHT':
          return SnowHeight.fromJson(body);
        case 'BIRD_MIGRATION':
          return BirdMigration.fromJson(body);
        case 'EGGS_LAYING':
          return EggsLaying.fromJson(body);
        default:
          throw Exception('Unknown measure type: ${body['type']}');
      }
    }else {
      throw Exception('Failed to fetch measure');
    }
  }

  Future<Temperature> createTemperature(DateTime date, String location, int degree, File? picture) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final request = TemperatureRequest(
        userId: int.parse(userId),
        date: date,
        location: location,
        degree: degree
      ).toJson();

      final response = await sendMultipart('temperature', request, picture);
      if (response.statusCode == 201) {
        final temperature = Temperature.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return temperature;
      } else {
        throw Exception('Failed to create Temperature measure');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SnowHeight> createSnowHeight(DateTime date, String location, int height, WeatherType weather, int precipitation, File? picture) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final request = SnowHeightRequest(
          userId: int.parse(userId),
          date: date,
          location: location,
          height: height,
          weather: weather,
          precipitation: precipitation
      ).toJson();

      final response = await sendMultipart('snow-height', request, picture);
      if (response.statusCode == 201) {
        final snowHeight = SnowHeight.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return snowHeight;
      } else {
        throw Exception('Failed to create SnowHeight measure');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<BirdMigration> createBirdMigration(DateTime date, String location, BirdSpecie specie, BirdEventType event, File? picture) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final request = BirdMigrationRequest(
          userId: int.parse(userId),
          date: date,
          location: location,
          specie: specie,
          event: event
      ).toJson();

      final response = await sendMultipart('bird-migration', request, picture);
      if (response.statusCode == 201) {
        final birdMigration = BirdMigration.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return birdMigration;
      } else {
        throw Exception('Failed to create BirdMigration measure');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<EggsLaying> createEggsLaying(DateTime date, String location, int number, File? picture) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final request = EggsLayingRequest(
          userId: int.parse(userId),
          date: date,
          location: location,
          number: number
      ).toJson();

      final response = await sendMultipart('eggs-laying', request, picture);
      if (response.statusCode == 201) {
        final eggsLaying = EggsLaying.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return eggsLaying;
      } else {
        throw Exception('Failed to create EggsLaying measure');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Temperature> updateTemperature(int measureId, DateTime date, String location, int degree) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.put(
          Uri.parse('$apiUrl/measures/temperature/$measureId'),
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

      if (response.statusCode == 200) {
        final temperature = Temperature.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return temperature;
      } else {
        throw Exception('Failed to update Temperature measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<SnowHeight> updateSnowHeight(int measureId, DateTime date, String location, int height, WeatherType weather, int precipitation) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.put(
          Uri.parse('$apiUrl/measures/snow-height/$measureId'),
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

      if (response.statusCode == 200) {
        final snowHeight = SnowHeight.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return snowHeight;
      } else {
        throw Exception('Failed to update SnowHeight measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<BirdMigration> updateBirdMigration(int measureId, DateTime date, String location, BirdSpecie specie, BirdEventType event) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.put(
          Uri.parse('$apiUrl/measures/bird-migration/$measureId'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'userId': userId,
            'date': dateFormat.format(date),
            'location': location,
            'specie': specie.name,
            'event': event.name,
          })
      ).timeout(Duration(seconds: 10));

      print('response code : ${response.statusCode}');
      print(response);

      if (response.statusCode == 200) {
        final birdMigration = BirdMigration.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return birdMigration;
      } else {
        throw Exception('Failed to update BirdMigration measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<EggsLaying> updateEggsLaying(int measureId, DateTime date, String location, int number) async {
    try {
      final String? userId = await storage.getUserId();
      if (userId == null) {
        throw Exception('No user connected');
      }

      final response = await http.put(
          Uri.parse('$apiUrl/measures/eggs-laying/$measureId'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, dynamic>{
            'userId': userId,
            'date': dateFormat.format(date),
            'location': location,
            'number': number
          })
      ).timeout(Duration(seconds: 10));

      print('response code : ${response.statusCode}');
      print(response);

      if (response.statusCode == 200) {
        final eggsLaying = EggsLaying.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        return eggsLaying;
      } else {
        throw Exception('Failed to update EggsLaying measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> deleteMeasure(int measureId) async {
    try {
      final response = await http.delete(
          Uri.parse('$apiUrl/measures/$measureId')
      ).timeout(Duration(seconds: 10));

      print('response code : ${response.statusCode}');
      print(response);

      if (response.statusCode != 204) {
        throw Exception('Failed to delete Temperature measure');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

}