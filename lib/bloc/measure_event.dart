import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
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

class CreateBirdMigrationRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final BirdSpecie specie;
  final BirdEventType event;

  CreateBirdMigrationRequest({
    required this.date,
    required this.location,
    required this.specie,
    required this.event
  });
}

class CreateEggsLayingRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int number;

  CreateEggsLayingRequest({
    required this.date,
    required this.location,
    required this.number
  });
}


class MeasureDetailsRequest extends MeasureEvent {
  final int measureId;

  MeasureDetailsRequest({
    required this.measureId
  });
}