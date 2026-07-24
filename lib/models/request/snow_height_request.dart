import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/models/snow_height.dart';

/// Request sent to the web server when creating a new snow height measure.
///
/// It is part of the multipart request under the label 'request'.
class SnowHeightRequest {
  final int userId;
  final DateTime date;
  final String location;
  final int height;
  final WeatherType weather;
  final int precipitation;

  SnowHeightRequest({
    required this.userId,
    required this.date,
    required this.location,
    required this.height,
    required this.weather,
    required this.precipitation
  });

  /// Creates a JSON object from a [SnowHeight].
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first, //to have only the date
      'location': location,
      'height': height,
      'weather': weather.name,
      'precipitation': precipitation
    };
  }
}