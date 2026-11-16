# Research with AI — Operations

| Item | Content |
| --- | --- |
| Purpose | Lets you run agents, servers, GPUs, monitoring, cost, security and commits together with an AI agent using this document alone |
| When to read | When launching workers or research agents, when launching and monitoring long jobs or training on a server, when handling paid APIs or secrets, when committing or pushing |
| Outputs | Handoff information for the launched job (process ID, log, expected end time), a watcher command, cost estimate, clean commits |
| Structure | §0 work order, §1–§6 methods. Domain-agnostic methods that can be moved as is into instructions or a skill |

## 0. Work order
The sections and outputs you pass through from assigning a job, launching it, confirming its end, to recording it.

| Step | Section | Output |
| --- | --- | --- |
| Assign | 1 Roles of leader and workers | Who does it, worker brief |
| Launch | 2 Long-job rules, 3 Servers and GPUs | Estimated time, handoff information for the launched job |
| Wait | 4 Watchers and monitors | One watcher command, a monitor pane |
| Protect | 5 Security and cost | Cost estimate, secret filter |
| Record | 6 Commits and push | Commits, push after approval |

The practices below are based on the following sources on research computing and agent operations.

| Practice | Where in this document | Source |
| --- | --- | --- |
| Do not add agents when a simple method works; count the cost of multiple agents | 1.1 | Anthropic, Building effective agents, 2024 · Anthropic, How we built our multi-agent research system, 2025 |
| Write the goal, output format, tools and boundaries in the brief, and give arguments that are hard to get wrong | 1.2 | Anthropic 2025 · Anthropic 2024 |
| Give workers only the permissions the assigned work needs; the leader or researcher does hard-to-undo actions | 1.2 | OWASP Top 10 for LLM Applications 2025, LLM06 |
| Verify worker results separately | 1.3 | Cemri et al., Why Do Multi-Agent LLM Systems Fail?, NeurIPS 2025 |
| Save intermediate results and resume; record run commands, environment versions and seeds | Ch. 2, 03 §4.1, §4.3 | Sandve et al., PLOS Comp Biol 2013 |
| Do not change batch during an experiment; prepare inputs in advance | Ch. 3, 03 §5.4 | Godbole et al., Deep Learning Tuning Playbook, 2023 |
| Keep raw data read-only with a copy in another place; commit in small units | Ch. 3, Ch. 6 | Wilson et al., PLOS Comp Biol 2017 |
| Stop conditions; usage and cost caps | Ch. 4, Ch. 5 | Anthropic 2024 · Sculley et al., NeurIPS 2015 · OWASP 2025, LLM10 |

## 1. Roles of leader and workers
How to decide who does what when using several agents. Having the leader finish the work directly is often faster and cheaper than adding workers.

### 1.1 Who does it
- The leader does pre-measurement scripts, few-line fixes, records, judgments and short document tasks directly. The time a worker spends reading the brief and code and setting up the environment is often longer than the actual work, and workers sometimes stop after writing code without running it.
- Before adding agents, first check whether a simpler method (the leader alone, one script run) works. One agent uses about 4 times the tokens of a chat, and multiple agents about 15 times (Anthropic 2025).
- Use workers only when the researcher asks or has decided to work through workers (including when actual work is handed off because of usage limits, Ch. 5). Within that, the criterion for launching a worker is work with a separable output (a module and its tests, a measurement tool). If instructions conflict on who handles small changes, ask the researcher once and record the answer in the operations document.
- Give one worker one question and one file scope; the leader merges several results into one. Split research into several narrow questions, launch research agents in parallel, and have them mark how deeply they checked the full text.
- A worker's job ends at "write → verify → run → confirm start → hand back". It confirms passing from the test run's own exit status, launches the job, and once the start is confirmed records in its handoff the run location, PID, start time, expected end and the checkpoints to look at (smoke, early-stop check, end), and closes its pane. Do not keep workers that only watch.
- Waiting and judgment belong to the leader. The researcher follows progress in an agent-free monitor pane (Ch. 4), and the leader wakes only once at each checkpoint. Keep only one final watcher per agent, and stop the agent after it commits.
- Verification/advisory workers and execution workers use different model families to keep verification independent. Model names are chosen by configuration, not hard-coded. When a usage limit is hit, switch to a pre-defined low-cost or free route.
- Set a worker's reasoning level (effort) to the minimum the work needs, and use the highest level only for truly hard work. Do not change the model or reasoning level of a running worker.

### 1.2 Worker brief
- Do not refer to other briefs (no "same as the other brief"); write all paths, hardware and models into it. Write hardware values (memory limit, GPU count) as actually checked. A guessed value leads the worker to wrong decisions such as shrinking the batch or stopping. The model used for measurement and comparison is by default the adopted base row; if another row is used, state why.
- Write in the brief the goal, output format, tools and sources to use, and the boundaries not to cross. A vague brief makes workers overlap or leave gaps. Give arguments that make mistakes hard for the worker, such as giving paths as absolute paths.
- Write "write the handoff and mark the task completed" as the last step. Without the completion mark the leader's wait never wakes, and finished work looks stalled.
- For long runs, have the worker hand off right after confirming the start; do not make it wait for the first epoch or the end. If scoring and measurement follow training, have them bundled with training into one script on the server (train → score → measure → end marker) and launched at once. Before launching, the leader checks that the brief has no "wait until it finishes" step. If the runner runs a smoke before training, the worker does not run the same smoke separately.
- Write that the worker must not change the working environment outside the assigned scope (connection and authentication settings, system installs, other experiments' files, open apps), and that when a server or outside resource cannot be reached, it stops and reports instead of trying to fix it. A blocked worker can look for a way around on its own and change the researcher's working environment. Have it not open question prompts; when unsure, use a safe default and note it in the handoff.
- Give a worker only the tools and permissions the assigned work needs. Hard-to-undo actions such as sending messages, deleting and pushing are done by the leader or the researcher, not the worker.

### 1.3 After launch
- The leader does not just wait for the completion mark; from right after launch it looks directly at what the worker is actually doing (running processes, logs, GPUs and files on the remote machine). If it sees work that departs from the brief or design document (e.g. an unplanned recomputation), it judges on the spot whether it is right and records it in the design document as a supplement or correction.
- If a worker finds a defect after launching, it does not relaunch on its own. It stops only the PIDs it started, keeps the run folder marked as failed instead of deleting it, writes the defect and the fix into the handoff and passes it to the leader. It relaunches only when the brief allows it.
- The leader reviews code written by a worker line by line against the design document, and runs the tests, smoke and training itself. Do not train on a "tests pass" report alone; also check that the tests actually discriminate the property they target (e.g. a test comparing two models built from the same seed almost always passes).
- Close a worker pane after confirming that the worker has finished (pane output, server processes). Use the force-close command only on workers confirmed finished.

### 1.4 Parallelism and merging
- Run independent steps at the same time on separate GPUs. A pre-measurement without a pass bar does not block training; launch training first, run the measurement alongside on another GPU, and stop training only if harm shows up.
- Workers only commit in a separate workspace (worktree); the leader merges and resolves conflicts. If the work line branched from an old main, port only the work line's values onto main's structure. The leader does not commit while workers are being launched (if the base commit changes while workspaces are being created, the start fails).
- Different sections of one manuscript are edited by several workers in parallel. Give each worker a non-overlapping paragraph range and a list of approved sentences that must not be deleted, forbid committing build output, and have them report only the number of added lines instead of fitting the length. After merging, the leader builds once and fits the length across the whole manuscript.
- Judge a multi-agent tool's performance not by message count or acknowledgement count but by cost per completed task and result quality. An evaluation where the evaluator saw the task information in advance is invalid. Reusing the same prefix context and trimming tool output cuts cost greatly.

## 2. Long-job rules
Rules to paste as is into the brief when running a job that may take over 10 minutes (preprocessing, evaluation, pre-measurement).

1. **Estimate first.** In the smoke, measure time per sample split into model compute, CPU work and scoring, and report the total expected time. If it exceeds 45 minutes, state the bottleneck and the fix. Exclude start-up cost such as model loading from the per-sample time when estimating.
2. **Use idle CPU cores from the start.** Per-sample CPU work runs in data loader workers or a process pool, heavy scoring on the GPU. It is common for compute to be fast while scoring on a single core makes the whole job several times slower.
3. **Check throughput once.** After about 5% of the job, measure GPU utilization and the busiest core. If the GPU is idle and one core is busy, stop, fix and rerun. But the script does not stop itself on this check; it only reports the numbers. Jobs bottlenecked on reading from shared storage naturally have low GPU utilization.
4. **Save intermediate results.** Save at fixed intervals so the job can resume. The output step reads only saved values, so if it dies at the last step it can be redone in seconds.
5. **The smoke passes through every branch.** Run through the actual output step and pass every data-dependent branch once. A branch the smoke did not pass can crash at the end of a long run.
6. **Record actual time too.** In the report, put the actual time next to the estimate.
7. **Hand off right after launch.** Do not wait after launching a job. Hand over the process ID, log location, output location and expected end time, then finish. Waiting is the job of one leader watcher; do not issue one long sleep. A long sleep delays noticing the result.

## 3. Servers and GPUs
How to use a remote compute server. Assumes the agent runs on a laptop and computation runs on the server.

- Launch long jobs detached from the shell (`setsid nohup … &`). A plain background job dies when the connection drops. Prefix `bash` for scripts without execute permission.
- Register the launch order and command in the operations document as is, so they are not confused each time. Also record the runner's argument format.
- After launch, check the start line in the queue log, and report "training started" only after seeing the actual training start line.
- Stop processes only by ID. Killing by name pattern also kills the command itself or other people's jobs.
- Do not use GPUs that others are using. Use only permitted GPUs, only in the agreed time slots. For time-limited GPUs, the runner refuses starts outside the window and makes jobs finish before the deadline.
- If there are time windows when shared storage becomes slow, do not start new jobs in those windows. Do not blame the code for test failures in those windows. Keep an override switch and skip the rule when the researcher allows it.
- Before installing a new tool, check whether it already exists on the server or in shared storage. Install only into a personal virtual environment.
- If the remote shell environment differs (e.g., the virtual environment is not activated), specify the executable path.
- Stream large raw data and keep only the needed results (e.g., embeddings). Run long interactive work inside a terminal multiplexer.
- Run pre-measurements on an idle GPU with a memory cap and low priority.
- How to keep GPUs full: the CPU prepares the next input in advance, and small jobs that cannot fill a GPU go into a second slot on a GPU with spare memory. Training never goes into a second slot. For a job type run for the first time, run it alone to measure peak memory before packing it. After packing, measure GPU utilization a few times, and for GPUs running two jobs together check the run ledger for out-of-memory failures. If there are failures, take that job type out of the second slot.
- Do not leave GPUs idle: while one row runs, finish the next row's design, code and tests, and launch it as soon as the running row finishes or is stopped. If a confirmation training run fits on one GPU and there is an idle GPU, register the judgment criteria and launch it right away instead of waiting for unrelated jobs to finish.
- Early stopping: match past rows' learning curves against their final verdicts, register before results a line on a value that can be measured reliably mid-run ("rows this far behind have never passed by the end"), and stop a row that crosses it. Do not adopt on mid-run values (rows that led mid-run have failed the final verdict). Score a stopped row's saved checkpoint for the record as well.
- Keep raw data read-only and keep one copy in another place. Back up results against server outages, and do not stop at backups; also test restoring. Write the restore steps in the backup folder, and do not copy again results or checkpoints already in other storage. Secrets (API keys, credentials, SSH keys) do not go into backups; enter them again on the new machine.
- When returning equipment or moving work to another machine, first move results, figures and documents to the machine you will work on, write in the operations document what will and will not be done on that machine (e.g. no training, only manuscript edits), and change paths in configuration files (hook settings, etc.) to the new machine's values.

## 4. Watchers and monitors
How to notice that a long job has finished, and common mistakes.

- After launching a long job, confirm the start from the first log line some tens of seconds later. This avoids waiting for results from a job that ended with an error right after starting.
- Confirm the end by the exit of the PID saved at launch and an end marker line in the log (exit line, smoke result line, first epoch line). Attach the wait condition to the PID exit, not to a result string, so that any end (including errors) is caught, and judge success by the end marker line. A process-name search can match the watcher command itself and look "running" forever; if you use it, use a pattern that does not match itself (`[s]moke`).
- When looking for the end marker, make the pattern match only this run's lines. If failure or skip lines from a previous run remain, the watcher wrongly concludes the job has already ended.
- Do not guess the path of the file a watcher looks at or the shape of its lines. Actually find the same file left by a previous run, confirm the path and lines, then attach the watcher. A watcher with a wrong path neither fails nor ends; it stays silently, and to the researcher the agent looks as if it stopped without a word.
- Give every watcher a time limit of the expected time plus a margin. When the limit is hit, look directly at the server's logs and files and tell the researcher right away what is late. Do not assume nothing happened just because the watcher has not woken.
- Check watcher output with grep. Word-splitting rules differ between shells, so splitting into variables can misjudge, and the GPU may sit idle meanwhile.
- When a local watcher is cut by the laptop sleeping or moving and the researcher asks, check the server's queue log first, not the watcher output. The agent does not touch network settings.
- When a run is stopped, stop the watchers waiting for it too. Do not leave watchers that will never end.
- Keep the human-facing monitor as one pane below the chat pane and show only short output.
- The researcher must be able to see when a long job has finished. Watch with **one agent-free monitor pane** (one line per run every 2 minutes: epochs, latest value, done/error), not with agent workers. Launch workers only when there is real work such as code or measurement, and close their panes when done. The leader judges.
- Do not read long logs with tail; extract the needed lines with remote grep. With long-line logs, the tail window misses result lines.

## 5. Security and cost
Rules for personal data, secrets, external transfer and paid APIs.

- Do not put personal data such as the user's email into commands, API arguments or files. Some search APIs take contact details as request arguments, so put a prohibition sentence in research agent briefs.
- Add a filter so lines that may contain secrets (e.g., webhook addresses in old logs) are not printed, and run with the related environment variables set empty.
- Do not touch VPN or network settings. Run only the designated stop script when told to turn it off.
- Split API keys into per-person profiles, and record only amounts, never key values. Use only one key per run. Splitting one run across several keys splits the records and retries.
- For paid APIs, pick which key to use first by credit expiry date, and before running, compute cost with the measured unit price and confirm it is within the balance. If already measured with the same model and prompt, record the reason for skipping the pilot in the pre-registration document.
- Put caps on iterations, time and cost for agent runs and paid APIs; when a cap is hit, stop and notify. If usage spikes well above normal, find the cause before continuing.
- Only when the researcher has decided to work through workers because of usage limits, give the actual work (code, measurement, launches, fetching results) to a cheap model's worker as a single brief file, and let the leader do only instructing, judging and documentation. Keep answers and tool output short too, so the large model's allowance lasts the whole research period.

## 6. Commits and push
Rules for recording and publishing changes to code, documents and manuscripts.

- Commit only the intended files. Do not add whole directories, and do not touch uncommitted files someone else was editing.
- Commit in units small enough to revert in one step, and do not commit unfinished work. Do not include intermediate files that can be regenerated, or large files.
- Put code or manuscript changes and the documents that correspond to them (design, results) in the same commit, and when reporting to the researcher, include the path of the document where it was recorded.
- Push only when a person instructs it, and check for secrets before pushing. Push only to the designated remote branch; do not touch other branches or main of a shared repository. In a repository only the researcher uses, also push to main when the work branch continues straight from main (fast-forward). Never force-overwrite main.
- Document check before push: are the plan, result and design documents matching the change updated; is there a header; are failures and omissions recorded; do the paths the documents point to exist; is remaining work intended; is result data kept out of the commit; is there a one-line summary of what is pushed and why.
- Keep result data out of git, in separate storage (e.g., NAS).
- Track the manuscript in git too, excluding build outputs and old backups. Push the manuscript only when the repository is private.
- Commit pre-registration documents before the results to record the time. Read times from the clock or commit time, never guess.
- When regenerating a figure only to change labels, pixel-compare the old and new figure at the same resolution, and if anything other than the labels differs, stop without committing. This comparison catches figures and captions that have drifted to different versions.
