import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/repositories/measure_repository.dart';

class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {

  final MeasureRepository _measureRepository;

  MeasureBloc(this._measureRepository) : super(MeasureNotFetched()) {
    on<UserMeasureRequest>(_onUserMeasureRequest);
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
      emit(MeasureError('Failed to fetch Measures'));
    }
  }



}