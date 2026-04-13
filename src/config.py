from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # Repo root is parent of src/
    database_dir: Path = Path(__file__).resolve().parent.parent / "database"
    database_filename: str = "engage.db"
    session_expire_days: int = 30

    @property
    def database_url(self) -> str:
        self.database_dir.mkdir(parents=True, exist_ok=True)
        path = self.database_dir / self.database_filename
        return f"sqlite:///{path}"


settings = Settings()
