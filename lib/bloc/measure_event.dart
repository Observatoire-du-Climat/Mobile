abstract class MeasureEvent {}

class UserMeasureRequest extends MeasureEvent {}

class CreateTemperatureRequest extends MeasureEvent {
  final DateTime date;
  final String location;
  final int degree;

  CreateTemperatureRequest({
    required this.date,
    required this.location,
    required this.degree
  });
}