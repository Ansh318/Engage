from datetime import datetime

from sqlalchemy import JSON, Boolean, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from database import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    password_hash: Mapped[str] = mapped_column(String(255))
    first_name: Mapped[str] = mapped_column(String(120))
    last_name: Mapped[str] = mapped_column(String(120))
    display_name: Mapped[str | None] = mapped_column(String(120), nullable=True)
    gender: Mapped[str | None] = mapped_column(String(32), nullable=True)
    birth_year: Mapped[int | None] = mapped_column(Integer, nullable=True)
    onboarding_completed: Mapped[bool] = mapped_column(Boolean, default=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)

    sessions: Mapped[list["SessionRecord"]] = relationship(
        "SessionRecord", back_populates="user", cascade="all, delete-orphan"
    )
    activity_sessions: Mapped[list["UserActivitySession"]] = relationship(
        "UserActivitySession", back_populates="user", cascade="all, delete-orphan"
    )


class SessionRecord(Base):
    __tablename__ = "sessions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), index=True)
    token: Mapped[str] = mapped_column(String(64), unique=True, index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
    expires_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    user: Mapped["User"] = relationship("User", back_populates="sessions")


class UserActivitySession(Base):
    """One completed in-app activity: modality, activity title, pre/post emotion tags, optional video progress."""

    __tablename__ = "user_activity_sessions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), index=True)
    modality: Mapped[str] = mapped_column(String(32), index=True)
    activity_title: Mapped[str] = mapped_column(String(512))
    pre_emotion_tag_ids: Mapped[list] = mapped_column(JSON)
    post_emotion_tag_ids: Mapped[list] = mapped_column(JSON)
    pre_zone: Mapped[str | None] = mapped_column(String(32), nullable=True, index=True)
    post_zone: Mapped[str | None] = mapped_column(String(32), nullable=True, index=True)
    videos_total: Mapped[int | None] = mapped_column(Integer, nullable=True)
    videos_completed: Mapped[int | None] = mapped_column(Integer, nullable=True)
    used_video_skip: Mapped[bool] = mapped_column(Boolean, default=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow, index=True)

    user: Mapped["User"] = relationship("User", back_populates="activity_sessions")
