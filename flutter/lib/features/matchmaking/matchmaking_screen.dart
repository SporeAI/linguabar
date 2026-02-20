import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/demo_store.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  State<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  bool _isSearching = false;
  String? _matchName;

  void _startSearch() {
    setState(() {
      _isSearching = true;
      _matchName = null;
    });

    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      final name = DemoStore.rouletteCandidates[
          random.nextInt(DemoStore.rouletteCandidates.length)];
      setState(() {
        _matchName = name;
      });
    });
  }

  void _enterRoom() {
    Navigator.pushNamed(
      context,
      AppRoutes.chatRoom,
      arguments: ChatRoomArgs(
        roomName: 'Чат-рулетка',
        peerName: _matchName ?? 'Гость',
        sourceLang: 'Русский',
        targetLang: 'English',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат-рулетка'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.rooms),
            icon: const Icon(Icons.meeting_room_outlined),
            tooltip: 'Комнаты',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ищем собеседника рядом',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Нажмите «Старт», чтобы найти человека для разговора. Перевод включится автоматически.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    _isSearching
                        ? Icons.graphic_eq_outlined
                        : Icons.person_search,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isSearching
                        ? (_matchName == null
                            ? 'Поиск собеседника...'
                            : 'Найден: $_matchName')
                        : 'Готовы к знакомству?',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  if (_matchName != null)
                    FilledButton.icon(
                      onPressed: _enterRoom,
                      icon: const Icon(Icons.call),
                      label: const Text('Начать разговор'),
                    )
                  else
                    FilledButton.icon(
                      onPressed: _isSearching ? null : _startSearch,
                      icon: const Icon(Icons.search),
                      label: const Text('Старт'),
                    ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.rooms),
              child: const Text('Посмотреть комнаты'),
            ),
          ],
        ),
      ),
    );
  }
}
