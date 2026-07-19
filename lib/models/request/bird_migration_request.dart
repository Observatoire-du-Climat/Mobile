import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';

/// Request sent to the web server when creating a new bird migration measure.
///
/// It is part of the multipart request under the label 'request'.
class BirdMigrationRequest {
  final int userId;
  final DateTime date;
  final String location;
  final BirdSpecie specie;
  final BirdEventType event;

  BirdMigrationRequest({
    required this.userId,
    required this.date,
    required this.location,
    required this.specie,
    required this.event
  });

  /// Creates a JSON object from a [BirdMigration].
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first, //to have only the date
      'location': location,
      'specie': specie.name,
      'event': event.name
    };
  }
}