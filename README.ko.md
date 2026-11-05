# research-with-ai

[English](README.md)

AI 에이전트(Claude Code, Codex)가 연구 동료로 일하게 만드는 [Claude Code 플러그인](https://code.claude.com/docs/en/plugins)이자 에이전트 스킬임.

AI 에이전트는 그럴듯한 답을 빨리 내도록 학습되어 있음. 연구에는 반대의 습관이 필요함. 모든 답을 원문으로 확인하고, 결정은 연구자에게 맡기고, 판정 기준은 결과 전에 고정하고, 한 번에 하나만 바꾸고, 실패를 성공만큼 꼼꼼히 기록해야 함. 이 스킬은 주제 정하기부터 원고 검증까지 연구 전 과정에서 이 습관을 지키게 함. 분야와 무관하며 한국어판과 영어판이 있음.

## 설치

### Claude Code 플러그인으로

Claude Code에서 실행:

```
/plugin marketplace add saint0721/research-with-ai
/plugin install research-with-ai-ko@research-with-ai
```

첫 명령은 이 저장소를 플러그인 마켓플레이스로 추가하고, 둘째 명령은 한국어판을 설치함. 영어판은 `research-with-ai@research-with-ai`로 설치함. 두 판을 함께 설치하지 않음.

참고 문서 03(6.1)이 연구 코드를 쓸 때 읽게 하는 Scientific Coding 플러그인도 함께 설치함. 둘 중 하나를 중복으로 보고 지우지 않음.

```
/plugin marketplace add cemde/Scientific-Coding-Skill
/plugin install scientific-coding@scientific-coding-skill
```

### 스킬로 직접 (Claude Code, Codex)

저장소를 받아 스킬 폴더 하나를 복사함:

```bash
git clone https://github.com/saint0721/research-with-ai.git

# Claude Code (모든 프로젝트)
cp -r research-with-ai/plugins/research-with-ai-ko/skills/research-with-ai ~/.claude/skills/

# Codex
cp -r research-with-ai/plugins/research-with-ai-ko/skills/research-with-ai ~/.codex/skills/
```

영어판은 `plugins/research-with-ai/skills/research-with-ai`를 복사함.

### 에이전트에게 설치 맡기기

아래 문장을 Claude Code나 Codex에 그대로 붙여 넣음:

```text
https://github.com/saint0721/research-with-ai 의 research-with-ai 스킬을 설치해 줘.
1. 저장소를 받아 plugins/research-with-ai-ko/skills/research-with-ai 를 ~/.claude/skills/research-with-ai 와 ~/.codex/skills/research-with-ai 에 복사해.
2. README의 "전역 지침에 연결" 문단을 ~/.claude/CLAUDE.md 와 ~/.codex/AGENTS.md 끝에 붙여.
   방법 문서·개선 일지·개선 후보를 둘 폴더를 나에게 물어 정하고, 문단의 경로 칸을 채워.
3. 새 세션에서 "실험 설계하자"라고 하면 이 스킬을 먼저 읽는지 확인하고 결과를 알려 줘.
기존 파일을 덮어쓰기 전에는 먼저 물어봐.
```

### 전역 지침에 연결

스킬의 자동 발동만으로는 놓칠 수 있으므로, 에이전트가 항상 읽는 지침에 아래 문단을 넣음(Claude Code: `~/.claude/CLAUDE.md`, Codex: `~/.codex/AGENTS.md`):

```markdown
## Research method
- For any research work (topic, prior work, experiment or model design, training runs, result diagnosis, paper writing, research documentation), load the `research-with-ai` skill first and read only the reference file its table points to. The user does not need to name it.
- A project's own AGENTS.md / CLAUDE.md and the user's direct request take precedence over the skill.
- When the user corrects you or sets a new way of working, edit the matching method document in [method folder] in the same turn and add one line to [improvement log]. Lessons you inferred yourself go to [improvement candidates] and you ask the user once.
```

### 연구 저장소에 연결

연구 저장소의 `AGENTS.md`나 `CLAUDE.md`에는 스킬 내용을 복사하지 않고, 그 연구에만 해당하는 값만 적음. 방법은 스킬이 맡음.

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

### 기록 확인 훅 켜기

플러그인에는 응답 종료 훅(`hooks/research_check.sh`)이 들어 있음. 연구 기록에 빈틈이 있으면 한 줄로 알리고, 없으면 아무것도 출력하지 않음. 빈틈은 문서 없이 코드를 바꾼 커밋, 위키 일지에 반영되지 않은 문서·노트, 노트 저장소에 보내지 않은 위키 작업 사본임. 훅에는 경로가 없음. 설정은 프로젝트 폴더마다 `.claude/research-with-ai.conf` 로 두고, 이 파일이 없는 프로젝트에서는 아무것도 하지 않음. 훅은 세션을 띄운 폴더의 파일과 그 아래 세 단계 안 프로젝트 폴더의 파일을 모두 찾아 프로젝트마다 따로 검사하므로, 노트 저장소 하나에 프로젝트가 여럿이면 프로젝트마다 파일을 하나씩 둠. 파일 안 경로는 그 프로젝트 폴더 기준임. 필요한 키만 적으면 그 키가 있는 확인만 돌아감.

```bash
# .claude/research-with-ai.conf
CODE_PATHS='^(src/|scripts/|paper/)'          # 바뀌면 문서가 필요한 경로
DOC_PATHS='^docs/'                            # 문서 경로
WIKI_DIR=.                                    # 위키 git 저장소: "." = 이 저장소, 또는 경로(상대·절대)
SOURCE_PATHS='^docs/(results|decisions)/'     # 위키가 반영해야 할 문서
WIKI_LOG='wiki/log.md'                        # WIKI_DIR 안의 위키 일지 파일
# NOTE_PATHS='^vault/Cards/'                  # 따로 있는 위키 작업 사본의 노트(선택)
# SYNC_TAG=pushed                             # 노트 저장소에 마지막으로 보낸 지점의 tag(선택)
# WINDOW='12 hours ago'                       # 살펴볼 기간
```

노트 저장소 안 프로젝트의 예(`<저장소>/Projects/연구A/.claude/research-with-ai.conf`):

```bash
WIKI_DIR=.
SOURCE_PATHS='^(Cards|Attachments)/'           # 연구A 폴더 기준
WIKI_LOG='Wiki/log.md'
```

알림 앞에는 `[Projects/연구A]` 처럼 프로젝트 경로가 붙음. 같은 커밋·상태는 한 번만 알림. 다른 기계에는 접속하지 않음.

### 개선 훅 켜기

두 번째 훅(`hooks/improve_check.sh`, 원칙 18)은 연구자가 매번 시키지 않아도 방법 노트가 점진적으로 나아지게 함. 연구자의 말이 정정이나 빈틈을 드러내는 물음("그게 아니라", "왜 이렇게 했어?")으로 보이면, 그 턴에 범용 교훈을 개선 후보에 남기라는 한 줄을 문맥에 넣음. 응답이 끝날 때는 상태마다 한 번씩, 쌓인 후보를 일의 매듭에서 모아 묻고, 공개판 이후 반영한 변경이 쌓였으면 올릴지 물으라고 알림. 그 밖에는 아무것도 출력하지 않고, 값이 없으면 아무 일도 하지 않음. 방법 노트는 보통 모든 프로젝트가 함께 쓰므로 값은 `~/.claude/research-with-ai.conf`에 둘 수 있음(프로젝트 자체 파일이 먼저).

```bash
# ~/.claude/research-with-ai.conf
IMPROVE_CANDIDATES="$HOME/notes/research-method/개선 후보.md"   # 대기 줄에는 "반영 여부 대기"
IMPROVE_LOG="$HOME/notes/research-method/개선 일지.md"          # "공개 저장소 반영" 줄이 마지막 공개판 표시
# SIGNAL_PATTERNS='그게 아니|왜 그렇게|잘못'   # 신호로 볼 말(정규식, 선택)
# PUBLISH_MIN=3                              # 공개 알림을 띄울 미반영 일지 줄 수
```

## 하는 일

에이전트가 연구 작업(주제 정하기, 선행 확인, 실험·손실 설계, 학습과 진단, 서버·워커 운영, 원고 검증)을 하면 스킬이 자동으로 불림. 항상 개요 문서를 먼저 읽고, 그 일에 필요한 참고 문서만 읽음.

핵심 원칙(`references/00-overview-and-principles.md`):

1. **결정은 연구자가 함** -- AI는 설명하고 번호 붙인 후보와 추천 하나를 냄
2. **설명이 먼저, 결정은 나중** -- 연구자가 이해하지 못한 결정을 받지 않음
3. **쉬운 말과 숫자 예시** -- 연구자에게 수식이나 내부 코드명을 쓰지 않음
4. **제안 전에 기록 확인** -- 닫힌 방향을 다시 제안하지 않음
5. **판정 기준은 결과 전에 고정** -- 분할·문턱·채택 규칙을 사전 등록
6. **한 번에 하나만 바꿈** -- 한 줄에 한 변경, 같은 조건
7. **버리기 전에 진단** -- 구현, 빠진 표준 기법, 기록과 체크포인트 순서
8. **학습 없는 사전 측정은 멈출 때만** -- 방향을 닫을 수는 있어도 진행 근거는 아님
9. **재현성과 공정성을 먼저 고정** -- 코드·환경·데이터·설정·seed, 자원은 맞추고 장치는 맞추지 않음
10. **학습 중에는 모든 것을 재되, 같은 결과를 두 번 얻지 않음** -- 결과가 왜 그렇게 나왔는지 설명하기 위해; 확인·재실행 전에 바꾸는 결정을 적고 이미 있는 결과를 찾음
11. **방향은 학습 결과로만 닫음**
12. **할 일의 순서를 지킴** -- 여러 seed와 추가 데이터셋은 모델 확정 뒤
13. **같은 턴에 기록** -- 일지, 주제 페이지, 상태 색인
14. **반복되는 지시는 장치로** -- 지침, 메모리, 스킬, 훅
15. **AI 출력은 원본과 대조** -- 논문, 인용, 숫자, 그림
16. **실패는 모두 기록하되, 논문에는 채택한 구성과 그 ablation만**
17. **연구자의 정정은 방법 문서에 바로 반영**
18. **AI가 스스로 알아낸 교훈은 시키지 않아도 쌓음** -- 범용으로 쓰고, 같은 교훈은 합치고, 매듭에서 모아 물음; 개선 훅이 받침

| 참고 문서 | 내용 |
| --- | --- |
| `00-overview-and-principles.md` | 원칙, 승인 범위, 연구 흐름과 방향 전환, 운영, 오류 신호, 보고 전 점검표 |
| `01-tools-and-rules.md` | 도구, 지침 계층, 메모리, 스킬, 훅, LLM 위키와 노트 저장소, 문서화, 감시, 점진 개선 |
| `02-topic-question-prior-work.md` | 주제, 방법 도출 7단계, 질문과 판정 규칙, 선행연구, 공백과 신규성 |
| `03-experiment-and-model.md` | 설계 대화, 과학적·손실 검토, 재현성, 공정 비교, 코드, 개발 순서, 학습 중 측정, 판정 |
| `04-operations.md` | 리더와 워커, 긴 작업, 서버와 GPU, 감시, 보안과 비용, 커밋 |
| `05-critique-and-writing.md` | 모의 심사, 평가 split, 논문에 싣는 것, 원고 구조와 검증 |
| `06-ai-errors.md` | 오류 유형별 신호와 대응 |

문서에는 사례가 없음. 특정 연구의 숫자와 이름이 섞이면 에이전트의 판단이 한쪽으로 끌리므로, 모든 교훈을 일반 규칙과 이유로 씀.

### 점진적 자가발전

이 스킬은 쓰는 동안 스스로 나아짐. 연구자가 "이 규칙을 넣어라"라고 매번 말하지 않아도 됨.

```
작업 중 신호 ─▶ 개선 후보(범용 교훈 한 줄) ─▶ 매듭에서 모아 승인 ─▶ 방법 문서 반영 ─▶ 공개판 ─▶ 다음 세션의 스킬
(정정, "왜 그렇게 했어?", 같은 실수 두 번째, 새 절차, 도구 실패, 답답함)
```

- **연구자의 정정**은 그 턴에 바로 방법 문서에 들어감(원칙 17).
- **AI가 알아낸 교훈**은 시키지 않아도 개선 후보에 한 줄로 쌓임. 사례는 신호 칸에만 적고 교훈은 "언제 → 무엇을 → 왜"로 범용으로 씀. 같은 교훈은 새 줄 대신 그 줄에 합침. 쌓인 후보는 일의 매듭에서 모아 한 번에 물음(원칙 18).
- **개선 훅**(아래)이 이 고리를 잊지 않게 받침: 정정처럼 보이는 말에 후보 알림, 응답 끝에 대기 후보와 미공개 반영 알림.
- 반영할 때마다 개선 일지에 한 줄을 남겨, 언제 무엇이 왜 바뀌었는지 되짚을 수 있음(`01-tools-and-rules.md` 8장).

## 효과가 있는 요청 패턴

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

## 내 판으로 고쳐 쓰기

이 스킬은 연구와 함께 자라도록 만든 것임. 방법 문서를 자기 노트에 두고 설치한 스킬의 파일을 그 노트로 가는 심볼릭 링크로 두면, 고치는 즉시 반영됨. 연구자가 에이전트를 정정하면 에이전트가 그 턴에 해당 문서를 고침(원칙 17). 다른 사람과 나눌 때는 링크가 아니라 실제 파일을 복사함(`cp -RL`).

공개된 스킬을 설치해 쓰면서 기여할 때는 자기 노트에서 먼저 다듬고, 다듬어졌다고 판단한 판만 교정 몇 개씩 묶어 올린 뒤 설치본을 갱신함(`01-tools-and-rules.md` 8.4).

## 구조

```
research-with-ai/
├── .claude-plugin/
│   └── marketplace.json                  # 마켓플레이스 목록 (두 판)
├── plugins/
│   ├── research-with-ai/                 # 영어판
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/research-with-ai/
│   │       ├── SKILL.md                  # 입구
│   │       └── references/               # 00~06 문서
│   └── research-with-ai-ko/              # 한국어판 (같은 구조)
├── CITATION.cff
├── LICENSE
├── README.md
└── README.ko.md
```

## 기여

기여를 환영함. 특히 아래가 도움이 됨.

- **검증.** 스킬이 있을 때와 없을 때 에이전트 행동의 비교, 스킬이 실패하는 경우.
- **새 규칙.** AI 에이전트가 연구에서 반복하는 실수 가운데 문서에 아직 없는 것.
- **정정.** 틀렸거나 오해를 부르거나 미묘한 점을 빠뜨린 규칙.
- **번역.** 한국어판과 영어판을 맞추거나 다른 언어 추가.

[github.com/saint0721/research-with-ai](https://github.com/saint0721/research-with-ai)에 이슈나 풀 리퀘스트를 열어 주면 됨.

## 감사의 말

이 스킬은 연구자와 AI 에이전트가 함께한 일상 연구에서 나왔음. 연구자가 에이전트를 정정할 때마다 규칙을 적고 일반화했음. 아래 자료 덕분에 만들 수 있었으며, 연구 방법과 도구를 공개해 준 저작자들께 감사드림. 각 자료의 권리는 원저작자에게 있음.

| 자료 | 쓴 곳 | 쓴 방식 | 라이선스 |
| --- | --- | --- | --- |
| [Scientific Coding Skill](https://github.com/cemde/Scientific-Coding-Skill) (Cornelius Emde) | 03 6.1 과학 코드 원칙 | 원칙을 한국어로 옮겨 요약함. 실제 코딩에는 원본 스킬을 설치해 씀 | MIT |
| [awesome-claudecode-paper-proofreading](https://github.com/LimHyungTae/awesome-claudecode-paper-proofreading) (임형태, Hyungtae Lim) | 05 6.1 교정 운영 | 프롬프트 이름과 검사 범위를 소개함. 프롬프트 본문은 옮기지 않고 원본에서 받아 씀 | MIT |
| [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (Andrej Karpathy) | 01 5장, 8장 | 원천·위키·스키마 세 층과 일지·점검 구조를 따름 | 원문 참조 |
| [Agentic Context Engineering (ACE)](https://arxiv.org/abs/2510.04618) (Zhang 외, 2025) | 01 8장 | 지침을 통째로 다시 쓰지 않고 항목 단위로 고치는 원칙을 따름 | 논문 |
| [Hamming](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton·Steinhardt](https://arxiv.org/abs/1807.03341), [J.-B. Huang](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208) | 02 2장 방법 도출 7단계 | 각 단계의 근거로 삼아 절차로 정리함 | 원문 참조 |
| [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193), [MAE](https://arxiv.org/abs/2111.06377), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/), [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation) | 03 7장 개발 관행 | 관행마다 03 7장에서 본문 위치와 근거를 짝지음 | 원문 참조 |

위 자료에서 문장을 그대로 옮긴 곳은 없고, 요약하거나 절차로 다시 썼음. MIT 라이선스 자료는 원본 저장소와 저작권자를 위 표에 밝힘.

## 인용

연구에 쓰거나 논문에서 언급할 때는 [CITATION.cff](CITATION.cff)를 참고함.

```bibtex
@software{saint0721_2026_researchwithai,
  author  = {saint0721},
  title   = {research-with-ai: Using AI Agents as Research Collaborators},
  year    = {2026},
  url     = {https://github.com/saint0721/research-with-ai},
  version = {0.2.0}
}
```

## 라이선스

이 문서 묶음의 글은 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)으로 공개함. 출처를 밝히면 누구나 쓰고 고치고 나눌 수 있음. 감사의 말에 적은 외부 자료는 각자의 라이선스를 따름.
