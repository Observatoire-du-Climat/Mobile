
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/bloc/measure_bloc.dart';
import 'package:mobile/bloc/measure_event.dart';
import 'package:mobile/bloc/measure_state.dart';
import 'package:mobile/models/enum/measure_type.dart';
import 'package:mobile/models/measure.dart';
import 'package:mobile/models/temperature.dart';
import 'package:mobile/repositories/measure_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'measure_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<MeasureRepository>(as: #MockMeasureRepository),
])
void main() {

  late MockMeasureRepository mockMeasureRepository;

  final measure1 = Measure(
      id: 1,
      date: DateTime(2026, 7, 19),
      location: 'Lausanne',
      type: MeasureType.temperature
  );
  final measure2 = Measure(
      id: 1,
      date: DateTime(2026, 7, 19),
      location: 'Lausanne',
      type: MeasureType.snow_height
  );
  final temperature = Temperature(
      id: 3, 
      date: DateTime(2026, 7, 19),
      location: 'Lausanne',
      type: MeasureType.temperature, 
      degree: 25
  );

  setUp(() {
    mockMeasureRepository = MockMeasureRepository();
  });

  test('Initial state is MeasuresNotFetched', () {
    final bloc = MeasureBloc(mockMeasureRepository);

    expect(bloc.state, isA<MeasuresNotFetched>());

    bloc.close();
  });

  group('getUserMeasures', () {
    blocTest(
      'getUserMeasures successful',
      build: () {
        when(
          mockMeasureRepository.getUserMeasures(),
        ).thenAnswer(
              (_) async => <Measure>[measure1, measure2],
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        UserMeasureRequest(),
      ),
      expect: () => [
        isA<MeasuresLoading>(),
        isA<MeasuresFetched>().having(
            (state) =>
              state.measures,
              'measures',
              [measure1, measure2]
        ),
      ],
    );

    blocTest(
      'getUserMeasures empty',
      build: () {
        when(
          mockMeasureRepository.getUserMeasures(),
        ).thenAnswer(
              (_) async => <Measure>[],
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        UserMeasureRequest(),
      ),
      expect: () => [
        isA<MeasuresLoading>(),
        isA<MeasuresFetchedEmpty>()
      ],
    );

    blocTest(
      'getUserMeasures failed',
      build: () {
        when(
          mockMeasureRepository.getUserMeasures(),
        ).thenThrow(
          Exception('Failed to retrieve measures')
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        UserMeasureRequest(),
      ),
      expect: () => [
        isA<MeasuresLoading>(),
        isA<MeasuresError>()
      ],
    );
  });

  group('createTemperature', () {
    blocTest<MeasureBloc, MeasureState>(
      'createTemperature successful',
      build: () {
        when(
          mockMeasureRepository.createTemperature(
              DateTime(2026, 7, 19),
              'Lausanne',
              25,
              null),
        ).thenAnswer(
              (_) async => temperature
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        CreateTemperatureRequest(
            date: DateTime(2026, 7, 19),
            location: 'Lausanne',
            degree: 25,
            picture: null),
      ),
      expect: () => [
        isA<MeasureCreationLoading>(),
        isA<MeasureCreated>()
      ],
    );

    blocTest<MeasureBloc, MeasureState>(
      'createTemperature failed',
      build: () {
        when(
          mockMeasureRepository.createTemperature(
              any,
              any,
              any,
              any),
        ).thenThrow(
                Exception('Failed to create Temperature Measure')
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        CreateTemperatureRequest(
            date: DateTime(2026, 7, 19),
            location: 'Lausanne',
            degree: 25,
            picture: null),
      ),
      expect: () => [
        isA<MeasureCreationLoading>(),
        isA<MeasureCreationError>()
      ],
    );

  });

  group('updateTemperature', () {
    blocTest<MeasureBloc, MeasureState>(
      'updateTemperature successful',
      build: () {
        when(
          mockMeasureRepository.updateTemperature(
              3,
              DateTime(2026, 7, 19),
              'Lausanne',
              25),
        ).thenAnswer(
                (_) async => temperature
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        UpdateTemperatureRequest(
            measureId: 3,
            date: DateTime(2026, 7, 19),
            location: 'Lausanne',
            degree: 25),
      ),
      expect: () => [
        isA<MeasureUpdateLoading>(),
        isA<MeasureUpdated>()
      ],
    );

    blocTest<MeasureBloc, MeasureState>(
      'updateTemperature failed',
      build: () {
        when(
          mockMeasureRepository.updateTemperature(
              any,
              any,
              any,
              any),
        ).thenThrow(
                Exception('Failed to update Temperature measure')
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        UpdateTemperatureRequest(
            measureId: 3,
            date: DateTime(2026, 7, 19),
            location: 'Lausanne',
            degree: 25),
      ),
      expect: () => [
        isA<MeasureUpdateLoading>(),
        isA<MeasureUpdateError>()
      ],
    );
  });

  group('deleteMeasure', () {
    blocTest<MeasureBloc, MeasureState>(
      'deleteMeasure successful',
      build: () {
        when(
          mockMeasureRepository.deleteMeasure(4),
        ).thenAnswer(
                (_) async => {}
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        DeleteMeasureRequest(measureId: 4),
      ),
      expect: () => [
        isA<MeasureDeleteLoading>(),
        isA<MeasureDeleted>()
      ],
    );

    blocTest<MeasureBloc, MeasureState>(
      'deleteMeasure failed',
      build: () {
        when(
          mockMeasureRepository.deleteMeasure(4),
        ).thenThrow(
                (_) async => Exception('Failed to delete the measure')
        );

        return MeasureBloc(mockMeasureRepository);
      },
      act: (bloc) => bloc.add(
        DeleteMeasureRequest(measureId: 4),
      ),
      expect: () => [
        isA<MeasureDeleteLoading>(),
        isA<MeasureDeleteError>()
      ],
    );
  });

}