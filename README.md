# LinguaBar

A language exchange social platform. Match with native speakers, practice in real-time chat rooms, and level up through conversation.

## What It Does

- Browse language exchange rooms by target language
- Join matchmaking to find a practice partner
- Real-time chat with in-context translation hints
- Onboarding flow to set native and learning languages

## Tech Stack

| Layer | Stack |
|-------|-------|
| Backend | FastAPI (Python 3.11+), uv |
| Frontend | Flutter Web, Riverpod, go_router |

## Quick Start

```bash
# Backend
cd backend && uv sync
uv run uvicorn app:app --reload --port 8050

# Flutter
cd flutter && flutter pub get
flutter run -d chrome --web-port 3050
```

## Screen Flows

- Onboarding → Chat Roulette (matchmaking)
- Onboarding → Rooms → Chat Room

## Project Structure

```
prototype/
├── backend/
│   └── app.py          # FastAPI app (WebSocket rooms, matchmaking)
└── flutter/
    └── lib/
        ├── features/
        │   ├── onboarding/
        │   ├── rooms/
        │   ├── matchmaking/
        │   └── chat/
        └── core/
            ├── models/
            ├── state/
            ├── routing/
            └── theme/
```

## Note

This is a prototype pipeline stub (ASR → LLM → TTS). Real integration will connect to speech recognition, LLM, and TTS providers.

## License

MIT
