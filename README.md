# research-with-ai

AI 에이전트(Claude Code, Codex)를 연구 동료로 쓰는 방법을 담은 스킬임. 분야와 무관하며, 연구 주제부터 실험·모델 개발, 원고 검증까지 다룸.

*A domain-agnostic skill for using AI coding agents (Claude Code, Codex) as research collaborators: topic and prior work, experiment and model design, training and diagnosis, manuscript review. Written in Korean.*

## 설치와 사용 안내

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
| `00-overview-and-principles.md` | 원칙, 연구 흐름, 운영, 오류 신호, 보고 전 점검표 | 연구 작업이면 항상 먼저 |
| `01-tools-and-rules.md` | 도구와 규칙, 위키, 점진 개선 | 새 연구·저장소 시작, 지침·메모리·스킬·훅·위키를 만들 때 |
| `02-topic-question-prior-work.md` | 주제, 방법 도출, 판정 기준, 선행·신규성 | 해당 단계 |
| `03-experiment-and-model.md` | 설계, 손실, 환경·공정성, 코드, 학습, 측정, 판정 | 해당 단계 |
| `04-operations.md` | 워커, 서버·GPU, 긴 작업, 감시, 보안·비용, 커밋 | 해당 단계 |
| `05-critique-and-writing.md` | 모의 심사, 평가 split, 원고 구조·검증 | 해당 단계 |
| `06-ai-errors.md` | 오류 유형별 신호와 대응 | AI 출력이 이상할 때 |
| `README.md` | 이 안내 | 설치할 때, 사람이 읽음 |
- 사례는 두지 않음. 특정 연구의 숫자와 이름이 섞이면 판단이 한쪽으로 끌리므로, 교훈은 일반 규칙과 이유로만 씀.

### 1.2 설치
- 받은 스킬 폴더(`research-with-ai/`)를 에이전트의 스킬 위치에 둠. 예: Claude Code는 `~/.claude/skills/`, Codex는 `~/.codex/skills/`.
- 문서를 직접 고쳐 가며 쓰려면, 원본 문서를 따로 두고 스킬 폴더의 00~06을 그 원본으로 가는 심볼릭 링크로 둠. 그러면 원본을 고치는 즉시 스킬이 바뀜.
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

## 3. 출처와 감사
이 문서 묶음이 가져오거나 바탕으로 삼은 외부 자료임. 각 자료의 권리는 원저작자에게 있음.

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
