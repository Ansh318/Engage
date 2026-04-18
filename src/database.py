from collections.abc import Generator

from sqlalchemy import create_engine, inspect, text
from sqlalchemy.orm import DeclarativeBase, Session, sessionmaker

from config import settings

engine = create_engine(
    settings.database_url,
    connect_args={"check_same_thread": False},
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class Base(DeclarativeBase):
    pass


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def ensure_activity_session_zone_columns() -> None:
    """Add pre_zone / post_zone if missing (existing DBs created before these columns)."""
    try:
        insp = inspect(engine)
        if not insp.has_table("user_activity_sessions"):
            return
        cols = {c["name"] for c in insp.get_columns("user_activity_sessions")}
    except Exception:
        return
    with engine.connect() as conn:
        if "pre_zone" not in cols:
            conn.execute(
                text(
                    "ALTER TABLE user_activity_sessions "
                    "ADD COLUMN pre_zone VARCHAR(32)"
                )
            )
        if "post_zone" not in cols:
            conn.execute(
                text(
                    "ALTER TABLE user_activity_sessions "
                    "ADD COLUMN post_zone VARCHAR(32)"
                )
            )
        conn.commit()
