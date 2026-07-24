import 'dart:io';

import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/web_providers/measure_provider.dart';

/// Repository responsible for measure operations.
///
/// This repository acts as an abstraction between the business logic and the web provider.
class MeasureRepository {

  final MeasureProvider measureProvider;

  MeasureRepository(this.measureProvider);

  /// Retrieves all measurements submitted by the connected user.
  Future getUserMeasures() => measureProvider.getUserMeasures();

  /// Retrieves a specific measure.
  Future getSingleMeasure(int id) => measureProvider.getSingleMeasure(id);

  /// Creates a temperature measure with an optional picture.
  Future createTemperature(DateTime date, String location, int degree, File? picture) =>
      measureProvider.createTemperature(date, location, degree, picture);

  /// Creates a snow height measure with an optional picture.
  Future createSnowHeight(DateTime date, String location, int height, WeatherType weather, int precipitation, File? picture) =>
      measureProvider.createSnowHeight(date, location, height, weather, precipitation, picture);

  /// Creates a bird migration measure with an optional picture.
  Future createBirdMigration(DateTime date, String location, BirdSpecie specie, BirdEventType event, File? picture) =>
      measureProvider.createBirdMigration(date, location, specie, event, picture);

  /// Creates a eggs laying measure with an optional picture.
  Future createEggsLaying(DateTime date, String location, int number, File? picture) =>
      measureProvider.createEggsLaying(date, location, number, picture);

  /// Updates a temperature measure.
  Future updateTemperature(int measureId, DateTime date, String location, int degree) =>
      measureProvider.updateTemperature(measureId, date, location, degree);

  /// Updates a snow height measure.
  Future updateSnowHeight(int measureId, DateTime date, String location, int height, WeatherType weather, int precipitation) =>
    measureProvider.updateSnowHeight(measureId, date, location, height, weather, precipitation);

  /// Updates a bird migration measure.
  Future updateBirdMigration(int measureId, DateTime date, String location, BirdSpecie specie, BirdEventType event) =>
    measureProvider.updateBirdMigration(measureId, date, location, specie, event);

  /// Updates a eggs laying measure.
  Future updateEggsLaying(int measureId, DateTime date, String location, int number) =>
    measureProvider.updateEggsLaying(measureId, date, location, number);

  /// Delete a specific measure
  Future deleteMeasure(int measureId) => measureProvider.deleteMeasure(measureId);
}