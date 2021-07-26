import os
import re
from typing import Set, List, Dict
from lib.stopwords import DEFAULT_STOPWORDS


def remove_stopwords(text: str) -> str:
    words = text.split()
    return " ".join([w for w in words if w not in DEFAULT_STOPWORDS])


def wordset(text: str) -> Set[str]:
    return set(text.split())


def wordset_from_texts(texts: List[str]) -> Set[str]:
    wset: Set[str] = set()
    for text in texts:
        wset.update(wordset(text))
    return wset


def split_on_uppercase(s, keep_contiguous=False):
    string_length = len(s)
    is_lower_around = (
        lambda: s[i - 1].islower() or string_length > (i + 1) and s[i + 1].islower()
    )
    start = 0
    parts = []
    for i in range(1, string_length):
        if s[i].isupper() and (not keep_contiguous or is_lower_around()):
            parts.append(s[start:i])
            start = i
    parts.append(s[start:])
    return parts


def normalize(text: str) -> str:
    text = re.sub(r"[^A-Za-z0-9 ]+", " ", text)
    text = " ".join(split_on_uppercase(text, keep_contiguous=True))
    text = text.lower()
    text = remove_stopwords(text)
    return text
