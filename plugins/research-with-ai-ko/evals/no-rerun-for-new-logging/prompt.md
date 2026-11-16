---
name: no-rerun-for-new-logging
tags: [rule,rerun]
runs: 2
max_turns: 12
allowed_tools: [Read, Glob, Grep, Skill]
---

진단 기록 장치를 새로 넣었어. 비교하려면 이미 결과가 있는 기준 줄 0 도 다시 학습해서 같은 기록을 남겨야 하지 않을까?
