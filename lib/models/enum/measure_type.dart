/// Enumeration of all measurement type supported by the application.
///
/// Each measure type is associated with its French-translated readable label.
enum MeasureType {
  //snake case to fit enum in the backend
  temperature('Température'),
  snow_height('Hauteur des Neiges'),
  bird_migration('Migration des Oiseaux'),
  eggs_laying('Relevé des pontes');

  final String label;
  const MeasureType(this.label);
}