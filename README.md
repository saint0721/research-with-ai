# research-with-ai

[한국어](README.ko.md)

A domain-agnostic skill for using AI coding agents (Claude Code, Codex) as research collaborators. It covers choosing a topic and checking prior work, designing experiments and models, running and diagnosing training, and reviewing manuscripts. The English edition is in `en/`, the Korean edition in `ko/`.

## Installation and use

| Item | Content |
| --- | --- |
| Purpose | How to install the `research-with-ai` skill and connect it to research work, and phrasings that work well when a researcher asks an AI for help |
| Readers | Researchers who install or share the skill. The skill does not read this file during research |
| Structure | §1 Installation and project setup, §2 Request patterns that work, §3 Sources and acknowledgements, §4 License |

## 1. Installation and project setup
How to install the skill and wire it in so that it is used in research work without the researcher naming it. The same steps apply when sharing it with others.

### 1.1 Skill layout
| File | Content | When it is read |
| --- | --- | --- |
| `SKILL.md` | Fixed entry point: trigger description and the instruction "read 00 first, then only the documents its table points to" | Automatically, for research work |
| `00-overview-and-principles.md` | Principles, research flow, operations, error signals, pre-report checklist | Always first, for research work |
| `01-tools-and-rules.md` | Tools and rules, wiki, incremental improvement | Starting a new project or repository; creating instructions, memory, skills, hooks or a wiki |
| `02-topic-question-prior-work.md` | Topic, method derivation, decision rules, prior work and novelty | That stage |
| `03-experiment-and-model.md` | Design, losses, environment and fairness, code, training, measurement, judgement | That stage |
| `04-operations.md` | Workers, servers and GPUs, long jobs, monitoring, security and cost, commits | That stage |
| `05-critique-and-writing.md` | Mock review, evaluation splits, manuscript structure and checks | That stage |
| `06-ai-errors.md` | Error types with their signals and countermeasures | When AI output looks wrong |
- There are no case studies. Numbers and names from one project would bias judgement, so lessons are written only as general rules with reasons.

### 1.2 Let the AI install it
Paste the following into Claude Code or Codex; the agent installs, connects and checks the skill.

```text
Install the research-with-ai skill from https://github.com/saint0721/research-with-ai.
1. Clone the repository and copy the English edition folder `en/` to ~/.claude/skills/research-with-ai and ~/.codex/skills/research-with-ai.
2. Append the "Connect to global instructions" block from the README to the end of ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md.
   Ask me which folder should hold the method documents, the improvement log and the improvement candidates, and fill in those paths in the block.
3. Confirm that in a new session, saying "let's design the experiment" makes the agent read this skill first, and report the result.
Ask me before overwriting any existing file.
```

### 1.3 Manual installation
- Put one of the repository folders, `en/` (English) or `ko/` (Korean), into the agent's skill location under the name `research-with-ai/`. Do not install both editions. Example: `~/.claude/skills/` for Claude Code, `~/.codex/skills/` for Codex.
- To keep editing the documents, keep the source documents elsewhere and make 00–06 in the skill folder symbolic links to them. The skill then changes as soon as the source is edited.
- When giving the skill to someone else, copy real files, not links (e.g. `cp -RL`).
- After installing, say something like "let's design the experiment" in a new session and check that the skill is loaded on its own.

### 1.4 Connect to global instructions
Automatic triggering alone can miss cases, so add the block below to the global instructions the agent always reads (Claude Code: `~/.claude/CLAUDE.md`, Codex: `~/.codex/AGENTS.md`).

```markdown
## Research method
- For any research work (topic, prior work, experiment or model design, training runs, result diagnosis, paper writing, research documentation), load the `research-with-ai` skill first and read only the reference file its table points to. The user does not need to name it.
- A project's own AGENTS.md / CLAUDE.md and the user's direct request take precedence over the skill.
- When the user corrects you or sets a new way of working, edit the matching method document in [method folder] in the same turn and add one line to [improvement log]. Lessons you inferred yourself go to [improvement candidates] and you ask the user once.
```

### 1.5 Connect to a research repository
Do not copy the skill into a research repository's instructions (`AGENTS.md` or `CLAUDE.md`); write only the values specific to that project. The skill holds the method, the repository instructions hold the project's values.

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

### 1.6 Updating
- When the source documents are edited, a skill linked to them changes at once. Do not edit installed files separately.
- When a principle changes, edit 00 from §2; when a method within a stage changes, edit that reference document.
- When the researcher corrects the agent or sets a new method, the agent edits the source document in the same turn (00, principle 17). Only lessons the AI inferred itself are kept as candidates and asked about (principle 18). The location of the candidate note is written in each user's global instructions (§1.4).

## 2. Request patterns that work
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

## 3. Sources and acknowledgements
This collection was made possible by the works below. Many thanks to the authors who shared their research methods and tools. All rights to each work remain with its authors.

| Work | Used in | How it is used | License |
| --- | --- | --- | --- |
| [scientific-coding-skill](https://github.com/cemde/scientific-coding-skill) (Cornelius, 2026) | 03 §6.1 Scientific coding principles | Principles translated and summarized. The original skill is installed for actual coding | MIT |
| [awesome-claudecode-paper-proofreading](https://github.com/LimHyungTae/awesome-claudecode-paper-proofreading) (Hyungtae Lim, 2026) | 05 §6.1 Proofreading workflow | Prompt names and scope are introduced. The prompts are not copied; they are taken from the original repository | MIT |
| [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) (Andrej Karpathy) | 01 §5, §8 | Follows the three layers (sources, wiki, schema) and the log and lint structure | See original |
| [Agentic Context Engineering (ACE)](https://arxiv.org/abs/2510.04618) (Zhang et al., 2025) | 01 §8 | Follows the principle of editing instructions item by item instead of rewriting them whole | Paper |
| [Hamming](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton & Steinhardt](https://arxiv.org/abs/1807.03341), [J.-B. Huang](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208) | 02 §2 Seven-step method derivation | Used as the basis of each step and arranged into a procedure | See originals |
| [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193), [MAE](https://arxiv.org/abs/2111.06377), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/), [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation) | 03 §7 Development order | Basis for the practices of a fixed baseline, one change at a time, a ladder table, cheap screening first, and separate modules | See originals |
- No sentence is copied verbatim from these works; they are summarized or rewritten as procedures. For the MIT-licensed works, the original repositories and copyright holders are named above.

## 4. License
The text of this collection is released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Anyone may use, adapt and share it with attribution. The external works in §3 follow their own licenses.
