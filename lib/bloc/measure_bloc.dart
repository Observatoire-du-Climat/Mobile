import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/bird_migration.dart';
import 'package:mobile/models/eggs_laying.dart';
import 'package:mobile/models/enum/measure_type.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/snow_height.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/repositories/measure_repository.dart';

/// Handles measurement-related events and application states.
///
/// This BLoC coordinates measure retrieval, creation, update and suppression through the [MeasureRepository].
class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {

  final MeasureRepository _measureRepository;

  /// Creates a measurement BLoC and registers all supported event handlers.
  MeasureBloc(this._measureRepository) : super(MeasuresNotFetched()) {
    on<UserMeasureRequest>(_onUserMeasureRequest);
    on<CreateTemperatureRequest>(_onCreateTemperatureRequest);
    on<CreateSnowHeightRequest>(_onCreateSnowHeightRequest);
    on<CreateBirdMigrationRequest>(_onCreateBirdMigrationRequest);
    on<CreateEggsLayingRequest>(_onCreateEggsLayingRequest);
    on<MeasureDetailsRequest>(_onMeasureDetailsRequest);
    on<UpdateTemperatureRequest>(_onUpdateTemperatureRequest);
    on<UpdateSnowHeightRequest>(_onUpdateSnowHeightRequest);
    on<UpdateBirdMigrationRequest>(_onUpdateBirdMigrationRequest);
    on<UpdateEggsLayingRequest>(_onUpdateEggsLaying);
    on<DeleteMeasureRequest>(_onDeleteMeasureRequest);
  }

  /// Handles the retrieval of all the measures submitted by the current user.
  Future<void> _onUserMeasureRequest(UserMeasureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasuresLoading());

    try {
      List<Measure> measures = await _measureRepository.getUserMeasures();
      if (measures.isEmpty) {
        emit(MeasuresFetchedEmpty());
        return;
      }
      emit(MeasuresFetched(measures));
    } catch (e) {
      emit(MeasuresError('La récupération des mesures a échoué'));
    }
  }

  /// Handles the creation of a temperature measure.
  Future<void> _onCreateTemperatureRequest(CreateTemperatureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      await _measureRepository.createTemperature(request.date, request.location, request.degree, request.picture);
      emit(MeasureCreated());
    } catch (e) {
      emit(MeasureCreationError('La création a échoué'));
    }
  }

  /// Handles the creation of a snow height measure.
  Future<void> _onCreateSnowHeightRequest(CreateSnowHeightRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      await _measureRepository.createSnowHeight(request.date, request.location, request.height, request.weather, request.precipitation, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      emit(MeasureCreationError('La création a échoué'));
    }
  }

  /// Handles the creation of a bird migration measure.
  Future<void> _onCreateBirdMigrationRequest(CreateBirdMigrationRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      await _measureRepository.createBirdMigration(request.date, request.location, request.specie, request.event, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      emit(MeasureCreationError('La création a échoué'));
    }
  }

  /// Handles the creation of a eggs laying measure.
  Future<void> _onCreateEggsLayingRequest(CreateEggsLayingRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      await _measureRepository.createEggsLaying(request.date, request.location, request.number, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      emit(MeasureCreationError('La création a échoué'));
    }
  }

  /// Handles the retrieval of a single measure in details.
  Future<void> _onMeasureDetailsRequest(MeasureDetailsRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureDetailsLoading());

    try {
      final measure = await _measureRepository.getSingleMeasure(request.measureId);
      switch (measure.type) {
        case MeasureType.temperature :
          emit(TemperatureDetailsFetched(measure as Temperature));
        case MeasureType.snow_height :
          emit(SnowHeightDetailsFetched(measure as SnowHeight));
        case MeasureType.bird_migration :
          emit(BirdMigrationDetailsFetched(measure as BirdMigration));
        case MeasureType.eggs_laying :
          emit(EggsLayingDetailsFetched(measure as EggsLaying));
      }
    } catch (e) {
      emit(MeasureDetailsError('La récupération des détails de la mesure a échoué'));
    }
  }

  /// Handles the update of a temperature measure.
  Future<void> _onUpdateTemperatureRequest(UpdateTemperatureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateTemperature(request.measureId, request.date, request.location, request.degree);
      emit(MeasureUpdated());
    } catch (e) {
      emit (MeasureUpdateError('La modification a échoué'));
    }
  }

  /// Handles the update of a snow height measure.
  Future<void> _onUpdateSnowHeightRequest(UpdateSnowHeightRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateSnowHeight(request.measureId, request.date, request.location, request.height, request.weather, request.precipitation);
      emit(MeasureUpdated());
    } catch (e) {
      emit(MeasureUpdateError('La modification a échoué'));
    }
  }

  /// Handles the update of a bird migration measure.
  Future<void> _onUpdateBirdMigrationRequest(UpdateBirdMigrationRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateBirdMigration(request.measureId, request.date, request.location, request.specie, request.event);
      emit(MeasureUpdated());
    } catch (e) {
      emit(MeasureUpdateError('La modification a échoué'));
    }
  }

  /// Handles the update of a eggs laying measure.
  Future<void> _onUpdateEggsLaying(UpdateEggsLayingRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateEggsLaying(request.measureId, request.date, request.location, request.number);
      emit(MeasureUpdated());
    } catch (e) {
      emit(MeasureUpdateError('La modification a échoué'));
    }
  }

  /// Handles the deletion of a measure.
  Future<void> _onDeleteMeasureRequest(DeleteMeasureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureDeleteLoading());

    try {
      await _measureRepository.deleteMeasure(request.measureId);
      emit(MeasureDeleted());
    } catch (e) {
      emit(MeasureDeleteError('La suppression de la mesure a échoué'));
    }
  }
}