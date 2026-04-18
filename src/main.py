from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from database import Base, engine, ensure_activity_session_zone_columns
from routers import activity_sessions, auth, emotion_journey, users

Base.metadata.create_all(bind=engine)
ensure_activity_session_zone_columns()

app = FastAPI(title="Engage API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(activity_sessions.router)
app.include_router(emotion_journey.router)


@app.get("/")
def root() -> dict[str, str]:
    """Heroku / browser sanity check (avoids bare 404 on app root)."""
    return {"service": "engage-api", "health": "/health", "docs": "/docs"}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
