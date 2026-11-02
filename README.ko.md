# research-with-ai (한국어)

[English](README.md)

AI 에이전트(Claude Code, Codex)를 연구 동료로 쓰는 방법을 담은 스킬임. 분야와 무관하며, 연구 주제부터 실험·모델 개발, 원고 검증까지 다룸. 한국어판은 `ko/`, 영어판은 `en/`에 있음.

## 설치와 사용 안내

| 항목 | 내용 |
| --- | --- |
| 목적 | 스킬 `research-with-ai`를 설치하고 연구 작업에 연결하는 방법과, 연구자가 AI에게 요청할 때 효과가 있는 말투를 정리함 |
| 읽는 사람 | 스킬을 설치하거나 나눠 받는 연구자. 스킬이 연구 중에 읽는 문서가 아님 |
| 구성 | 1장 설치와 프로젝트 연결, 2장 효과가 있는 요청 패턴. 저장소의 README가 됨 |

## 1. 설치와 프로젝트 연결
이 스킬을 설치하고, 연구자가 따로 부르지 않아도 연구 작업에서 바로 쓰이게 연결하는 방법임. 다른 사람과 나눠 쓸 때도 같은 방법을 따름.

### 1.1 스킬 구성
| 파일 | 내용 | 읽는 때 |
| --- | --- | --- |
| `SKILL.md` | 고정된 입구. 발동 조건과 "00을 먼저 읽고 표가 가리키는 문서만 읽음"이라는 안내 | 연구 작업이면 자동으로 |
| `00-overview-and-principles.md` | 원칙, 연구 흐름, 운영, 오류 신호, 보고 전 점검표 | 연구 작업이면 항상 먼저 |
| `01-tools-and-rules.md` | 도구와 규칙, 위키, 점진 개선 | 새 연구·저장소 시작, 지침·메모리·스킬·훅·위키를 만들 때 |
| `02-topic-question-prior-work.md` | 주제, 방법 도출, 판정 기준, 선행·신규성 | 해당 단계 |
| `03-experiment-and-model.md` | 설계, 손실, 환경·공정성, 코드, 학습, 측정, 판정 | 해당 단계 |
| `04-operations.md` | 워커, 서버·GPU, 긴 작업, 감시, 보안·비용, 커밋 | 해당 단계 |
| `05-critique-and-writing.md` | 모의 심사, 평가 split, 원고 구조·검증 | 해당 단계 |
| `06-ai-errors.md` | 오류 유형별 신호와 대응 | AI 출력이 이상할 때 |
- 사례는 두지 않음. 특정 연구의 숫자와 이름이 섞이면 판단이 한쪽으로 끌리므로, 교훈은 일반 규칙과 이유로만 씀.

### 1.2 AI에게 설치 맡기기
아래 문장을 Claude Code나 Codex에 그대로 붙여 넣으면 에이전트가 설치와 연결, 확인까지 함.

```text
https://github.com/saint0721/research-with-ai 의 research-with-ai 스킬을 설치해 줘.
1. 저장소를 받아 한국어판 `ko/` 폴더를 ~/.claude/skills/research-with-ai 와 ~/.codex/skills/research-with-ai 에 복사해.
2. README의 "전역 지침에 연결" 문단을 ~/.claude/CLAUDE.md 와 ~/.codex/AGENTS.md 끝에 붙여.
   개선 일지와 개선 후보를 둘 폴더를 나에게 물어 정하고, 문단의 경로 칸을 채워.
3. 새 세션에서 "실험 설계하자"라고 하면 이 스킬을 먼저 읽는지 확인하고 결과를 알려 줘.
기존 파일을 덮어쓰기 전에는 먼저 물어봐.
```

### 1.3 직접 설치
- 저장소의 `ko/`(한국어판) 또는 `en/`(영어판) 폴더 하나를 `research-with-ai/`라는 이름으로 에이전트의 스킬 위치에 둠. 두 판을 함께 설치하지 않음. 예: Claude Code는 `~/.claude/skills/`, Codex는 `~/.codex/skills/`.
- 문서를 직접 고쳐 가며 쓰려면, 원본 문서를 따로 두고 스킬 폴더의 00~06을 그 원본으로 가는 심볼릭 링크로 둠. 그러면 원본을 고치는 즉시 스킬이 바뀜.
- 다른 사람에게 줄 때는 링크가 아니라 실제 파일이 복사되게 함(예: `cp -RL`).
- 설치 뒤 새 세션에서 "실험 설계하자"처럼 말해 스킬이 스스로 불리는지 확인함.

### 1.4 전역 지침에 연결
스킬의 자동 발동만으로는 놓칠 수 있으므로, 에이전트가 항상 읽는 전역 지침에 아래 문단을 넣음(Claude Code: `~/.claude/CLAUDE.md`, Codex: `~/.codex/AGENTS.md`).

```markdown
## Research method
- For any research work (topic, prior work, experiment or model design, training runs, result diagnosis, paper writing, research documentation), load the `research-with-ai` skill first and read only the reference file its table points to. The user does not need to name it.
- A project's own AGENTS.md / CLAUDE.md and the user's direct request take precedence over the skill.
- When the user corrects you or sets a new way of working, edit the matching method document in [method folder] in the same turn and add one line to [improvement log]. Lessons you inferred yourself go to [improvement candidates] and you ask the user once.
```

### 1.5 연구 저장소에 연결
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

### 1.6 갱신
- 원본 문서를 고치면 링크로 연결된 스킬이 바로 바뀜. 설치된 파일을 따로 고치지 않음.
- 원칙이 바뀌면 00 2장부터, 단계 안의 방법이 바뀌면 해당 참고 문서를 고침.
- 연구자가 정정하거나 새 방법을 정하면 에이전트가 그 턴에 바로 원본 문서를 고침(00 원칙 17). AI가 스스로 알아낸 교훈만 후보로 남기고 물음(원칙 18). 후보 노트의 위치는 각 사용자의 전역 지침(1.4)에 적음.

## 2. 효과가 있는 요청 패턴
연구자가 AI에게 말할 때 결과가 좋아지는 말투임. 스킬이 없어도 그대로 쓸 수 있음.

| 패턴 | 예 |
| --- | --- |
| 목표 기준 명시 | "[목표 기준]에 맞도록 고치려면 무엇이 빠졌나" |
| 답을 의심 | "공정한 거 맞아?", "선행연구 맞는 거지?" |
| 근거 요구 | "원문을 내려받아 확인해 봐", "이런 문장이 있는지 다 찾아봐" |
| 모르는 말 질문 | "[용어]는 정확히 뭘 말하는 거야?" |
| 이해 확인 | "~라는 거 이해했어. 그러면 ~라는 건가?" |
| 결정 보류 | "아직 정하지 않을게, 설명을 먼저 해 줘" |
| 결정 위임 | "너가 정해줘. 조사가 필요하면 조사해 줘" |
| 범위 제한 | "아직 실험 계획은 세우지 마", "push는 하지 마" |
| 이점·역할 요구 | "이걸 하면 충분한 이점이 있어? 어떤 역할이야?" |
| 대안 탐색 | "더 좋은 게 없을까? 다른 논문들은 어떻게 하나 봐 줘" |
| 절차 확인 | "규칙대로 한 거 맞아?" |
| 병렬 위임 | "에이전트를 띄워서 더 찾아봐", "너는 검수해" |
| 기록 지시 | "문서로 남겨 줘", "지침에도 넣어 줘" |

## 3. 출처와 감사
이 문서 묶음은 아래 자료 덕분에 만들 수 있었음. 연구 방법과 도구를 공개해 준 저작자들께 감사드림. 각 자료의 권리는 원저작자에게 있음.

| 자료 | 쓴 곳 | 쓴 방식 | 라이선스 |
| --- | --- | --- | --- |
| [scientific-coding-skill](https://github.com/cemde/scientific-coding-skill) (Cornelius, 2026) | 03 6.1 과학 코드 원칙 | 원칙을 한국어로 옮겨 요약함. 실제 코딩에는 원본 스킬을 설치해 씀 | MIT |
| [awesome-claudecode-paper-proofreading](https://github.com/LimHyungTae/awesome-claudecode-paper-proofreading) (Hyungtae Lim, 2026) | 05 6.1 교정 운영 | 프롬프트 이름과 검사 범위를 소개함. 프롬프트 본문은 옮기지 않고 원본에서 받아 씀 | MIT |
| [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (Andrej Karpathy) | 01 5장, 8장 | 원천·위키·스키마 세 층과 일지·점검 구조를 따름 | 원문 참조 |
| [Agentic Context Engineering (ACE)](https://arxiv.org/abs/2510.04618) (Zhang 외, 2025) | 01 8장 | 지침을 통째로 다시 쓰지 않고 항목 단위로 고치는 원칙을 따름 | 논문 |
| [Hamming](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton·Steinhardt](https://arxiv.org/abs/1807.03341), [J.-B. Huang](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208) | 02 2장 방법 도출 7단계 | 각 단계의 근거로 삼아 절차로 정리함 | 원문 참조 |
| [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193), [MAE](https://arxiv.org/abs/2111.06377), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/), [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation) | 03 7장 개발 순서 | 기준선 고정, 한 번에 한 요소, 사다리 표, 싼 선별, 모듈 분리 관행의 근거로 삼음 | 원문 참조 |
- 위 자료에서 문장을 그대로 옮긴 곳은 없고, 요약하거나 절차로 다시 썼음. MIT 라이선스 자료는 원본 저장소와 저작권자를 위 표에 밝힘.

## 4. 라이선스
이 문서 묶음의 글은 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)으로 공개함. 출처를 밝히면 누구나 쓰고 고치고 나눌 수 있음. 3장의 외부 자료는 각자의 라이선스를 따름.
