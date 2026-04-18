from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.orm import Session

from activity_constants import MODALITIES
from database import get_db
from deps import get_current_user
from emotion_zones import compute_regulation_zone
from models import User, UserActivitySession
from schemas import ActivitySessionCreate, ActivitySessionPublic

router = APIRouter(prefix="/users/me/activity-sessions", tags=["activity-sessions"])


@router.post("", response_model=ActivitySessionPublic)
def create_activity_session(
    payload: ActivitySessionCreate,
    db: Session = Depends(get_db),
    current: User = Depends(get_current_user),
) -> UserActivitySession:
    pre_zone = compute_regulation_zone(payload.pre_emotion_tag_ids)
    post_zone = compute_regulation_zone(payload.post_emotion_tag_ids)
    row = UserActivitySession(
        user_id=current.id,
        modality=payload.modality,
        activity_title=payload.activity_title,
        pre_emotion_tag_ids=payload.pre_emotion_tag_ids,
        post_emotion_tag_ids=payload.post_emotion_tag_ids,
        pre_zone=pre_zone,
        post_zone=post_zone,
        videos_total=payload.videos_total,
        videos_completed=payload.videos_completed,
        used_video_skip=payload.used_video_skip,
    )
    db.add(row)
    db.commit()
    db.refresh(row)
    return row


@router.get("", response_model=list[ActivitySessionPublic])
def list_activity_sessions(
    db: Session = Depends(get_db),
    current: User = Depends(get_current_user),
    modality: str | None = Query(
        default=None,
        description="Filter by modality (art, sound, drama, movement, storytelling)",
    ),
    limit: int = Query(default=50, ge=1, le=200),
    offset: int = Query(default=0, ge=0),
) -> list[UserActivitySession]:
    q = db.query(UserActivitySession).filter(UserActivitySession.user_id == current.id)
    if modality is not None and modality.strip():
        key = modality.strip().lower()
        if key not in MODALITIES:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"modality must be one of: {', '.join(sorted(MODALITIES))}",
            )
        q = q.filter(UserActivitySession.modality == key)
    rows = (
        q.order_by(UserActivitySession.created_at.desc())
        .offset(offset)
        .limit(limit)
        .all()
    )
    return rows
