import 'package:mobile/web_providers/measure_provider.dart';

class MeasureRepository {

  final MeasureProvider measureProvider;

  MeasureRepository(this.measureProvider);

  Future getUserMeasures() => measureProvider.getUserMeasures();

  Future createTemperature(DateTime date, String location, int degree) =>
      measureProvider.createTemperature(date, location, degree);
}