import 'package:mobile/models/bird_migration.dart';

/// Enumeration of all the event, arrival or departure, supported by the application.
///
/// it is used in a [BirdMigration] Measure.
/// Each event is associated with its French-translated readable label.
enum BirdEventType {
  arrival('Arrivée'),
  departure('Départ');

  final String label;
  const BirdEventType(this.label);
}