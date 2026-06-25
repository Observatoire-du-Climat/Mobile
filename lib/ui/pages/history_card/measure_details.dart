import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_state.dart';

class MeasureDetails extends StatelessWidget {
  const MeasureDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasureBloc, MeasureState>(
        builder: (context, state) {

          if (state is MeasureDetailsError) {
            return Dialog(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(state.message),
              ),
            );
          }

          if (state is TemperatureDetailsFetched) {
            //return TemperatureDetails(item: state.measure);
          }

          if (state is SnowHeightDetailsFetched) {
            //return SnowHeightDetails(item: state.measure);
          }

          if (state is BirdMigrationDetailsFetched) {
            //return BirdMigrationDetails(item: state.measure);
          }

          if (state is EggsLayingDetailsFetched) {
            //return EggsLayingDetails(item: state.measure);
          }

          //any other case (should be loading)
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Text('Chargement...'),
            ),
          );
        }
    );
  }
}