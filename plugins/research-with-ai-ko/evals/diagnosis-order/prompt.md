---
name: diagnosis-order
tags: [rule,diagnosis]
runs: 2
max_turns: 12
allowed_tools: [Read, Glob, Grep, Skill]
---

새 손실 항을 더한 줄이 기준보다 0.6 떨어졌어. 학습 중 측정 기록을 보니 표적 클래스 혼동이 오히려 늘었더라. 왜 안 올랐는지 진단해줘. 코드는 지금 볼 수 없으니 진단 순서와 첫 확인 항목만 말해줘.
