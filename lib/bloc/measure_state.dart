import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/snow_height.dart';
import 'package:mobile/models/temperature.dart';

/// Base class for all measurement-related states.
abstract class MeasureState {}

// GET LIST OF MEASURES FOR HISTORY PAGE

/// Initial state before measures have been requested.
class MeasuresNotFetched extends MeasureState {}

/// Indicates that the measure history retrieval is currently loading.
class MeasuresLoading extends MeasureState {}

/// Indicates that the measure history retrieval was successful.
class MeasuresFetched extends MeasureState {
  final List<Measure> measures;

  MeasuresFetched(this.measures);
}

/// Indicates that the connected user has no measure in his history.
class MeasuresFetchedEmpty extends MeasureState {}

/// Indicates that the measure history could not be retrieved.
class MeasuresError extends MeasureState {
  final String message;

  MeasuresError(this.message);
}


// CREATE MEASURE

/// Indicates that a new measure is currently being created.
class MeasureCreationLoading extends MeasureState {}

/// Indicates that the new measure have been created.
class MeasureCreated extends MeasureState {}

/// Indicates that the new measure could be created.
class MeasureCreationError extends MeasureState {
  final String message;

  MeasureCreationError(this.message);
}

// LOAD MEASURE DETAILS FOR HISTORY PAGE

/// Indicates that a measure data retrieval is currently loading.
class MeasureDetailsLoading extends MeasureState {}

/// Indicates that a temperature data retrieval has been successful.
class TemperatureDetailsFetched extends MeasureState {
  Temperature measure;

  TemperatureDetailsFetched(this.measure);
}

/// Indicates that a snow height data retrieval has been successful.
class SnowHeightDetailsFetched extends MeasureState {
  SnowHeight measure;

  SnowHeightDetailsFetched(this.measure);
}

/// Indicates that a bird migration data retrieval has been successful.
class BirdMigrationDetailsFetched extends MeasureState {
  BirdMigration measure;

  BirdMigrationDetailsFetched(this.measure);
}

/// Indicates that a eggs laying data retrieval has been successful.
class EggsLayingDetailsFetched extends MeasureState {
  EggsLaying measure;

  EggsLayingDetailsFetched(this.measure);
}

/// Indicates that a measure data could not be retrieved.
class MeasureDetailsError extends MeasureState {
  final String message;

  MeasureDetailsError(this.message);
}

// UPDATE MEASURE

/// Indicates that a measure data update is currently loading.
class MeasureUpdateLoading extends MeasureState {}

/// Indicates that a measure data has been updated successfully.
class MeasureUpdated extends MeasureState {}

/// Indicates that a measure data retrieval could not be updated.
class MeasureUpdateError extends MeasureState {
  final String message;

  MeasureUpdateError(this.message);
}

// DELETE MEASURE

/// Indicates that a measure is currently being deleted.
class MeasureDeleteLoading extends MeasureState {}

/// Indicates that a measure has been deleted successfully.
class MeasureDeleted extends MeasureState {}

/// Indicates that a measure could not be deleted.
class MeasureDeleteError extends MeasureState {
  final String message;

  MeasureDeleteError(this.message);
}