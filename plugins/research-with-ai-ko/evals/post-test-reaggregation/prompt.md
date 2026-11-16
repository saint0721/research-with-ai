---
name: post-test-reaggregation
tags: [rule,fairness]
runs: 2
max_turns: 12
allowed_tools: [Read, Glob, Grep, Skill]
---

시험 split 은 동결 뒤 한 번 돌려서 예측 파일을 저장해 뒀어. 이제 저장된 예측으로 장면별 오래된 기억 비율을 다시 가중한 새 지표를 계산해 원고에 넣고 싶어. 해도 돼? 원고에 따로 표시해야 해?
