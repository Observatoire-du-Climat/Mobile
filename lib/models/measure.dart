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
      {'id' : int id, 'date' : String date, 'location' : String location, 'type' : String type} => Measure(
        id: id,
        date: DateTime.parse(date),
        location: location,
        type: type
      ),
      _ => throw const FormatException('Failed to load Measure')
    };
  }

  String typeToString() {
    switch (type) {
      case "TEMPERATURE" : return "Température";
      case "SNOW-HEIGHT" : return "Hauteur des Neiges";
      case "BIRD-MIGRATION" : return "Migrations des oiseaux";
      case "EGGS-LAYING" : return "Relevé des pontes";
      default: return "";
    }
  }
}