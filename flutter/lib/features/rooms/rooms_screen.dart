import 'package:flutter/material.dart';

import '../../core/models/room.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/demo_store.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = DemoStore.rooms;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Комнаты'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: rooms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final room = rooms[index];
          return _RoomCard(room: room);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.matchmaking),
        icon: const Icon(Icons.shuffle),
        label: const Text('Чат-рулетка'),
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.meeting_room_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text('${room.languagePair} · ${room.participants} участников'),
                  if (!room.isPublic)
                    const Text(
                      'Приватная',
                      style: TextStyle(color: Colors.orange),
                    ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.chatRoom,
                  arguments: ChatRoomArgs(
                    roomName: room.name,
                    peerName: 'Host',
                    sourceLang: 'Русский',
                    targetLang: 'English',
                  ),
                );
              },
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
