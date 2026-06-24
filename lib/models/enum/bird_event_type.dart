enum BirdEventType {
  arrival('Arrivée'),
  departure('Départ');

  final String label;
  const BirdEventType(this.label);
}