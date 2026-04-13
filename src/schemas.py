from datetime import datetime

from pydantic import BaseModel, EmailStr, Field, field_validator, model_validator

from activity_constants import EMOTION_TAG_IDS, MODALITIES


class UserRegister(BaseModel):
    email: EmailStr
    password: str = Field(min_length=6)
    first_name: str = Field(min_length=1, max_length=120)
    last_name: str = Field(min_length=1, max_length=120)


class UserLogin(BaseModel):
    email: EmailStr
    password: str


class ProfileUpdate(BaseModel):
    display_name: str | None = Field(default=None, max_length=120)
    gender: str | None = Field(default=None, max_length=32)
    birth_year: int | None = Field(default=None, ge=1900, le=2100)


class UserPublic(BaseModel):
    id: int
    email: str
    first_name: str
    last_name: str
    display_name: str | None
    gender: str | None
    birth_year: int | None
    onboarding_completed: bool
    created_at: datetime

    model_config = {"from_attributes": True}


class AuthResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserPublic


class ActivitySessionCreate(BaseModel):
    modality: str = Field(min_length=1, max_length=32)
    activity_title: str = Field(min_length=1, max_length=512)
    pre_emotion_tag_ids: list[str] = Field(min_length=1, max_length=3)
    post_emotion_tag_ids: list[str] = Field(min_length=1, max_length=3)
    videos_total: int | None = Field(default=None, ge=0)
    videos_completed: int | None = Field(default=None, ge=0)
    used_video_skip: bool = False

    @model_validator(mode="after")
    def video_counts_consistent(self) -> "ActivitySessionCreate":
        t, c = self.videos_total, self.videos_completed
        if t is not None and c is not None and c > t:
            raise ValueError("videos_completed cannot exceed videos_total")
        return self

    @field_validator("modality")
    @classmethod
    def modality_ok(cls, v: str) -> str:
        key = v.strip().lower()
        if key not in MODALITIES:
            raise ValueError(
                f"modality must be one of: {', '.join(sorted(MODALITIES))}",
            )
        return key

    @staticmethod
    def _emotion_list_ok(name: str, ids: list[str]) -> list[str]:
        cleaned = [x.strip().lower() for x in ids if x and str(x).strip()]
        if not cleaned:
            raise ValueError(f"{name} must include at least one emotion tag id")
        if len(cleaned) > 3:
            raise ValueError(f"{name} may have at most 3 tags")
        if len(cleaned) != len(set(cleaned)):
            raise ValueError(f"{name} must not contain duplicates")
        unknown = [x for x in cleaned if x not in EMOTION_TAG_IDS]
        if unknown:
            raise ValueError(f"unknown emotion tag id(s): {', '.join(unknown)}")
        return cleaned

    @field_validator("pre_emotion_tag_ids")
    @classmethod
    def pre_ok(cls, v: list[str]) -> list[str]:
        return cls._emotion_list_ok("pre_emotion_tag_ids", v)

    @field_validator("post_emotion_tag_ids")
    @classmethod
    def post_ok(cls, v: list[str]) -> list[str]:
        return cls._emotion_list_ok("post_emotion_tag_ids", v)

    @field_validator("activity_title")
    @classmethod
    def title_strip(cls, v: str) -> str:
        t = v.strip()
        if not t:
            raise ValueError("activity_title cannot be empty")
        return t


class ActivitySessionPublic(BaseModel):
    id: int
    user_id: int
    modality: str
    activity_title: str
    pre_emotion_tag_ids: list[str]
    post_emotion_tag_ids: list[str]
    videos_total: int | None
    videos_completed: int | None
    used_video_skip: bool
    created_at: datetime

    model_config = {"from_attributes": True}
