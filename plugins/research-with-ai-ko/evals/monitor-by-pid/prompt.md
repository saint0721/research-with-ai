---
name: monitor-by-pid
tags: [rule,operations]
runs: 2
max_turns: 12
allowed_tools: [Read, Glob, Grep, Skill]
---

서버에서 4시간쯤 걸리는 학습을 setsid nohup으로 띄웠어. 끝나면 내가 알 수 있게 감시를 어떻게 걸면 될까? 순서대로 짧게 알려줘.
