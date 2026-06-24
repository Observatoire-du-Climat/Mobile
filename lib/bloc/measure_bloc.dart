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
  }

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
      print('Error : $e');
      emit(MeasuresError('Failed to fetch Measures'));
    }
  }

  Future<void> _onCreateTemperatureRequest(CreateTemperatureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureCreationLoading());

    try {
      print("envoie de la mesure au provider");
      await _measureRepository.createTemperature(request.date, request.location, request.degree);
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
      await _measureRepository.createSnowHeight(request.date, request.location, request.height, request.weather, request.precipitation);
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
      await _measureRepository.createBirdMigration(request.date, request.location, request.specie, request.event);
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
      await _measureRepository.createEggsLaying(request.date, request.location, request.number);
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
        case MeasureType.snowHeight :
          emit(SnowHeightDetailsFetched(measure as SnowHeight));
        case MeasureType.birdMigration :
          emit(BirdMigrationDetailsFetched(measure as BirdMigration));
        case MeasureType.eggsLaying :
          emit(EggsLayingDetailsFetched(measure as EggsLaying));
      }
    } catch (e) {
      print('Error : $e');
      emit(MeasureDetailsError('Failed to fetch measure'));
    }
  }

}