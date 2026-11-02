# Research with AI — Tools and Rules

| Item | Content |
| --- | --- |
| Purpose | Using only this document, set up the tools for research with AI agents and create and run instructions, memory, skills, hooks and a wiki |
| When to read | When starting a new study or repository, when the same instruction keeps being repeated, when creating or changing instructions, memory, skills, hooks or the wiki, when research is interrupted because the session changed |
| Output | Tool setup, instruction files matching the rule layers, memory, skills and hooks, wiki skeleton (status index, topic pages, log), documentation timing table, monitoring setup |
| Structure | Ch. 0 work order, Ch. 1–8 methods |

## 0. Work order
The steps and outputs when first setting up a research environment.

| Step | Chapter | Output |
| --- | --- | --- |
| Set up tools | 1 Always-used tools, 2 On-request tools | Agent, screen, server and document repository setup |
| Set rules | 3 Rule layers, 4 Writing rule tools | Instruction files, memory, skills, hooks |
| Record system | 5 LLM wiki, 6 Document system | Wiki skeleton, documentation timing table, document format |
| Prepare for long jobs | 7 Watching and monitoring | Watch commands, monitor pane |
| Keep improving | 8 Incremental improvement of method documents | Improvement candidate note, improvement log |

## 1. Always-used tools
The role and operating principles of tools used in everyday research work.

| Category | Tool | Role and operating principles |
| --- | --- | --- |
| Agent | Main working agent | Does design, analysis, code, verification, commits and documentation itself. Does not hand short tasks to other agents. Workers spend longer reading instructions and code than doing the work, and sometimes stop after writing code without running it |
| Screen | Terminal pane manager | Splits agents and monitors into visible panes. The monitor pane sits below the conversation pane, not beside it |
| Compute | Remote GPU server | Runs training and measurement. The agent runs on the laptop and computation runs on the server; training is launched through a queue runner |
| Documents | Code repository documents | The source of truth for research decisions and numbers. Holds the status index, topic pages and log |
| Documents | Note repository | Human-readable summaries. Not a place to pile up conversation logs. Each project has a hub document and an index of all its material |
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
- Hand off a session only after finishing the file work in progress. The handoff file holds the remaining work, the location of evidence and the next commands; the new session gets only a two- or three-line instruction to read that file.

## 3. Rule layers
Rules are layered by scope, and each rule goes in the narrowest layer.

| Layer | Rules it holds |
| --- | --- |
| Researcher's direct instruction | Takes precedence over every rule |
| Global instructions | Coding posture, assembly-style model development principles, tool-use restrictions |
| Note repository instructions | Writing style, file names, hub documents, verdict table format |
| Project instructions | Project boundaries, wiki structure, document layers |
| Code repository instructions | Build and run commands, development order, measurement rules |
| Memory | Lessons from incidents and decision principles |
| Skills | Repeated procedures |
- Precedence is researcher instruction > nearest instructions > higher-level instructions > global instructions.
- Keep the same rule in both the human-facing document and the agent instructions, and change them together.

## 4. Writing rule tools
The basic direction: when the same instruction keeps being repeated, do not say it again; move it into instructions, memory, a skill or a hook.

| Tool | When to create | Format | Verification |
| --- | --- | --- | --- |
| Instructions | When the same instruction has been repeated twice or more, or a project-specific rule appears | One line of rule and one line of reason. Long explanations go into an operations document, with only its location noted | In a new session, give a task that needs the rule and check compliance |
| Memory | When an incident, a researcher correction or a researcher decision occurs | One file per rule: rule → reason → how to apply | Check that the same mistake does not recur in the same situation |
| Skill | When the same procedure has been explained several times | One folder and one procedure file; split into reference files when long | Check that saying the trigger phrase loads the skill |
| Hook | When a rule is not kept by instructions alone and can be judged mechanically | A check script registered in the settings file | Test with fake inputs both a case that must be blocked and one that must pass |

### 4.1 Format
| Tool | Format criteria |
| --- | --- |
| Memory | One rule per file. The header holds a name, a one-line description and a type; the body is written as rule → reason (triggering incident) → how to apply. The index file holds only the title and a one-line summary. If the same content exists, edit it instead of creating a new file, and delete wrong memories |
| Skill | The header's `description` is the trigger condition, so it should say when to read the skill and the actual phrases used (including in the user's language), rather than describing the function. If the body grows long, split it into reference files and keep only a table of which file to read in which situation |
| Hook | Its output takes up conversation context, so it outputs nothing in normal operation. Example: a hook that, at the end of a response, checks "did this turn launch a job or show a new result without updating the log?" and blocks once. Results already seen are remembered separately so the same result does not block again (without this, old results cause repeated false blocks) |

## 5. Using an LLM wiki
A way to keep the research state in one place with a topic wiki the agent writes and edits itself. When judgments are scattered over dated cards, the numbers differ from card to card and decisions waver, so the goal is to keep writing one up-to-date state even as sessions change. A wiki structure used in one project is carried over unchanged to other projects. The structure follows Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern.

### 5.1 Structure
| Layer | Content | Author |
| --- | --- | --- |
| Sources | Dated cards and result documents. Read-only during wiki work | Humans and agents (adding new documents only) |
| Wiki | Undated topic pages. Overwritten to stay current | Agent |
| Schema | Wiki rules in the project instructions | Revised together with the researcher |
- The wiki has one status index (about 40 lines), several topic pages and one log. Only the log accumulates; the index and topic pages are overwritten.
- Topic pages follow current state → configuration → measurements → decisions → open questions and disagreements → superseded judgments; when a page exceeds 150 lines, move old content to an archive document.
- Mark items `[confirmed]`, `[estimated]` or `[unverified]`; do not use confidence scores.
- The log has one entry per event, with the researcher's words quoted and what was changed.

### 5.2 Why use a wiki
| Effect | Content |
| --- | --- |
| No break when sessions change | After a new session or a context summary, the agent reads the index and topic pages and immediately knows the current state, decisions and next steps. Past conversations need not be explained again |
| Understands short requests | Project terms, row names and the meaning of decisions are defined on the pages, so the agent understands even short requests the same way |
| Fewer things missed | Decisions, constraints and closed directions are in one place, so re-proposing closed directions or breaking constraints becomes rarer |
| Numbers agree | The problem of writing the same fact differently on several cards disappears, and when a judgment changes it remains as a "superseded judgment", so the history is visible |

### 5.3 Operation
| Action | When | What is done |
| --- | --- | --- |
| Read | Session start, before a new proposal | Read index → relevant topic pages → recent log entries |
| Query | When the researcher asks about the state | Answer from the wiki, and check numbers in the source documents |
| Ingest | In the turn where a result, decision, correction or understanding-changing explanation appears | Within the same turn: one log line, overwrite the topic page, update the index |
| Lint | When the researcher asks | Look for unreflected sources, unsupported claims and stale states |
- Wiki updates are run by instructions, not by an automatic script. Before finishing work, check the repository's change list for new documents and reflect them in the wiki. Automatic updates change pages without review.
- So that reflection is not missed, a check hook at the end of each response checks "was there a result but the log was not updated?" (4.1 Hook).
- The wiki is an internal document; external documents are written from the source documents.

### 5.4 Connecting a note vault and the wiki
How to divide roles and connect the code repository's wiki with the researcher's note vault (e.g. an Obsidian vault) when both are used. If both record the research state, numbers and decisions change separately in two places, so one is fixed as the canonical record and the other points to it.

| Item | Code repository wiki | Note vault |
| --- | --- | --- |
| Role | Canonical record of research state, decisions and numbers | Write-ups people reread, explanations, report and presentation drafts, method document drafts |
| Written by | The agent overwrites it in the same turn | The agent writes up when the researcher asks or when a stage ends |
| Unit | Status index, topic pages, log | One hub document plus dated notes per project folder |
| Rules | Wiki rules in the project instructions | Instruction file at the vault root (style, file names, hub rules) and per-folder instruction files |
- Notes do not copy wiki numbers; they point to result documents and topic pages as sources. When a note must state a number, it gives the source and the time it was taken.
- When the researcher changes or corrects a decision in a note, reflect it in the wiki log and the matching topic page in the same turn. If only the note changes, the agent in the next session does not know about the new decision.
- Before writing a note, the agent reads the vault's instruction file and the folder's instruction file. The rules live in the vault; the project instructions only state where they are.
- Put an index of all material in the folder at the end of each hub document so that new notes are listed automatically. Then the hub does not need a manual edit for every new note.
- The note vault is not a place to pile up conversation logs. What was decided in conversation goes to the wiki log; only write-ups worth rereading go to notes.
- After editing notes with a script, check the frontmatter (6.2).
- A code change without a document, and gaps between source documents, source notes, the wiki and the note vault, are caught by the end-of-response hook that ships with this skill's plugin (4.1 Hook format). Instructions alone still let an agent add a section to a source note and skip the wiki update, and such a gap makes the next session read a wrong state. The hook checks four things mechanically.
  1. A commit changed a path that needs a document (code, manuscript, and so on) but no document.
  2. A commit changed a source document the wiki must ingest, and no later commit updated the wiki log.
  3. A commit changed a source note, and no later commit updated the wiki log (when the notes live in the wiki working copy, separate from the code repository).
  4. The wiki working copy that is pushed to the note vault has uncommitted changes, or the last-push marker is not the latest commit.
  - When nothing is wrong it prints nothing. It reports a commit or state once, in one line that says only what is missing. The note vault may be on another machine, so it never connects to it and looks only at the working copy and the push marker.
  - The hook holds no paths. Each project writes its own values in `.claude/research-with-ai.conf` (paths that need a document, document paths, wiki repository location, source document and note paths, wiki log file, push marker, time window), and only the checks whose values are set run. A project without the file is left alone. If the wiki lives inside the code repository, set the wiki repository location to `.`.

## 6. Document system
Where to record what, when something happens, and the format of documents.

### 6.1 Documentation timing
| Event | Log | Result document | Topic page | Status index |
| --- | --- | --- | --- | --- |
| Training result | O | O | O | O |
| Pre-measurement or smoke result | O | O | If relevant | If state changes |
| Researcher decision or correction | O | — | Relevant page | If state changes |
| Job start | O | — | Mark as in progress | O |
| Explanation that changed understanding | O | — | Plain-language section | — |
- Simple status checks are not recorded.
- Read the time from the clock; do not guess. Guessed times are wrong all at once and make the whole record suspect later.

### 6.2 Document format
- The style is terse explanatory note style, not conversational. The standard is that it reads like a report.
- Note file names are `YYYY-MM-DD topic.md`; only hubs use a fixed prefix, and each hub ends with an index of all material in the folder.
- Verdict tables go judgment rule → verification table → observation-only metrics → final verdict, and separate agent faults (FAIL) from external conditions (BLOCKED).
- Documents the researcher reads do not use codes that must be looked up (decision numbers, measurement codes) or version marks (first edition, supplement). The researcher cannot tell what the codes mean.
- After editing many files with a script, always check the headers (frontmatter). One replacement can delete a single space in a header and break the tags of many documents at once.

## 7. Watching and monitoring
Run the watch that announces the end of a long job separately from the monitor that shows progress to a human.

| Category | Method | Criterion |
| --- | --- | --- |
| Watch | A background command checks for the end-marker line at a fixed interval (e.g. 10 minutes) and wakes the agent when it appears | No polling at short intervals |
| Monitor | Shows only short progress in one pane below the conversation pane | Reuse one pane per job |
- Searching by process name finds the watch command itself, so the watch never ends and the next job starts that much later. Judge completion by process ID or an end marker in the log.
- A long job launched as an ordinary background process dies when the shell closes, so run it detached from the session.
- If there is no end marker, report "unverified"; do not treat it as success.

## 8. Incremental improvement of method documents
A way to make lessons from work accumulate in the method documents (instructions, skills) without the researcher having to say "fix it". Run only with documents and instructions, without code. Follows the log and periodic lint of the [LLM wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) and the approach of editing instructions item by item instead of rewriting them wholesale ([ACE, Agentic Context Engineering](https://arxiv.org/abs/2510.04618)).

### 8.1 Structure with documents only
| Document | Role |
| --- | --- |
| Improvement candidate note | Where lesson candidates from work accumulate one line at a time. It only grows; applied lines get an applied mark |
| Method documents (00–06) | Targets of changes. The source of the skill and the installed skill itself |
| Folder instructions and template | Rules for how candidates are recorded and applied |
| Improvement log | One line each for when which candidate was applied to which document |
- When working alone, the method document folder can be linked directly as the skill folder (body = skill body, chapter documents = reference files). Editing a document changes the skill immediately, so no conversion or installation step is needed. For this, links between documents are written as standard markdown links.
- When you install a published skill and contribute to it, follow the steps in 8.4.

### 8.2 Operation
1. **Apply what the researcher sets immediately**: in a turn where the researcher corrects you or sets a new way of working, edit the relevant document and chapter within that turn and add one line to the improvement log. The researcher's words are the decision, so do not wait. If you fix it later, sessions in between work by the old rule.
2. **Choose where to apply**: if it is common to every stage, the body (00); if it is a method within one stage, the relevant chapter document; if it applies to one study only, that study's repository instructions.
3. **How to apply**: add one rule line to the relevant chapter or edit an existing sentence. If the same rule exists, edit that sentence instead of adding a new one. Do not rewrite wholesale.
4. **What the AI found goes to candidates**: lessons the researcher did not set, such as a repeated mistake or a procedure newly created during work, go into the candidate note as one line `date / signal / generalized lesson / target document·chapter / change type`, and at the end of that turn's report ask in one line whether to apply it. If accepted, apply it immediately as in 1; if rejected, mark the candidate as rejected.
5. **Record**: each time something is applied, add `date / what changed / document·chapter changed / trigger (researcher decision, candidate approval)` to the improvement log, and if the document repository is git, commit so it can be reverted.
6. **Lint**: periodically (e.g. once a week) look for contradictions, duplicates and chapters that have grown too long and report them; clean up only after approval.

### 8.3 What to keep
- Do not rewrite wholesale. Shortening tends to drop detailed rules.
- Do not make a principle out of a single event. Promote to a common principle only lessons that appeared twice or more or whose effect has been confirmed.
- These documents are shared, so before applying, check that no names, numbers or paths slipped in.
- If there are no candidates, do no cleanup.

### 8.4 Refining in notes and publishing to the shared skill
How a contributor to a published skill refines the method documents in their own note vault and publishes only versions that are well refined. Corrections during research are applied to the notes at once, but the installed skill and other users receive only reviewed versions.

| Step | What to do | Criterion |
| --- | --- | --- |
| Refine in notes | Apply corrections and accepted candidates to the method documents in the notes at once, as in 8.2 | Until published, the edited note takes precedence over the installed copy |
| Choose what to publish | Collect the changes since the last publication from the improvement log and check that the wording is settled and agrees with the other chapters | Publish only what the researcher judges refined. The agent may ask once in one line when changes pile up |
| Move to the public repository | Remove note-only frontmatter and note links and save under the repository file names. If there are other language editions, re-translate only the changed documents | Search for names, numbers, paths, accounts and secret values |
| Check | Check the format with the skill validator and the plugin validator, and bump the version | Checks pass |
| Publish | Commit, then push with the researcher's permission | Never push without permission |
| Update installed copies | Fetch the skill again in every tool where it is installed (update the plugin; re-copy a copied install) | Confirm in a new session that the skill loads in its new version |
- Publish a version that bundles several log lines, not each correction. Frequent version changes spread unreviewed rules to users.
- Before publishing, turn research-specific content that exists only in the notes (cases, numbers, paths) into general rules or remove it.
