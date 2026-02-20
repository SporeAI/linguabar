class Room {
  Room({
    required this.id,
    required this.name,
    required this.languagePair,
    required this.participants,
    required this.isPublic,
  });

  final String id;
  final String name;
  final String languagePair;
  final int participants;
  final bool isPublic;
}
