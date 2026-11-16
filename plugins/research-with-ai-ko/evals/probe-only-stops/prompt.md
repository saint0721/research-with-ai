---
name: probe-only-stops
tags: [rule,probe]
runs: 2
max_turns: 12
allowed_tools: [Read, Glob, Grep, Skill]
---

학습 없이 기존 모델에 새 장치를 붙여 앞으로 한 번 돌려 봤더니 신호에 정보가 있다고 나왔어(AUROC 0.71). 이걸 근거로 이 모듈을 채택해도 될까?
