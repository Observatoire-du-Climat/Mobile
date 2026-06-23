import 'package:mobile/models/enum/bird_event_type.dart';
import 'package:mobile/models/enum/bird_specie.dart';
import 'package:mobile/models/measure.dart';

class BirdMigration extends Measure {
  final BirdSpecie specie;
  final BirdEventType event;

  BirdMigration({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.specie,
    required this.event
  });

  factory BirdMigration.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id,
      'date' : String date,
      'location' : String location,
      'type' : String type,
      'specie' : String weather,
      'event' : String event} => BirdMigration(
          id: id,
          date: DateTime.parse(date),
          location: location,
          type: type,
          specie: BirdSpecie.values.byName(weather.toLowerCase()),
          event: BirdEventType.values.byName(event.toLowerCase())
      ),
      _ => throw const FormatException('Failed to load BirdMigration measure')
    };
  }
}