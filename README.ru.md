# LinguaBar

Социальная платформа для языкового обмена. Находи носителей языка, практикуйся в чат-комнатах в реальном времени и прокачивай язык через живые разговоры.

## Что умеет

- Просматривать комнаты языкового обмена по целевому языку
- Находить партнёра для практики через матчмейкинг
- Чат в реальном времени с подсказками перевода в контексте
- Онбординг для указания родного и изучаемого языка

## Технологии

| Уровень | Стек |
|---------|------|
| Backend | FastAPI (Python 3.11+), uv |
| Frontend | Flutter Web, Riverpod, go_router |

## Быстрый старт

```bash
# Backend
cd backend && uv sync
uv run uvicorn app:app --reload --port 8050

# Flutter
cd flutter && flutter pub get
flutter run -d chrome --web-port 3050
```

## Структура проекта

```
prototype/
├── backend/
│   └── app.py          # FastAPI (WebSocket комнаты, матчмейкинг)
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

## Лицензия

MIT
