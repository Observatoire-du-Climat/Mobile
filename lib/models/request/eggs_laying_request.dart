import 'package:mobile/models/eggs_laying.dart';

/// Request sent to the web server when creating a new eggs laying measure.
///
/// It is part of the multipart request under the label 'request'.
class EggsLayingRequest {
  final int userId;
  final DateTime date;
  final String location;
  final int number;

  EggsLayingRequest({
    required this.userId,
    required this.date,
    required this.location,
    required this.number
  });

  /// Creates a JSON object from a [EggsLaying].
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first, //to have only the date
      'location': location,
      'number': number
    };
  }
}