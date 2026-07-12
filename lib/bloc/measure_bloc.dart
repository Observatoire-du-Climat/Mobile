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

class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {

  final MeasureRepository _measureRepository;

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

  Future<void> _onUserMeasureRequest(UserMeasureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasuresLoading());
    print('UserMeasureRequest asked !!');

    try {
      List<Measure> measures = await _measureRepository.getUserMeasures();
      if (measures.isEmpty) {
        emit(MeasuresFetchedEmpty());
        return;
      }
      emit(MeasuresFetched(measures));
    } catch (e) {
      print('Error : $e');
      emit(MeasuresError('Failed to fetch Measures'));
    }
  }

  Future<void> _onCreateTemperatureRequest(CreateTemperatureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      print("envoie de la mesure au provider");
      await _measureRepository.createTemperature(request.date, request.location, request.degree, request.picture);
      emit(MeasureCreated());
    } catch (e) {
      print('Error : $e');
      emit(MeasureCreationError('Failed to create Temperature Measure'));
    }
  }

  Future<void> _onCreateSnowHeightRequest(CreateSnowHeightRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      print("envoie de la mesure au provider");
      await _measureRepository.createSnowHeight(request.date, request.location, request.height, request.weather, request.precipitation, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      print('Error : $e');
      emit(MeasureCreationError('Failed to create SnowHeight Measure'));
    }
  }

  Future<void> _onCreateBirdMigrationRequest(CreateBirdMigrationRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      print("envoie de la mesure au provider");
      await _measureRepository.createBirdMigration(request.date, request.location, request.specie, request.event, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      print('Error : $e');
      emit(MeasureCreationError('Failed to create BirdMigration Measure'));
    }
  }

  Future<void> _onCreateEggsLayingRequest(CreateEggsLayingRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      print("envoie de la mesure au provider");
      await _measureRepository.createEggsLaying(request.date, request.location, request.number, request.picture);
      emit(MeasureCreated());
    } catch(e) {
      print('Error : $e');
      emit(MeasureCreationError('Failed to create EggsLaying Measure'));
    }
  }

  Future<void> _onMeasureDetailsRequest(MeasureDetailsRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureDetailsLoading());

    try {
      print("envoie de la requête au provider");
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
      print('Error : $e');
      emit(MeasureDetailsError('Failed to fetch measure'));
    }
  }

  Future<void> _onUpdateTemperatureRequest(UpdateTemperatureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateTemperature(request.measureId, request.date, request.location, request.degree);
      emit(MeasureUpdated());
    } catch (e) {
      print('Error : $e');
      emit (MeasureUpdateError('Failed to update Temperature Measure'));
    }
  }

  Future<void> _onUpdateSnowHeightRequest(UpdateSnowHeightRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateSnowHeight(request.measureId, request.date, request.location, request.height, request.weather, request.precipitation);
      emit(MeasureUpdated());
    } catch (e) {
      print('Error : $e');
      emit(MeasureUpdateError('Failed to update SnowHeight Measure'));
    }
  }

  Future<void> _onUpdateBirdMigrationRequest(UpdateBirdMigrationRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateBirdMigration(request.measureId, request.date, request.location, request.specie, request.event);
      emit(MeasureUpdated());
    } catch (e) {
      print('Error : $e');
      emit(MeasureUpdateError('Failed to update BirdMigration measure'));
    }
  }

  Future<void> _onUpdateEggsLaying(UpdateEggsLayingRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureUpdateLoading());

    try {
      await _measureRepository.updateEggsLaying(request.measureId, request.date, request.location, request.number);
      emit(MeasureUpdated());
    } catch (e) {
      print('Error : $e');
      emit(MeasureUpdateError('Failed to update EggsLaying measure'));
    }
  }

  Future<void> _onDeleteMeasureRequest(DeleteMeasureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureDeleteLoading());

    try {
      await _measureRepository.deleteMeasure(request.measureId);
      emit(MeasureDeleted());
    } catch (e) {
      print('Error : $e');
      emit(MeasureDeleteError('Failed to delete measure'));
    }
  }
}