import 'package:mobile/models/bird_migration.dart';

/// Enumeration of all the different bird species supported by the application.
///
/// it is used in a [BirdMigration] Measure.
/// Each specie is associated with its French-translated readable label.
enum BirdSpecie {
  swallow('Hirondelles'),
  swift('Martinets');

  final String label;
  const BirdSpecie(this.label);
}

