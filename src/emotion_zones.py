"""Zones of Regulation + weighted zone selection (product spec v1)."""

from __future__ import annotations

from collections import defaultdict
from typing import Final

# Canonical API / DB keys (lowercase)
REGULATED: Final = "regulated"
ENERGIZED: Final = "energized"
TENSE: Final = "tense"
LOW: Final = "low"

ZONE_KEYS: tuple[str, str, str, str] = (REGULATED, ENERGIZED, TENSE, LOW)

# Must match frontend/engage/lib/emotion_tag.dart ids and activity_constants.EMOTION_TAG_IDS
EMOTION_TO_ZONE: dict[str, str] = {
    # Regulated
    "calm": REGULATED,
    "present": REGULATED,
    "connected": REGULATED,
    "safe": REGULATED,
    "grateful": REGULATED,
    "grounded": REGULATED,
    # Energized
    "energized": ENERGIZED,
    "creative": ENERGIZED,
    "joyful": ENERGIZED,
    "motivated": ENERGIZED,
    "curious": ENERGIZED,
    "inspired": ENERGIZED,
    # Tense
    "anxious": TENSE,
    "restless": TENSE,
    "stressed": TENSE,
    "overwhelmed": TENSE,
    "irritated": TENSE,
    "uneasy": TENSE,
    # Low
    "tired": LOW,
    "sad": LOW,
    "numb": LOW,
    "disconnected": LOW,
    "heavy": LOW,
    "lonely": LOW,
}


def emotion_to_zone(emotion_tag_id: str) -> str:
    key = emotion_tag_id.strip().lower()
    z = EMOTION_TO_ZONE.get(key)
    if z is None:
        raise ValueError(f"unknown emotion tag id: {emotion_tag_id!r}")
    return z


def compute_regulation_zone(ordered_tag_ids: list[str]) -> str:
    """
    Weighted zone: 1st→45%, 2nd→35%, 3rd→20%.
    1 tag → 100% to that emotion's zone.
    2 tags → 45% + 35% only.
    Tie: zone of the first selected emotion (highest single weight).
    """
    if not ordered_tag_ids:
        raise ValueError("ordered_tag_ids must not be empty")

    cleaned = [x.strip().lower() for x in ordered_tag_ids if x and str(x).strip()]
    if not cleaned:
        raise ValueError("ordered_tag_ids must not be empty")
    if len(cleaned) > 3:
        raise ValueError("at most 3 emotion tags allowed")

    n = len(cleaned)
    if n == 1:
        weights = [100.0]
    elif n == 2:
        weights = [45.0, 35.0]
    else:
        weights = [45.0, 35.0, 20.0]

    zone_weights: dict[str, float] = defaultdict(float)
    for tag_id, w in zip(cleaned, weights):
        zone_weights[emotion_to_zone(tag_id)] += w

    max_w = max(zone_weights.values())
    leaders = [z for z, wt in zone_weights.items() if wt == max_w]
    if len(leaders) == 1:
        return leaders[0]
    return emotion_to_zone(cleaned[0])


def counts_to_percentages(counts: dict[str, int]) -> dict[str, int]:
    """Convert zone counts to integer percentages that sum to 100."""
    total = sum(counts.get(z, 0) for z in ZONE_KEYS)
    if total == 0:
        return {z: 0 for z in ZONE_KEYS}

    exact = [100.0 * counts.get(z, 0) / total for z in ZONE_KEYS]
    floors = [int(x) for x in exact]
    remainder = 100 - sum(floors)
    fracs = [(exact[i] - floors[i], i) for i in range(4)]
    fracs.sort(reverse=True)
    result = list(floors)
    for k in range(remainder):
        result[fracs[k][1]] += 1
    return {ZONE_KEYS[i]: result[i] for i in range(4)}
