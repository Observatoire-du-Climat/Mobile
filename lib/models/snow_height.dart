import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/models/measure.dart';

import 'enum/measure_type.dart';

/// Represents a SnowHeight measure
///
/// It is a subclass of [Measure]. It contains the additionary values of a snow height measurement.
class SnowHeight extends Measure{

  final int height;
  final WeatherType weather;
  final int precipitation;

  SnowHeight({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.height,
    required this.weather,
    required this.precipitation
  });

  /// Create a [SnowHeight] from a JSON object
  ///
  /// Throws a [FormatException] if the JSON object does not contain all the expected values
  factory SnowHeight.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id,
      'date' : String date,
      'location' : String location,
      'type' : String type,
      'height' : int height,
      'weather' : String weather,
      'precipitation' : int precipitation} => SnowHeight(
          id: id,
          date: DateTime.parse(date),
          location: location,
          type: MeasureType.values.byName(type.toLowerCase()),
          height: height,
          weather: WeatherType.values.byName(weather.toLowerCase()),
          precipitation: precipitation
      ),
      _ => throw const FormatException('Failed to load SnowHeight measure')
    };
  }
}