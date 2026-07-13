enum WeatherType {
  sunny('Soleil'),
  cloudy('Nuageux'),
  rainy('Pluie'),
  snowy('Neige'),
  windy('Venteux');

  final String label;
  const WeatherType(this.label);
}