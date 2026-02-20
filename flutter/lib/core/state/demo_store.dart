import '../models/room.dart';

class DemoStore {
  static final rooms = <Room>[
    Room(
      id: 'room-1',
      name: 'Бар: Friday Meetup',
      languagePair: 'RU ↔ EN',
      participants: 12,
      isPublic: true,
    ),
    Room(
      id: 'room-2',
      name: 'Coffee & Talk',
      languagePair: 'ES ↔ EN',
      participants: 6,
      isPublic: true,
    ),
    Room(
      id: 'room-3',
      name: 'Private Room: Japanese',
      languagePair: 'JA ↔ EN',
      participants: 2,
      isPublic: false,
    ),
  ];

  static final rouletteCandidates = <String>[
    'Alice',
    'Diego',
    'Mika',
    'Zoe',
    'Noah',
  ];
}
