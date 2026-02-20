from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import time

app = FastAPI(title="LinguaBar Prototype API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class TranslateRequest(BaseModel):
    session_id: str
    source_lang: str
    target_lang: str
    text: str


class TranslateResponse(BaseModel):
    session_id: str
    source_lang: str
    target_lang: str
    translated_text: str
    latency_ms: int


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/translate", response_model=TranslateResponse)
def translate(payload: TranslateRequest):
    start = time.time()
    # Заглушка: имитация обработки ASR → LLM → TTS
    time.sleep(0.2)
    translated = f"[{payload.target_lang}] {payload.text}"
    latency_ms = int((time.time() - start) * 1000)
    return TranslateResponse(
        session_id=payload.session_id,
        source_lang=payload.source_lang,
        target_lang=payload.target_lang,
        translated_text=translated,
        latency_ms=latency_ms,
    )
