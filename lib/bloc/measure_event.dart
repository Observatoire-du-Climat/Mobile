import 'package:mobile/models/enum/weather_type.dart';

abstract class MeasureEvent {}

class UserMeasureRequest extends MeasureEvent {}

class CreateTemperatureRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int degree;

  CreateTemperatureRequest({
    required this.date,
    required this.location,
    required this.degree
  });
}

class CreateSnowHeightRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int height;
  final WeatherType weather;
  final int precipitation;

  CreateSnowHeightRequest({
    required this.date,
    required this.location,
    required this.height,
    required this.weather,
    required this.precipitation
  });
}