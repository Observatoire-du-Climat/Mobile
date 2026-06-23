import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/models/enum/weather_type.dart';
import 'package:mobile/web_providers/measure_provider.dart';

class MeasureRepository {

  final MeasureProvider measureProvider;

  MeasureRepository(this.measureProvider);

  Future getUserMeasures() => measureProvider.getUserMeasures();

  Future createTemperature(DateTime date, String location, int degree) =>
      measureProvider.createTemperature(date, location, degree);

  Future createSnowHeight(DateTime date, String location, int height, WeatherType weather, int precipitation) =>
      measureProvider.createSnowHeight(date, location, height, weather, precipitation);

  Future createBirdMigration(DateTime date, String location, BirdSpecie specie, BirdEventType event) =>
      measureProvider.createBirdMigration(date, location, specie, event);

  Future createEggsLaying(DateTime date, String location, int number) =>
      measureProvider.createEggsLaying(date, location, number);
}