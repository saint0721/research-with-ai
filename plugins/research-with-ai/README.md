# research-with-ai

An agent skill that teaches Claude to work as a research collaborator, across the whole research cycle: choosing a topic and checking prior work, setting decision rules before results, designing experiments and losses, keeping runs reproducible and comparisons fair, measuring and diagnosing training, operating servers and workers, and reviewing manuscripts. It is domain-agnostic.

AI agents are trained to produce a plausible answer quickly. Research needs the opposite habits: check every answer against the original source, leave decisions to the researcher, fix the judging rules before the results, change one thing at a time, and record failures as carefully as successes. This skill encodes those habits.

## How it works

The skill activates when you do research work, for example "let's design the experiment", "check the results" or "why didn't it improve". It first reads `references/00-overview-and-principles.md` (principles, approval scope, research flow, operations, error signals, pre-report checklist), then only the reference document the task needs:

| Reference | Covers |
| --- | --- |
| `01-tools-and-rules.md` | Instruction layers, memory, skills, hooks, LLM wiki, documentation, monitoring |
| `02-topic-question-prior-work.md` | Topic, seven-step method derivation, decision rules, prior work, novelty |
| `03-experiment-and-model.md` | Design conversation, scientific and loss review, reproducibility, fair comparison, code, in-training measurement, judgement |
| `04-operations.md` | Leader and workers, long jobs, servers and GPUs, monitoring, security and cost, commits |
| `05-critique-and-writing.md` | Mock review, evaluation splits, manuscript structure and checks |
| `06-ai-errors.md` | Error types with their signals and countermeasures |

## What it runs and sends

This plugin contains only Markdown documents. It has no hooks, no MCP servers and no scripts, and it does not send or fetch any data by itself. Some rules tell Claude to read files in your repository or to check sources on the web when you ask for research work; Claude does that with its normal tools and permissions.

## More

Installation for Codex, global-instruction setup, request patterns, acknowledgements and citation: https://github.com/saint0721/research-with-ai

License: CC BY 4.0.
