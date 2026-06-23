import 'package:mobile/models/measure.dart';

class EggsLaying extends Measure{

  final int number;

  EggsLaying({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.number,
  });

  factory EggsLaying.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id,
      'date' : String date,
      'location' : String location,
      'type' : String type,
      'number' : int number} => EggsLaying(
          id: id,
          date: DateTime.parse(date),
          location: location,
          type: type,
          number: number,
      ),
      _ => throw const FormatException('Failed to load EggsLaying measure')
    };
  }
}