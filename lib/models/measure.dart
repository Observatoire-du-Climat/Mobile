import 'package:mobile/models/enum/measure_type.dart';

/// Represent the superclass of a climate measure
///
/// It contains all the global data shared by all measure types.
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

  /// Create a [Measure] from a JSON object
  ///
  /// Throws a [FormatException] if the JSON object does not contain all the expected values
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