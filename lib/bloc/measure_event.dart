import 'dart:io';

import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/models/enum/weather_type.dart';

/// Base class for all measure-related events
abstract class MeasureEvent {}

/// Requests all measure submitted by the connected user.
class UserMeasureRequest extends MeasureEvent {}

/// Requests the creation of a temperature measure.
class CreateTemperatureRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int degree;
  final File? picture;

  CreateTemperatureRequest({
    required this.date,
    required this.location,
    required this.degree,
    required this.picture
  });
}

/// Requests the creation of a snow height measure.
class CreateSnowHeightRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int height;
  final WeatherType weather;
  final int precipitation;
  final File? picture;

  CreateSnowHeightRequest({
    required this.date,
    required this.location,
    required this.height,
    required this.weather,
    required this.precipitation,
    required this.picture
  });
}

/// Requests the creation of a bird migration measure.
class CreateBirdMigrationRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final BirdSpecie specie;
  final BirdEventType event;
  final File? picture;

  CreateBirdMigrationRequest({
    required this.date,
    required this.location,
    required this.specie,
    required this.event,
    required this.picture
  });
}

/// Requests the creation of a eggs laying measure.
class CreateEggsLayingRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int number;
  final File? picture;

  CreateEggsLayingRequest({
    required this.date,
    required this.location,
    required this.number,
    required this.picture
  });
}

/// Requests a specific measure.
class MeasureDetailsRequest extends MeasureEvent {
  final int measureId;

  MeasureDetailsRequest({
    required this.measureId
  });
}

/// Requests the update of a temperature measure.
class UpdateTemperatureRequest extends MeasureEvent {
  final int measureId;
  final DateTime date;
  final String location;
  final int degree;

  UpdateTemperatureRequest({
    required this.measureId,
    required this.date,
    required this.location,
    required this.degree
  });
}

/// Requests the update of a snow height measure.
class UpdateSnowHeightRequest extends MeasureEvent {
  final int measureId;
  final DateTime date;
  final String location;
  final int height;
  final WeatherType weather;
  final int precipitation;

  UpdateSnowHeightRequest({
    required this.measureId,
    required this.date,
    required this.location,
    required this.height,
    required this.weather,
    required this.precipitation
  });
}

/// Requests the update of a bird migration measure.
class UpdateBirdMigrationRequest extends MeasureEvent {
  final int measureId;
  final DateTime date;
  final String location;
  final BirdSpecie specie;
  final BirdEventType event;

  UpdateBirdMigrationRequest({
    required this.measureId,
    required this.date,
    required this.location,
    required this.specie,
    required this.event
  });
}

/// Requests the update of a eggs laying measure.
class UpdateEggsLayingRequest extends MeasureEvent {
  final int measureId;
  final DateTime date;
  final String location;
  final int number;

  UpdateEggsLayingRequest({
    required this.measureId,
    required this.date,
    required this.location,
    required this.number
  });
}

/// Requests the deletion of a measure.
class DeleteMeasureRequest extends MeasureEvent {
  final int measureId;

  DeleteMeasureRequest({
    required this.measureId
  });
}