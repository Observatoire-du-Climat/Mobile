class Measure {
  final int id;
  final DateTime date;
  final String location;
  final String type;

  Measure({
    required this.id,
    required this.date,
    required this.location,
    required this.type
  });

  factory Measure.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id' : int id, 'date' : DateTime date, 'location' : String location, 'type' : String type} => Measure(
        id: id,
        date: date,
        location: location,
        type: type
      ),
      _ => throw const FormatException('Failed to load Measure')
    };
  }
}