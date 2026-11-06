# research-with-ai

[한국어](README.ko.md)

A [Claude Code plugin](https://code.claude.com/docs/en/plugins) and agent skill that teaches AI agents (Claude Code, Codex) to work as research collaborators.

AI agents are trained to produce a plausible answer quickly. Research needs the opposite habits: check every answer against the original source, leave decisions to the researcher, fix the judging rules before the results, change one thing at a time, and record failures as carefully as successes. This skill encodes those habits for the whole research cycle, from choosing a topic to reviewing the manuscript. It is domain-agnostic and comes in English and Korean.

## Install

### As a Claude Code plugin

In Claude Code, run:

```
/plugin marketplace add saint0721/research-with-ai
/plugin install research-with-ai@research-with-ai
```

The first command adds this repository as a plugin marketplace. The second installs the English edition. For the Korean edition, install `research-with-ai-ko@research-with-ai` instead. Install only one edition.

Also install the Scientific Coding plugin, which reference 03 (§6.1) tells the agent to write research code with. Keep both; do not remove one as a duplicate.

```
/plugin marketplace add cemde/Scientific-Coding-Skill
/plugin install scientific-coding@scientific-coding-skill
```

### As a standalone skill (Claude Code, Codex)

Clone the repository and copy one skill directory:

```bash
git clone https://github.com/saint0721/research-with-ai.git

# Claude Code (all projects)
cp -r research-with-ai/plugins/research-with-ai/skills/research-with-ai ~/.claude/skills/

# Codex
cp -r research-with-ai/plugins/research-with-ai/skills/research-with-ai ~/.codex/skills/
```

Use `plugins/research-with-ai-ko/skills/research-with-ai` for the Korean edition.

### Let your agent install it

Paste the following into Claude Code or Codex:

```text
Install the research-with-ai skill from https://github.com/saint0721/research-with-ai.
1. Clone the repository and copy plugins/research-with-ai/skills/research-with-ai to ~/.claude/skills/research-with-ai and ~/.codex/skills/research-with-ai.
2. Append the "Connect to global instructions" block from the README to the end of ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md.
   Ask me which folder should hold the method documents, the improvement log and the improvement candidates, and fill in those paths in the block.
3. Confirm that in a new session, saying "let's design the experiment" makes the agent read this skill first, and report the result.
Ask me before overwriting any existing file.
```

### Connect to global instructions

Automatic triggering alone can miss cases. Add this block to the instructions the agent always reads (Claude Code: `~/.claude/CLAUDE.md`, Codex: `~/.codex/AGENTS.md`):

```markdown
## Research method
- For any research work (topic, prior work, experiment or model design, training runs, result diagnosis, paper writing, research documentation), load the `research-with-ai` skill first and read only the reference file its table points to. The user does not need to name it.
- A project's own AGENTS.md / CLAUDE.md and the user's direct request take precedence over the skill.
- When the user corrects you or sets a new way of working, edit the matching method document in [method folder] in the same turn and add one line to [improvement log]. Lessons you inferred yourself go to [improvement candidates] and you ask the user once.
```

### Connect to a research repository

Do not copy the skill into a project's `AGENTS.md` or `CLAUDE.md`. Write only the values specific to that project; the skill holds the method.

```markdown
## Research method
- Follow the `research-with-ai` skill. Project-specific values:
  - Main metric / guard metric: [e.g. main metric, guard metric and allowed drop]
  - Baseline row and adoption rule: [e.g. baseline, single-seed adoption rule, multiple seeds after the model is fixed]
  - Protocol (protected keys): [split, labels, number of updates, batch, learning-rate schedule, evaluation, seeds]
  - Runner and launch command: [runner command and argument format]
  - Wiki: [locations of the state index, topic pages and log]
  - Constraints: [inputs and techniques not to use, prohibitions]
  - Approval: [what may be done without the researcher's approval, e.g. training after a successful smoke test]
```

### Turn on the record check hook

The plugin ships a Stop hook (`hooks/research_check.sh`) that prints one line when the research record has a gap and nothing otherwise: a commit that changed code without a document, a document or note not ingested into the wiki log, or a wiki working copy not pushed to the note vault. The hook holds no paths. Each project folder holds its own `.claude/research-with-ai.conf`, and a project without the file is left alone. The hook finds the file in the session folder and every file in project folders up to three levels below it and checks each project separately, so a note vault with several projects gets one file per project. Paths in a file are relative to its project folder. Set only the keys you need; each check runs only when its keys are set.

```bash
# .claude/research-with-ai.conf
CODE_PATHS='^(src/|scripts/|paper/)'          # changes that need a document
DOC_PATHS='^docs/'                            # where documents live
WIKI_DIR=.                                    # wiki git repo: "." = this repo, or a path (relative or absolute)
SOURCE_PATHS='^docs/(results|decisions)/'     # documents the wiki must ingest
WIKI_LOG='wiki/log.md'                        # wiki log file inside WIKI_DIR
# NOTE_PATHS='^vault/Cards/'                  # notes in a separate wiki working copy (optional)
# SYNC_TAG=pushed                             # tag marking the last push to a note vault (optional)
# WINDOW='12 hours ago'                       # how far back to look
```

Example for a project inside a note vault (`<vault>/Projects/study-a/.claude/research-with-ai.conf`):

```bash
WIKI_DIR=.
SOURCE_PATHS='^(Cards|Attachments)/'           # relative to study-a
WIKI_LOG='Wiki/log.md'
```

Each reminder starts with the project path, such as `[Projects/study-a]`. A commit or state is reported once. Two more behaviours keep the alerts trustworthy: a code commit whose neighbouring commit inside the window carries a document is not reported (one work often goes up as several commits), and a `WIKI_DIR` that is not a git repository on this machine is reported once, since an old path left after moving machines would otherwise switch the wiki checks off without a word. The hook never connects to another machine.

### Turn on the improvement hook

A second hook (`hooks/improve_check.sh`, principle 18) keeps the method notes improving without the researcher asking each time. When the researcher's message looks like a correction or a gap-revealing question ("that's not what I asked", "why did you…"), it adds one line of context reminding the agent to log a general lesson in the candidate note in that turn. At the end of a response it reminds once (per state) to ask about pending candidates at a work milestone, and to ask about publishing when accepted changes have piled up since the last public release. It is silent otherwise and does nothing without its keys. Because the method notes are usually shared by all projects, the keys can sit in `~/.claude/research-with-ai.conf` (a project's own file takes precedence):

```bash
# ~/.claude/research-with-ai.conf
IMPROVE_CANDIDATES="$HOME/notes/research-method/improvement-candidates.md"   # pending lines carry "awaiting decision"
IMPROVE_LOG="$HOME/notes/research-method/improvement-log.md"                 # a line with "public release" marks the last release
# SIGNAL_PATTERNS='not what i|wrong|why did you'   # extended regex for signal messages (optional)
# PUBLISH_MIN=3                                   # unpublished log lines before the publish reminder
```

## What It Does

The skill activates automatically when the agent does research work: choosing a topic, checking prior work, designing experiments or losses, running and diagnosing training, operating servers and workers, or reviewing a manuscript. It always reads the overview first, then only the reference document the task needs.

Core principles (from `references/00-overview-and-principles.md`):

1. **The researcher decides** -- the AI explains, offers numbered options and recommends one
2. **Explanation first, decision later** -- never take a decision the researcher has not understood
3. **Plain words with numeric examples** -- no formulas or internal code names when talking to the researcher
4. **Check the records before proposing** -- do not re-propose closed directions
5. **Fix judging rules before results** -- splits, thresholds and adoption rules are pre-registered
6. **Change one thing at a time** -- one change per row, same conditions
7. **Diagnose before dropping** -- implementation, missing standard techniques, then logs and checkpoints
8. **Pre-measurement without training only stops** -- it may close a direction, never justify one
9. **Fix reproducibility and fairness first** -- code, environment, data, config and seeds; match resources, not mechanisms
10. **Measure everything during training, but never obtain the same result twice** -- to explain why a result came out as it did; before any check or rerun, state the decision it changes and look for an existing result
11. **Close a direction only on trained results**
12. **Keep the order of work** -- multi-seed runs and extra datasets after the model is fixed
13. **Record in the same turn** -- log, topic page and status index
14. **Turn repeated instructions into mechanisms** -- instructions, memory, skills, hooks
15. **Check AI output against originals** -- papers, citations, numbers, figures
16. **Record all failures; publish only adopted components and their ablations**
17. **Apply the researcher's corrections to the method documents at once**
18. **Collect lessons the AI found by itself without being asked** -- general wording, merged duplicates, asked together at a milestone; backed by the improvement hook

| Reference document | Covers |
| --- | --- |
| `00-overview-and-principles.md` | Principles, approval scope, research flow and direction changes, operations, error signals, pre-report checklist |
| `01-tools-and-rules.md` | Tools, instruction layers, memory, skills, hooks, LLM wiki and note vault, documentation, monitoring, incremental improvement |
| `02-topic-question-prior-work.md` | Topic, seven-step method derivation, questions and decision rules, prior work, gaps and novelty |
| `03-experiment-and-model.md` | Design conversation, scientific and loss review, reproducibility, fair comparison, code, development order, in-training measurement, judgement |
| `04-operations.md` | Leader and workers, long jobs, servers and GPUs, monitoring, security and cost, commits |
| `05-critique-and-writing.md` | Mock review, evaluation splits, what goes in the paper, manuscript structure and checks |
| `06-ai-errors.md` | Error types with their signals and countermeasures |

The documents contain no case studies. Numbers and names from one project would bias the agent's judgement, so every lesson is written as a general rule with its reason.

### Progressive self-improvement

The skill improves itself while you use it. The researcher does not have to say "add this rule" each time.

```
signal during work ─▶ improvement candidate (one general lesson) ─▶ approved together at a milestone ─▶ method document ─▶ public release ─▶ next session's skill
(a correction, "why did you…", the same mistake twice, a new procedure, a tool failure, frustration)
```

- **The researcher's corrections** go into the method documents in the same turn (principle 17).
- **Lessons the AI finds** pile up as one-line candidates without being asked. Only the signal column names the case; the lesson is written in general form as "when → what → why". The same lesson is merged into its existing line instead of a new one. Accumulated candidates are asked about together at a work milestone (principle 18).
- **The improvement hook** (below) keeps the loop from being forgotten: a reminder on correction-like messages, and at the end of a response a reminder about pending candidates and unpublished changes.
- Every change leaves one line in the improvement log, so what changed, when and why can be traced (`01-tools-and-rules.md` Ch. 8).

## Request patterns that work

Phrasings that improve results when a researcher talks to an AI. They work without the skill as well.

| Pattern | Example |
| --- | --- |
| State the target standard | "What is missing for this to meet [target standard]?" |
| Doubt the answer | "Is this really fair?", "Is that really prior work?" |
| Ask for evidence | "Download the original and check", "Find every sentence like this" |
| Ask about unclear terms | "What exactly does [term] mean?" |
| Confirm understanding | "I understand that ~. So does that mean ~?" |
| Defer the decision | "I won't decide yet; explain first" |
| Delegate the decision | "You decide. Research it if you need to" |
| Limit the scope | "Don't plan experiments yet", "Don't push" |
| Ask for benefit and role | "Is the benefit worth it? What role does this play?" |
| Look for alternatives | "Is there something better? Check what other papers do" |
| Check the procedure | "Did you follow the rules?" |
| Delegate in parallel | "Spin up agents to search further", "You review" |
| Ask for a record | "Write this down", "Add it to the instructions" |

## Keeping your own edits

The skill is meant to grow with your research. Keep the method documents in your own notes and make the files in the installed skill symbolic links to them; edits then take effect at once. When the researcher corrects the agent, the agent edits the matching document in the same turn (principle 17). When sharing your version, copy real files, not links (`cp -RL`).

If you install the published skill and also contribute to it, refine the documents in your own notes first and publish only versions you judge refined, bundling several corrections per version; then update your installed copy (`01-tools-and-rules.md` §8.4).

## Structure

```
research-with-ai/
├── .claude-plugin/
│   └── marketplace.json                  # Marketplace catalog (two editions)
├── plugins/
│   ├── research-with-ai/                 # English edition
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/research-with-ai/
│   │       ├── SKILL.md                  # Entry point
│   │       └── references/
│   │           ├── 00-overview-and-principles.md
│   │           ├── 01-tools-and-rules.md
│   │           ├── 02-topic-question-prior-work.md
│   │           ├── 03-experiment-and-model.md
│   │           ├── 04-operations.md
│   │           ├── 05-critique-and-writing.md
│   │           └── 06-ai-errors.md
│   └── research-with-ai-ko/              # Korean edition (same layout)
├── CITATION.cff
├── LICENSE
├── README.md
└── README.ko.md
```

## Contributing

Contributions are welcome, in particular:

- **Validation.** Before/after comparisons of agent behaviour with and without the skill, and cases where it fails.
- **New rules.** Mistakes AI agents make repeatedly in research work that the documents do not yet cover.
- **Corrections.** Rules that are wrong, misleading or missing nuance.
- **Translations.** Keep the English and Korean editions in step, or add another language.

Open an issue or a pull request at [github.com/saint0721/research-with-ai](https://github.com/saint0721/research-with-ai).

## Acknowledgements

This skill grew out of daily research work between a researcher and AI agents. Its rules were written down each time the researcher corrected the agent, and then generalised. It was made possible by the works below; many thanks to the authors who shared their research methods and tools. All rights to each work remain with its authors.

| Work | Used in | How it is used | License |
| --- | --- | --- | --- |
| [Scientific Coding Skill](https://github.com/cemde/Scientific-Coding-Skill) (Cornelius Emde) | 03 §6.1 Scientific coding principles | Principles translated and summarized. The original skill is installed for actual coding | MIT |
| [awesome-claudecode-paper-proofreading](https://github.com/LimHyungTae/awesome-claudecode-paper-proofreading) (Hyungtae Lim) | 05 §6.1 Proofreading workflow | Prompt names and scope are introduced. The prompts are not copied; they are taken from the original repository | MIT |
| [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (Andrej Karpathy) | 01 §5, §8 | Follows the three layers (sources, wiki, schema) and the log and lint structure | See original |
| [Agentic Context Engineering (ACE)](https://arxiv.org/abs/2510.04618) (Zhang et al., 2025) | 01 §8 | Follows the principle of editing instructions item by item instead of rewriting them whole | Paper |
| [Hamming](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton & Steinhardt](https://arxiv.org/abs/1807.03341), [J.-B. Huang](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208) | 02 §2 Seven-step method derivation | Used as the basis of each step and arranged into a procedure | See originals |
| [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193), [MAE](https://arxiv.org/abs/2111.06377), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/), [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation) | 03 §7 Development practices | Each practice is mapped to its section and source in 03 §7 | See originals |

No sentence is copied verbatim from these works; they are summarized or rewritten as procedures. For the MIT-licensed works, the original repositories and copyright holders are named above.

## Citation

If you use this skill in your research or reference it in a publication, see [CITATION.cff](CITATION.cff).

```bibtex
@software{saint0721_2026_researchwithai,
  author  = {saint0721},
  title   = {research-with-ai: Using AI Agents as Research Collaborators},
  year    = {2026},
  url     = {https://github.com/saint0721/research-with-ai},
  version = {0.2.0}
}
```

## License

The text of this collection is released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Anyone may use, adapt and share it with attribution. The works listed under Acknowledgements follow their own licenses.
