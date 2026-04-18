"""Aggregated regulation-zone stats for the profile emotional journey UI."""

from collections import Counter

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from deps import get_current_user
from emotion_zones import ZONE_KEYS, compute_regulation_zone, counts_to_percentages
from models import User, UserActivitySession
from schemas import EmotionJourneyStats

router = APIRouter(prefix="/users/me", tags=["emotion-journey"])


def _zone_for_pre(row: UserActivitySession) -> str:
    if row.pre_zone:
        return row.pre_zone
    return compute_regulation_zone(list(row.pre_emotion_tag_ids or []))


def _zone_for_post(row: UserActivitySession) -> str:
    if row.post_zone:
        return row.post_zone
    return compute_regulation_zone(list(row.post_emotion_tag_ids or []))


@router.get("/emotion-journey", response_model=EmotionJourneyStats)
def get_emotion_journey_stats(
    db: Session = Depends(get_db),
    current: User = Depends(get_current_user),
) -> EmotionJourneyStats:
    rows = (
        db.query(UserActivitySession)
        .filter(UserActivitySession.user_id == current.id)
        .all()
    )
    pre_c: Counter[str] = Counter()
    post_c: Counter[str] = Counter()
    included = 0
    for row in rows:
        try:
            pre_c[_zone_for_pre(row)] += 1
            post_c[_zone_for_post(row)] += 1
            included += 1
        except (ValueError, TypeError):
            continue

    pre_counts = {z: pre_c.get(z, 0) for z in ZONE_KEYS}
    post_counts = {z: post_c.get(z, 0) for z in ZONE_KEYS}

    return EmotionJourneyStats(
        session_count=included,
        check_in_percentages=counts_to_percentages(pre_counts),
        check_out_percentages=counts_to_percentages(post_counts),
    )
