from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from deps import get_current_user
from models import User
from schemas import ProfileUpdate, UserPublic

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/me", response_model=UserPublic)
def read_me(current: User = Depends(get_current_user)) -> User:
    return current


@router.patch("/me", response_model=UserPublic)
def update_profile(
    payload: ProfileUpdate,
    db: Session = Depends(get_db),
    current: User = Depends(get_current_user),
) -> User:
    data = payload.model_dump(exclude_unset=True)
    for key, value in data.items():
        setattr(current, key, value)
    db.add(current)
    db.commit()
    db.refresh(current)
    return current


@router.post("/me/onboarding/complete", response_model=UserPublic)
def complete_onboarding(
    db: Session = Depends(get_db),
    current: User = Depends(get_current_user),
) -> User:
    current.onboarding_completed = True
    db.add(current)
    db.commit()
    db.refresh(current)
    return current
