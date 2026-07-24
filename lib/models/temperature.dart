import 'package:mobile/models/measure.dart';

import 'enum/measure_type.dart';

/// Represents a temperature measure.
///
/// It is a subclass of [Measure]. It contains the additionary value of a temperature measurement.
class Temperature extends Measure {

  final int degree;

  Temperature({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.degree
  });

  /// Create a [Temperature] from a JSON object
  ///
  /// Throws a [FormatException] if the JSON object does not contain all the expected values
  factory Temperature.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id, 'date' : String date, 'location' : String location, 'type' : String type, 'degree' : int degree} => Temperature(
          id: id,
          date: DateTime.parse(date),
          location: location,
          type: MeasureType.values.byName(type.toLowerCase()),
          degree : degree
      ),
      _ => throw const FormatException('Failed to load Temperature measure')
    };
  }
}