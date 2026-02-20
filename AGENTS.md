# AGENTS.md — LinguaBar

## Overview

LinguaBar is a language exchange social platform. Users match with native speakers of their target language and practice through real-time chat rooms with in-context translation assistance.

## Architecture

```
┌─────────────────┐     ┌─────────────────────────┐
│   Flutter Web   │────▶│   FastAPI Backend       │
│   (port 3050)   │     │   (port 8050)           │
└─────────────────┘     │                         │
                        │  WebSocket rooms        │
                        │  Matchmaking queue      │
                        │  Translation endpoint   │
                        └─────────────────────────┘
```

## Tech Stack

| Layer | Stack |
|-------|-------|
| Backend | FastAPI (Python 3.11+), uv, WebSocket |
| Frontend | Flutter Web, Riverpod, go_router |

## Key Files

### Backend
| File | Description |
|------|-------------|
| [`backend/app.py`](backend/app.py) | FastAPI app — rooms, matchmaking, translation |

### Frontend
| File | Description |
|------|-------------|
| [`flutter/lib/app.dart`](flutter/lib/app.dart) | MaterialApp, routing |
| [`flutter/lib/core/routing/app_router.dart`](flutter/lib/core/routing/app_router.dart) | go_router configuration |
| [`flutter/lib/features/onboarding/onboarding_screen.dart`](flutter/lib/features/onboarding/onboarding_screen.dart) | Language selection |
| [`flutter/lib/features/matchmaking/matchmaking_screen.dart`](flutter/lib/features/matchmaking/matchmaking_screen.dart) | Partner matching |
| [`flutter/lib/features/rooms/rooms_screen.dart`](flutter/lib/features/rooms/rooms_screen.dart) | Room browser |
| [`flutter/lib/features/chat/chat_room_screen.dart`](flutter/lib/features/chat/chat_room_screen.dart) | Real-time chat |

## API Endpoints

```
GET  /rooms              — list available language rooms
POST /rooms              — create a room
GET  /rooms/{id}         — room details
WS   /rooms/{id}/ws      — WebSocket connection for chat
POST /matchmaking/join   — join matchmaking queue
POST /translate          — translate text snippet
GET  /health             — health check
```

## Screen Flows

```
Onboarding (language selection)
  ├── → Matchmaking → Chat Room (roulette)
  └── → Room Browser → Chat Room
```

## Development

```bash
# Backend
cd backend && uv sync
uv run uvicorn app:app --reload --port 8050

# Flutter
cd flutter && flutter pub get
flutter run -d chrome --web-port 3050
```

## Notes

- Current implementation is a prototype stub (ASR → LLM → TTS pipeline)
- Translation uses a simple LLM call — no streaming yet
- Real integration will connect to speech recognition, LLM, and TTS providers
- No persistent database — state is in-memory
