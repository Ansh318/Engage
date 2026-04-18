from pathlib import Path

from pydantic import AliasChoices, Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # Repo root is parent of src/
    database_dir: Path = Path(__file__).resolve().parent.parent / "database"
    database_filename: str = "engage.db"
    session_expire_days: int = 30

    #: Heroku Postgres (or any host) — set `DATABASE_URL` in the environment.
    database_url_override: str | None = Field(
        default=None,
        validation_alias=AliasChoices("DATABASE_URL"),
    )

    @property
    def database_url(self) -> str:
        if self.database_url_override and self.database_url_override.strip():
            url = self.database_url_override.strip()
            # SQLAlchemy expects postgresql:// (Heroku often provides postgres://)
            if url.startswith("postgres://"):
                url = url.replace("postgres://", "postgresql://", 1)
            return url
        self.database_dir.mkdir(parents=True, exist_ok=True)
        path = self.database_dir / self.database_filename
        return f"sqlite:///{path}"


settings = Settings()
