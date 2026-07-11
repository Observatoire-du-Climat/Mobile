class TemperatureRequest {
  final int userId;
  final DateTime date;
  final String location;
  final int degree;

  TemperatureRequest({
    required this.userId,
    required this.date,
    required this.location,
    required this.degree
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String().split('T').first, //to have only the date
      'location': location,
      'degree': degree,
    };
  }
}