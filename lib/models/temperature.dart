import 'package:mobile/models/measure.dart';

import 'enum/measure_type.dart';

class Temperature extends Measure {

  final int degree;

  Temperature({
    required super.id,
    required super.date,
    required super.location,
    required super.type,
    required this.degree
  });

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