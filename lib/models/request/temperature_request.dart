import 'package:mobile/models/temperature.dart';

/// Request sent to the web server when creating a new temperature measure.
///
/// It is part of the multipart request under the label 'request'.
class TemperatureRequest {
  final int userId;
  final DateTime date;
  final String location;
  final int degree;

  TemperatureRequest({
    required this.userId,
    required this.date,
    required this.location,
    required this.degree
  });

  /// Creates a JSON object from a [Temperature].
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first, //to have only the date
      'location': location,
      'degree': degree,
    };
  }
}