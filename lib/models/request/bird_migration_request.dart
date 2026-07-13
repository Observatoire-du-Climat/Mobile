import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';

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