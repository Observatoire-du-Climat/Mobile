import 'package:mobile/models/enum/measure_type.dart';

class Measure {
  final int id;
  final DateTime date;
  final String location;
  final MeasureType type;

  Measure({
    required this.id,
    required this.date,
    required this.location,
    required this.type
  });

  factory Measure.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id, 'date' : String date, 'location' : String location, 'type' : String type} => Measure(
        id: id,
        date: DateTime.parse(date),
        location: location,
        type: MeasureType.values.byName(type.toLowerCase())
      ),
      _ => throw const FormatException('Failed to load Measure')
    };
  }
}