# Research with AI — Tools and Rules

| Item | Content |
| --- | --- |
| Purpose | Using only this document, set up the tools for research with AI agents and create and run instructions, memory, skills, hooks and a wiki |
| When to read | When starting a new study or repository, when the same instruction keeps being repeated, when creating or changing instructions, memory, skills, hooks or the wiki, when research is interrupted because the session changed |
| Output | Tool setup, instruction files matching the rule layers, memory, skills and hooks, wiki skeleton (status index, topic pages, log), documentation timing table |
| Structure | Ch. 0 work order, Ch. 1–7 methods |

## 0. Work order
The steps and outputs when first setting up a research environment.

| Step | Chapter | Output |
| --- | --- | --- |
| Set up tools | 1 Always-used tools, 2 On-request tools | Agent, screen, server and document repository setup |
| Set rules | 3 Rule layers, 4 Writing rule tools | Instruction files, memory, skills, hooks |
| Record system | 5 LLM wiki, 6 Document system | Wiki skeleton, documentation timing table, document format |
| Keep improving | 7 Incremental improvement of method documents | Improvement candidate note, improvement log |

## 1. Always-used tools
The role and operating principles of tools used in everyday research work. Tools fall into agents, screen, compute, documents, rules and outputs; the layers and writing of the rule tools (instructions, memory, skills, hooks) are covered in §3 and §4.

| Category | Tool | Role and operating principles |
| --- | --- | --- |
| Agent | Main working agent | Does design, analysis, code, verification, commits and documentation itself. The criteria for work to hand to workers are in 05 §1.1 |
| Screen | Terminal pane manager | Splits agents and monitors into visible panes. The monitor pane sits below the conversation pane, not beside it |
| Compute | Remote GPU server | Runs training and measurement. The agent runs on the laptop and computation runs on the server; training is launched through a queue runner |
| Documents | Code repository documents | Plan, design and result documents. The source of truth for numbers |
| Documents | Project wiki | Status index, topic pages and log. Kept in either the code repository or the note repository (5.1) |
| Documents | Note repository | Human-readable write-ups. Not a place to pile up conversation logs. Each project has a hub document and an index of all its material |
| Rules | Instruction files | Rules the agent reads when starting work |
| Rules | Memory | Keeps lessons from incidents and the researcher's decision principles together with their reasons |
| Rules | Skills | Bundle repeated procedures and load them automatically when the situation matches |
| Rules | Hooks | Check scripts that run automatically at set points |
| Outputs | Browser pages | Used for outputs viewed in a browser, such as labeling pages, qualitative examples and inspection pages |

## 2. On-request tools
Tools that combine several agents are used only when the researcher explicitly asks. Do not use them merely because a pane is open or parallel gains are expected, because cost and confusion grow; this restriction is written into the global instructions.

| Function | Role | Condition of use |
| --- | --- | --- |
| Consultation | Multi-turn discussion with a read-only peer agent. The peer does not edit files, and its conclusion is grounds for judgment, not approval | Review of an idea or design before confirming it; a second opinion on finished work |
| Session handoff | Writes the current state into one file, and a new session reads it and takes over | When the conversation becomes long and responses heavy; at the boundary after a stage ends |
| Session takeover | Another session takes over work interrupted by a usage limit or a lost pane. Includes searching past conversation logs | Usage limit reached; work interrupted by a closed terminal |
| Worker group | Assigns non-overlapping work to several workers and proves completion by commits | Several independent tasks, and parallel execution was requested |
| Remote work | Lets a worker on the laptop work on a remote server | Handing server work to a separate worker |
- The default budget of the consultation tool often ends after a few exchanges, so give a real discussion enough turns and time, and keep a summary of the conclusion as the record when closing.
- Before sending a consultation query, show the draft query to the researcher for confirmation, and write it in three parts. ① Material to give: copy result and measurement numbers verbatim from the documents and give the document paths so the counterpart reads them directly; state the fixed conditions and the research goal as well. ② 3–4 questions whose answers change the next action: choosing the next row (have the counterpart first write, for each candidate, the predicted result under each hypothesis, and pick the row that best separates the decisions), mechanism candidates and one measurement to check without training, design (down to the formula and the gradient path), and the control for the chosen row and the judgment criterion to register before results. ③ Manner: read-only; get a design, not just critique; leave the answer in a new section of the consultation record and explain it to the researcher in summary; a new design goes through the design document and review sequence. Do not repeat the same question, and do not pass a hypothesis off as a conclusion.
- Use the expensive consultation counterpart (the top-tier model) sparingly. ① The leader prepares: before consulting, write a one-page summary document (purpose, supporting numbers, what is closed, the conditions under which old failures repeat, risks), and narrow the files the counterpart reads to that document, the related survey documents and a few code locations needed for the design (do not have it read broad records from the start). ② If prior work needs reinforcing, hand it beforehand to a cheap research agent separately, and give its results as material. ③ Ask in one go and set the answer length: direction judgment, ranking of alternatives (existing candidates + at most two), design for the first-ranked one only (formula, gradient path, cost, code location, control, criterion before results). ④ The default number of uses of the counterpart is one design plus one SDD review. The query order is: a cheap research agent finds → the leader organizes (survey document, one-page summary, draft query, researcher confirmation) → the expensive counterpart fixes the judgment and design. If the counterpart rereads broad records, one round costs a lot, spent on re-finding facts the leader already knows.
- Hand off a session only after finishing the file work in progress. The handoff file holds the remaining work, the location of evidence and the next commands; the new session gets only a two- or three-line instruction to read that file.

## 3. Rule layers
Rules are layered by scope, and each rule goes in the narrowest layer. Precedence is researcher instruction > nearest instructions > higher-level instructions > global instructions.

| Layer | Rules it holds |
| --- | --- |
| Researcher's direct instruction | Takes precedence over every rule |
| Global instructions | Coding posture, assembly-style model development principles, tool-use restrictions |
| Note repository instructions | Writing style, file names, hub documents, verdict table format |
| Project instructions | Project boundaries, wiki structure, document layers |
| Code repository instructions | Build and run commands, development order, measurement rules |
| Memory | Lessons from incidents and decision principles |
| Skills | Repeated procedures |

A research repository's instructions do not copy the method; they hold only that study's values (metrics, thresholds, paths, protected keys, seed list) and point to the method by the skill's section number (e.g. 03 §7). The agent reads that section only when needed. A copied rule stays behind and diverges when the original changes.
- Keep the same rule in both the human-facing document and the agent instructions, and change them together.

## 4. Writing rule tools
The basic direction: when the same instruction keeps being repeated, do not say it again; move it into instructions, memory, a skill or a hook. The four tools differ in when they are created and how they are verified, so they are split as in the table below; the detailed formats for memory, skills and hooks are in 4.1.

| Tool | When to create | Format | Verification |
| --- | --- | --- | --- |
| Instructions | When the same instruction has been repeated twice or more, or a project-specific rule appears | One line of rule and one line of reason. Long explanations go into an operations document, with only its location noted | In a new session, give a task that needs the rule and check compliance |
| Memory | When an incident, a researcher correction or a researcher decision occurs | One file per rule: rule → reason → how to apply | Check that the same mistake does not recur in the same situation |
| Skill | When the same procedure has been explained several times | One folder and one procedure file; split into reference files when long | Check that saying the trigger phrase loads the skill |
| Hook | When a rule is not kept by instructions alone and can be judged mechanically | A check script registered in the settings file | Test with fake inputs both a case that must be blocked and one that must pass |

### 4.1 Format
Format criteria to follow when creating memory, skills and hooks. Hooks placed in other chapters (5.4, 7.2) also follow this hook format.

| Tool | Format criteria |
| --- | --- |
| Memory | One rule per file. The header holds a name, a one-line description and a type; the body is written as rule → reason (triggering incident) → how to apply. The index file holds only the title and a one-line summary. If the same content exists, edit it instead of creating a new file, and delete wrong memories |
| Skill | The header's `description` is the trigger condition, so it should say when to read the skill and the actual phrases used (including in the user's language), rather than describing the function. If the body grows long, split it into reference files and keep only a table of which file to read in which situation |
| Hook | Its output takes up conversation context, so it outputs nothing in normal operation. Example: a hook that, at the end of a response, checks "did this turn launch a job or show a new result without updating the log?" and reports it in one line. Results already seen are remembered separately so the same result does not trigger the reminder again (without this, old results cause the same reminder to repeat) |

## 5. Using an LLM wiki
A way to keep the research state in one place with a topic wiki the agent writes and edits itself. When judgments are scattered over dated cards, the numbers differ from card to card and decisions waver, so one up-to-date state keeps being written even as sessions change. A new session reads only the index and topic pages and knows the current state, decisions and next steps; re-proposals of closed directions become rarer; and changed judgments remain as history. The structure follows Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern, and a structure used in one project is carried over unchanged to other projects.

### 5.1 Structure and location
The wiki consists of three layers — sources, wiki and schema — and the agent writes only the middle wiki layer. The location and the first pages to create are set below the table.

| Layer | Content | Author |
| --- | --- | --- |
| Sources | Dated cards and plan, design and result documents. Read-only during wiki work. The source of truth for numbers is always the result document | Humans and agents (adding new documents only) |
| Wiki | One status index, undated topic pages, one log | Agent |
| Schema | The wiki section of the project instructions (location, page skeleton, ingest and lint rules) | Revised together with the researcher |

There is one wiki per project, in one of two locations: inside the code repository (`docs/wiki/`, with the index at the top of `docs/`) or in the project folder of the note repository (`Wiki/`). Choose the former when research records are handled together with the code, the latter when the researcher often reads and edits in the notes. Either way, numbers are cited from the result documents as sources, not copied.
- The status index stays within 40 lines and holds only a one-line current state, next steps, a table of topic pages (one-line summary, as-of date) and a few recent decisions. If next steps grow long as a chain of finished stages strung together, move the finished stages to the log. Only the log accumulates; the index and topic pages are overwritten.
- The first topic pages to create are the research question, term definitions (core units and terms are defined only in this one place, and other documents point to it), judgment rules and standing constraints, the ladder table (module development), closed directions and their conditions, baseline methods and data, operations (server, runner, document rules), and the manuscript. Propose any other topic to the researcher when it recurs in two or more sources, and create it after approval.

### 5.2 Page and log format
A topic page overwrites the current state and the log accumulates events, so their formats are set separately. In both, every claim carries its source so the origin of a number can be traced back.
- Topic pages follow current state → configuration → measurements → decisions → open questions and disagreements → superseded judgments → ingested sources; sections with no content are omitted. When a page exceeds 150 lines, move old content to an archive document.
- The header holds the as-of date, a one- or two-sentence summary (the same sentence as the summary in the index), the number of ingested sources and the count of markers. Current-state items carry a `[confirmed]`, `[estimated]` or `[unverified]` marker and a source reference; do not use confidence scores.
- Measurements are a cumulative table with columns date, item, value, condition and source; rows are added, never deleted.
- The log has one entry per event. Decisions get a number (e.g. D12), quote the researcher's words and record what was changed. Interpretations added by the leader are marked separately (07 §1).

### 5.3 Operation
The wiki runs on five actions: read, query, ingest, lint and tidy. Ingest is the core: within the turn where a result or decision appears, update everything from the source to the topic pages, the index and the log, so the next session starts from the same state.

| Action | When | What is done |
| --- | --- | --- |
| Read | Session start, before a new proposal | Read index → relevant topic pages → recent log entries |
| Query | When the researcher asks about the state | Answer from the wiki, and check numbers in the sources. For answers worth reusing (comparisons, calculations, cause analyses), ask whether to save them to a page, and save only those approved |
| Ingest | In the turn where a result, decision, correction or understanding-changing explanation appears | Within the same turn: read the source → update the current state, measurements, decisions and open questions of the relevant topic pages → move changed judgments to superseded judgments → update the header summary, marker counts and the index row → record it in the source list and the log. Tell the researcher briefly only which pages changed and any new open questions |
| Lint | When the researcher asks | Look for sources missing from the source list or edited later than recorded, claims without a source reference, pages with new sources after their as-of date, `[unverified]` items that can now be confirmed, and broken links or orphan pages. Fix mechanical problems right away and report those that change a judgment as a list |
| Tidy | When the conditions (base, protocol, split) change, or when the log has grown long | Move results, designs and task specs of the old conditions and used-up handoffs into a dated archive folder under the same sub-path, and repoint links in current documents to the archive path. Keep only the current conditions on topic pages and the index, and archive a pre-tidy copy. Prior-work and rule documents are independent of conditions and stay |
- If a source list (e.g. `.manifest.json`) records each source's path, modification time, ingest date and updated pages, lint can find unreflected sources mechanically.
- When a new source conflicts with an existing judgment, move it to superseded judgments only when a later measurement clearly replaces it; otherwise put both sides' evidence under open questions and disagreements.
- A result, decision or path change written only in the log and left there is treated as unfinished. Update the one topic page the fact belongs to and one line of the status index in the same turn, and when a large stage ends, check how many days the topic pages' as-of dates lag behind the last day of the log.
- Wiki updates are run by instructions, not by an automatic script, because automatic updates change pages without review. Before finishing work, check the repository's change list for new documents and reflect them.
- If documents from old conditions stay mixed in the current folders, old numbers and closures are misread as current evidence, so move them at the first tidy after the turn in which the conditions changed. The wiki is an internal document; external documents are written from the source documents.

### 5.4 Connecting a note repository and the wiki
How roles are divided when the wiki and the researcher's note repository (e.g. an Obsidian vault) are used together. One canonical record is fixed so that the same fact does not change separately in two places.
- If the wiki is in the code repository, the note repository's project folder holds only the hub document and write-ups the researcher will reread. Notes do not copy numbers; they point to result documents and topic pages, and when a number must be stated, they give the source and the time it was taken.
- If the wiki is in the note repository, the same work that writes a result or design document in the code repository also writes the matching note (source card) and ingests it into the wiki. Code repository documents are outside the notes, so they are listed separately in the source list by absolute path and cited like `repository docs/…`.
- When the researcher changes or corrects a decision in a note, reflect it in the wiki log and topic page in the same turn. If only the note changes, the agent in the next session does not know about the changed decision.
- Before writing a note, the agent first reads the instruction files of the note repository and of the folder. Put an index of all material in the folder at the end of the hub document so that new notes are listed automatically. The note repository is not a place to pile up conversation logs, and after editing notes with a script, check the frontmatter (6.2).

A code change without a document, and gaps in reflection between sources, the wiki and the notes, are caught by the end-of-response hook that ships with this skill's plugin (4.1 hook format). With instructions alone, an agent still adds a section to a source and skips the wiki update. The hook, however, holds no paths. Every research repository that uses a wiki keeps its own values (paths that need a document, wiki location, source paths, log file, and so on) in `.claude/research-with-ai.conf`. In a repository without this file the hook checks nothing, so create it together with the wiki. Lessons about the method go to this skill's notes and improvement log, not to a project wiki. The check items, reminder rules and config keys are in the hook description in the public repository.

## 6. Document system
Where to record what, when something happens, and the format of documents. 6.1 sets which documents to update for each event; 6.2 sets document location, names, headers and how to write decision numbers.

### 6.1 Documentation timing
The kind of event decides which of the log, result document, topic page and status index to update. The log records every event; the others are updated only when the event changes their content.

| Event | Log | Result document | Topic page | Status index |
| --- | --- | --- | --- | --- |
| Training result | O | O | O | O |
| Pre-measurement or smoke result | O | O | If relevant | If state changes |
| Researcher decision or correction | O | — | Relevant page | If state changes |
| Job start | O | — | Mark as in progress | O |
| Explanation that changed understanding | O | — | Plain-language section | — |
| Decision on experiment conditions (base method, protocol, split, budget, whether earlier modules carry over) | O | Plan document (what to check and the pass criteria, before results) | Rules page | O |
- Document research conversations every turn: questions, answers, consultation results and proposals exchanged with the researcher are recorded in that turn as one log line and in the related documents (plan, consultation record, topic page). Skip only uneventful turns (simple status checks, waiting with nothing changed). A judgment left only in the conversation disappears in the next session, and the researcher has to ask the same question again.
- Simple status checks are not recorded.
- When the experiment conditions change, do not carry numbers from the earlier conditions into the new ones. If old numbers mix in, judgments on the new ladder wobble against the old conditions.
- Read the time from the clock; do not guess. Guessed times are wrong all at once and make the whole record suspect later.

### 6.2 Document format
Writing style, file names, hubs and the verdict table format follow the note repository instructions. Here, rules on code repository documents, decision numbers and bulk edits are added on top.
- Research documents in the code repository go into folders by role (plans, design contracts, results, prior-work surveys, usage guides, record schemas, session handoffs, archive). File names are `date-topic-kind`, and the header holds the document number, role, status and update date. When moving or renaming, move with the version control's move command, fix the references that point to the document in the same commit, then search for broken links.
- Decision numbers are used only as tags for finding decisions in the log and the wiki. In reports to the researcher and write-ups the researcher reads, spell out the content of the decision or measurement and put the number only in parentheses (e.g. "the base was set to row 3 (D12)"). With the number alone, the researcher has to look it up to know what it means. Do not use version marks (first edition, supplement).
- After editing many files with a script, always check the headers (frontmatter). One replacement can delete a single space in a header and break the tags of many documents at once.

## 7. Incremental improvement of method documents
A way to make lessons from work accumulate in the method documents (instructions, skills) without the researcher having to say "fix it" (progressive self-improvement). The researcher's corrections are applied in the same turn, lessons the AI finds pile up as candidates and are approved at a milestone, and approved changes go into the public release and become the next session's skill. Hooks keep this loop from being forgotten. Run only with documents and instructions, without code. Follows the log and periodic lint of the [LLM wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) and the approach of editing instructions item by item instead of rewriting them wholesale ([ACE, Agentic Context Engineering](https://arxiv.org/abs/2510.04618)).

### 7.1 Structure with documents only
The improvement loop runs on the four documents below only: the candidate note is where lessons come in, the method documents are where they are applied, and the improvement log is where they are recorded; the folder instructions and template set the rules in between.

| Document | Role |
| --- | --- |
| Improvement candidate note | Where lesson candidates from work accumulate one line at a time. Lines that have been applied or rejected are recorded in the improvement log and then deleted, so the only lines left are candidates awaiting an answer |
| Method documents (00–08) | Targets of changes. The source of the skill, installed after being moved into the public edition |
| Folder instructions and template | Rules for how candidates are recorded and applied |
| Improvement log | One line each for when researcher decisions and candidate applications or rejections were made, and in which document. It only grows, and it is the starting point for choosing the changes to publish (7.4) |
- Links between documents are written as standard markdown links so that the documents become skill reference files as they are.
- When you install a published skill and contribute to it, follow the steps in 7.4.

### 7.2 Operation
The key is to treat what the researcher sets differently from what the AI finds. The former is applied in that turn; the latter is collected as candidates and asked about at a work milestone; either way, it is recorded in the improvement log. Proceed in this order.
1. **Apply what the researcher sets immediately**: in a turn where the researcher corrects you or sets a new way of working, edit the relevant document and chapter within that turn and add one line to the improvement log. The researcher's words are the decision, so do not wait. If you fix it later, sessions in between work by the old rule.
2. **Choose where to apply**: if it is common to every stage, the body (00); if it is a method within one stage, the relevant chapter document; if it applies to one study only, that study's repository instructions. Lessons from work that is not research (contract deliverables, presentation material, surveys and so on) do not go into the method documents; if needed, they go into that project's instructions.
3. **How to apply**: add one rule line to the relevant chapter or edit an existing sentence. If the same rule exists, edit that sentence instead of adding a new one. Do not rewrite wholesale.
4. **What the AI found goes to candidates, without being asked**: for a lesson the researcher did not set, add one line to the candidate note in the turn the signal appears, as `date / signal / generalized lesson / target document·chapter / kind of change`. Signals are a correction or a gap-revealing question, the same mistake a second time, a procedure invented during the work, a tool or route failure and its workaround, and the researcher's frustration. Write the lesson in general form (the case only in the signal column; the lesson column as "when → what → why" without project or tool names or numbers; if it would not change behaviour in another study, send it to that study's repository instructions). If the same lesson exists, add the signal to that line. Ask about accumulated candidates together, once, at a work milestone; if accepted, apply at once as in 1; if rejected, reject it; either way, record it in the log and then delete the candidate line.
5. **Record**: each time something is applied, add `date / what changed / document·chapter changed / trigger (researcher decision, candidate approval)` to the improvement log, and if the document repository is git, commit so it can be reverted.
6. **Lint**: periodically (e.g. once a week) look for contradictions, duplicates and chapters that have grown too long and report them; clean up only after approval. Before publishing the public edition, and after splitting chapters or moving rules, run a find-by-reading test: give a fresh agent that has never seen the documents about 10 real situations, and have it find the right section and rule by following only the table in 00 §1 and the section headings, without file search. For situations it cannot find or finds only by a detour, fix the table row or the rule's location, and retest only the places fixed. This is because reading cost is set by the path to the content more than by its length.
7. **Back it with hooks**: instructions alone forget step 4, so put hooks at two points. When the researcher's message looks like a correction or a gap-revealing question, add one line to that turn's context asking whether to log a candidate; at the end of a response, remind once per state about pending candidates (4.1 hook format: no output normally, never re-alert on the same state). Reminders about changes accumulated since the public release are switched off in the config, because under 7.4 the agent does not ask about them. Make the signal phrases configurable, and test with fake inputs that non-corrections such as question-form sentence endings ("isn't it ~?") do not trigger it.

### 7.3 What to keep
Rules that keep the method documents from shrinking or tilting toward a single case while they are being edited.
- Do not rewrite wholesale. Shortening tends to drop detailed rules.
- Do not make a principle out of a single event. Promote to a common principle only lessons that appeared twice or more or whose effect has been confirmed.
- These documents are shared, so before applying, check that no names, numbers or paths slipped in.
- If there are no candidates, do no cleanup.

### 7.4 Refining in notes and publishing to the public skill
How a contributor to a published skill refines the method documents in their own note repository and publishes to the public skill only what is well refined. Corrections during research are applied to the notes at once, but the installed skill and other users receive only reviewed versions.

| Step | What to do | Criterion |
| --- | --- | --- |
| Refine in notes | Apply corrections and accepted candidates to the method documents in the notes at once, as in 7.2 | Until published, the edited note takes precedence over the installed copy |
| Choose what to publish | Collect the changes since the last publication from the improvement log and check that the wording is settled and agrees with the other chapters | Publish only what the researcher judges refined and asks to publish. The agent does not ask first whether to publish because changes have piled up |
| Move to the public repository | Remove note-only frontmatter and note links and save under the repository file names. If there are other language editions, re-translate only the changed documents | Search for names, numbers, paths, accounts and secret values |
| Check | Check the format with the skill validator and the plugin validator, and bump the version | Checks pass |
| Publish | Commit, then push with the researcher's permission | Never push without permission |
| Update installed copies | Fetch the skill again in every tool where it is installed (update the plugin; re-copy a copied install) | Confirm in a new session that the skill loads in its new version |
- Publish a version that bundles several log lines, not each correction. Frequent version changes spread unreviewed rules to users.
- Before publishing, turn research-specific content that exists only in the notes (cases, numbers, paths) into general rules or remove it.
