import 'package:mobile/models/snow_height.dart';

/// Enumeration of all different weather condition supported by the application.
///
/// it is used in a [SnowHeight] Measure.
/// Each measure is associated with its French-translated readable label.
enum WeatherType {
  sunny('Soleil'),
  cloudy('Nuageux'),
  rainy('Pluie'),
  snowy('Neige'),
  windy('Venteux');

  final String label;
  const WeatherType(this.label);
}