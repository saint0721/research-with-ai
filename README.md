---
project: AI 활용 연구 방법
type: guide
document_role: "AI 활용 연구 방법 — 설치와 사용 안내"
document_status: active
updated: 2026-11-02
tags:
  - project/ai_research_method
  - guide
---
# AI 활용 연구 방법 — 설치와 사용 안내

| 항목 | 내용 |
| --- | --- |
| 목적 | 스킬 `research-with-ai`를 설치하고 연구 작업에 연결하는 방법과, 연구자가 AI에게 요청할 때 효과가 있는 말투를 정리함 |
| 읽는 사람 | 스킬을 설치하거나 나눠 받는 연구자. 스킬이 연구 중에 읽는 문서가 아님 |
| 구성 | 1장 설치와 프로젝트 연결, 2장 효과가 있는 요청 패턴. 스킬 폴더의 `README.md`가 됨 |

## 1. 설치와 프로젝트 연결
이 스킬을 설치하고, 연구자가 따로 부르지 않아도 연구 작업에서 바로 쓰이게 연결하는 방법임. 다른 사람과 나눠 쓸 때도 같은 방법을 따름.

### 1.1 스킬 구성
| 파일 | 내용 | 읽는 때 |
| --- | --- | --- |
| `SKILL.md` | 고정된 입구. 발동 조건과 "00을 먼저 읽고 표가 가리키는 문서만 읽음"이라는 안내 | 연구 작업이면 자동으로 |
| `… — 00 개요와 원칙.md` | 원칙, 연구 흐름, 운영, 오류 신호, 보고 전 점검표 | 연구 작업이면 항상 먼저 |
| `… — 01 도구와 규칙 체계.md` | 도구와 규칙, 위키, 점진 개선 | 새 연구·저장소 시작, 지침·메모리·스킬·훅·위키를 만들 때 |
| `… — 02 주제·질문·선행연구·공백.md` | 주제, 방법 도출, 판정 기준, 선행·신규성 | 해당 단계 |
| `… — 03 실험·모델 개발.md` | 설계, 손실, 환경·공정성, 코드, 학습, 측정, 판정 | 해당 단계 |
| `… — 04 실행 운영.md` | 워커, 서버·GPU, 긴 작업, 감시, 보안·비용, 커밋 | 해당 단계 |
| `… — 05 비판·논문화·외부 문서.md` | 모의 심사, 평가 split, 원고 구조·검증 | 해당 단계 |
| `… — 06 AI가 틀리는 유형과 대응.md` | 오류 유형별 신호와 대응 | AI 출력이 이상할 때 |
| `README.md` | 이 안내 | 설치할 때, 사람이 읽음 |
- 사례는 두지 않음. 특정 연구의 숫자와 이름이 섞이면 판단이 한쪽으로 끌리므로, 교훈은 일반 규칙과 이유로만 씀.

### 1.2 설치
- 받은 스킬 폴더(`research-with-ai/`)를 에이전트의 스킬 위치에 둠. 예: Claude Code는 `~/.claude/skills/`, Codex는 `~/.codex/skills/`.
- 원본 문서를 직접 고쳐 가며 쓰려면, 스킬 폴더 안의 00~06과 `README.md`를 원본 노트로 가는 심볼릭 링크로 두고 `SKILL.md`만 실제 파일로 둠. 그러면 원본을 고치는 즉시 스킬이 바뀜.
- 다른 사람에게 줄 때는 링크가 아니라 실제 파일이 복사되게 함(예: `cp -RL`).
- 설치 뒤 새 세션에서 "실험 설계하자"처럼 말해 스킬이 스스로 불리는지 확인함.

### 1.3 전역 지침에 연결
스킬의 자동 발동만으로는 놓칠 수 있으므로, 에이전트가 항상 읽는 전역 지침에 아래 문단을 넣음(Claude Code: `~/.claude/CLAUDE.md`, Codex: `~/AGENTS.md` 등).

```markdown
## Research method
- For any research work (topic, prior work, experiment or model design, training runs, result diagnosis, paper writing, research documentation), load the `research-with-ai` skill first and read only the reference file its table points to. The user does not need to name it.
- A project's own AGENTS.md / CLAUDE.md and the user's direct request take precedence over the skill.
- Improvement candidates go to: [개선 후보 노트 경로]. Method source notes: [원본 문서 폴더 경로].
```

### 1.4 연구 저장소에 연결
연구 저장소의 지침(`AGENTS.md` 또는 `CLAUDE.md`)에는 스킬 내용을 복사하지 않고, 그 연구에만 해당하는 값만 적음. 스킬은 방법을, 저장소 지침은 그 연구의 값을 맡음.

```markdown
## Research method
- Follow the `research-with-ai` skill. Project-specific values:
  - Main metric / guard metric: [예: 주 지표, 보호 지표와 허용 하락폭]
  - Baseline row and adoption rule: [예: 기준선, 1 seed 채택 조건, 여러 seed는 모델 확정 뒤]
  - Protocol (protected keys): [분할, 정답, update 수, batch, 학습률 일정, 평가, seed]
  - Runner and launch command: [실행기 명령과 인자 형식]
  - Wiki: [상태 색인, 주제 페이지, 일지 위치]
  - Constraints: [쓰지 않을 입력·기법, 금지 사항]
  - Approval: [연구자 승인 없이 해도 되는 범위, 예: smoke 성공 뒤 학습]
```

### 1.5 갱신
- 원본 문서를 고치면 링크로 연결된 스킬이 바로 바뀜. 설치된 파일을 따로 고치지 않음.
- 원칙이 바뀌면 00 2장부터, 단계 안의 방법이 바뀌면 해당 참고 문서를 고침.
- 연구자가 정정하거나 새 방법을 정하면 에이전트가 그 턴에 바로 원본 문서를 고침(00 원칙 17). AI가 스스로 알아낸 교훈만 후보로 남기고 물음(원칙 18). 후보 노트의 위치는 각 사용자의 전역 지침(1.3)에 적음.

## 3. 라이선스
이 문서 묶음은 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)으로 공개함. 출처를 밝히면 누구나 쓰고 고치고 나눌 수 있음.
