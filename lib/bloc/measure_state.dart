import 'package:mobile/models/measure.dart';

abstract class MeasureState {}

class MeasureNotFetched extends MeasureState {}

class MeasureLoading extends MeasureState {}

class MeasureFetched extends MeasureState {
  final List<Measure> measures;

  MeasureFetched(this.measures);

}

class MeasureFetchedEmpty extends MeasureState {}

class MeasureError extends MeasureState {
  final String message;

  MeasureError(this.message);
}


class MeasureCreationLoading extends MeasureState {}

class MeasureCreated extends MeasureState {}

class MeasureCreationError extends MeasureState {
  final String message;

  MeasureCreationError(this.message);
}