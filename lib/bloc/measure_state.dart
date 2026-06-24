import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/snow_height.dart';
import 'package:mobile/models/temperature.dart';

abstract class MeasureState {}

// GET LIST OF MEASURES FOR HISTORY PAGE

class MeasuresNotFetched extends MeasureState {}

class MeasuresLoading extends MeasureState {}

class MeasuresFetched extends MeasureState {
  final List<Measure> measures;

  MeasuresFetched(this.measures);

}

class MeasuresFetchedEmpty extends MeasureState {}

class MeasuresError extends MeasureState {
  final String message;

  MeasuresError(this.message);
}


// CREATE MEASURE

class MeasureCreationLoading extends MeasureState {}

class MeasureCreated extends MeasureState {}

class MeasureCreationError extends MeasureState {
  final String message;

  MeasureCreationError(this.message);
}

// LOAD MEASURE DETAILS FOR HISTORY PAGE

class MeasureDetailsLoading extends MeasureState {}

class TemperatureDetailsFetched extends MeasureState {
  Temperature measure;

  TemperatureDetailsFetched(this.measure);
}

class SnowHeightDetailsFetched extends MeasureState {
  SnowHeight measure;

  SnowHeightDetailsFetched(this.measure);
}

class BirdMigrationDetailsFetched extends MeasureState {
  BirdMigration measure;

  BirdMigrationDetailsFetched(this.measure);
}

class EggsLayingDetailsFetched extends MeasureState {
  EggsLaying measure;

  EggsLayingDetailsFetched(this.measure);
}

class MeasureDetailsError extends MeasureState {
  final String message;

  MeasureDetailsError(this.message);
}

