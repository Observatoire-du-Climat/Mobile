import 'package:mobile/models/measure.dart';

import 'enum/measure_type.dart';

/// Represents a EggsLaying measure
///
/// It is a subclass of [Measure]. It contains the additionary value of a eggs laying measurement.
class EggsLaying extends Measure{

  final int number;

  EggsLaying({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.number,
  });

  /// Create a [EggsLaying] from a JSON object
  ///
  /// Throws a [FormatException] if the JSON object does not contain all the expected values
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
          type: MeasureType.values.byName(type.toLowerCase()),
          number: number,
      ),
      _ => throw const FormatException('Failed to load EggsLaying measure')
    };
  }
}