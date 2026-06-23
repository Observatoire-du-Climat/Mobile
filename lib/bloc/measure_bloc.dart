import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/repositories/measure_repository.dart';

class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {

  final MeasureRepository _measureRepository;

  MeasureBloc(this._measureRepository) : super(MeasureNotFetched()) {
    on<UserMeasureRequest>(_onUserMeasureRequest);
    on<CreateTemperatureRequest>(_onCreateTemperatureRequest);
    on<CreateSnowHeightRequest>(_onCreateSnowHeightRequest);
    on<CreateBirdMigrationRequest>(_onCreateBirdMigrationRequest);
  }

  Future<void> _onUserMeasureRequest(UserMeasureRequest request, Emitter<MeasureState> emit) async {
    emit(MeasureLoading());

    try {
      List<Measure> measures = await _measureRepository.getUserMeasures();
      if (measures.isEmpty) {
        emit(MeasureFetchedEmpty());
        return;
      }
      emit(MeasureFetched(measures));
    } catch (e) {
      print('Error : $e');
      emit(MeasureError('Failed to fetch Measures'));
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

}