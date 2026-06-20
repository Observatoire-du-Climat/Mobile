import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/measure.dart';
import 'package:mobile/secure_storage.dart';


class MeasureProvider {

  final apiUrl = dotenv.env['BASE_API_URL'];
  final SecureStorage storage;
  
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
}