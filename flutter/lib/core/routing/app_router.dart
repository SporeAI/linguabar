import 'package:flutter/material.dart';

import '../../features/onboarding/onboarding_screen.dart';
import '../../features/matchmaking/matchmaking_screen.dart';
import '../../features/rooms/rooms_screen.dart';
import '../../features/chat/chat_room_screen.dart';

class AppRoutes {
  static const onboarding = '/';
  static const matchmaking = '/matchmaking';
  static const rooms = '/rooms';
  static const chatRoom = '/room';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.matchmaking:
        return MaterialPageRoute(builder: (_) => const MatchmakingScreen());
      case AppRoutes.rooms:
        return MaterialPageRoute(builder: (_) => const RoomsScreen());
      case AppRoutes.chatRoom:
        final args = settings.arguments as ChatRoomArgs?;
        return MaterialPageRoute(
          builder: (_) => ChatRoomScreen(
            args: args ?? ChatRoomArgs.demo(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }
}

class ChatRoomArgs {
  ChatRoomArgs({
    required this.roomName,
    required this.peerName,
    required this.sourceLang,
    required this.targetLang,
  });

  final String roomName;
  final String peerName;
  final String sourceLang;
  final String targetLang;

  factory ChatRoomArgs.demo() {
    return ChatRoomArgs(
      roomName: 'Бар: Friday Meetup',
      peerName: 'Alice',
      sourceLang: 'Русский',
      targetLang: 'English',
    );
  }
}
