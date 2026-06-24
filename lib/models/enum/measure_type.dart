enum MeasureType {
  temperature('Température'),
  snowHeight('Hauteur des Neiges'),
  birdMigration('Migration des Oiseaux'),
  eggsLaying('Relevé des pontes');

  final String label;
  const MeasureType(this.label);
}