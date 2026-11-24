# Research with AI — Operations

| Item | Content |
| --- | --- |
| Purpose | Lets you run agents, servers, GPUs, monitoring, cost, security and commits together with an AI agent using this document alone |
| When to read | When launching workers or research agents, when launching and monitoring long jobs or training on a server, when handling paid APIs or secrets, when committing or pushing |
| Outputs | Handoff information for the launched job (process ID, log, expected end time), a watcher command, cost estimate, clean commits |
| Structure | §0 work order, §1–§6 methods. Each chapter puts its core logic in the first paragraph; procedures are numbered lists, mutually independent rules are short bullets |

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
When using several agents, the default is that the leader does the work itself. The cost of a worker reading the brief and code and setting up the environment is often larger than the actual work, and one agent uses about 4 times the tokens of a chat, multiple agents about 15 times (Anthropic 2025). So workers are used only when the researcher asks or has decided to work through workers (including handing off because of usage limits, Ch. 5), and within that only for work with a separable output (a module and its tests, a measurement tool). A worker ends at building and launching; waiting and judging belong to the leader.

### 1.1 Who does it
The leader does pre-measurement scripts, few-line fixes, records, judgments and short document tasks directly. Workers sometimes stop after writing code without running it, so before adding agents, first check whether the leader alone or one script run is enough.

A worker's job ends with the five steps below. Do not keep workers that only watch.
1. **Write**: build the code, tests and configuration.
2. **Verify**: confirm passing from the test run's own exit status, not from trimmed output.
3. **Run**: launch the job.
4. **Confirm start**: confirm the start from the first log line or the process.
5. **Hand back**: record in the handoff the run location, PID, start time, expected end and the checkpoints to look at (smoke, early-stop check, end), and close the pane.

Waiting and judgment belong to the leader. The researcher follows progress in an agent-free monitor pane (Ch. 4), and the leader wakes only once at each checkpoint. Keep only one final watcher per agent, and stop the agent after it commits.
- Give one worker one question and one file scope; the leader merges several results into one.
- Split research into several narrow questions, launch research agents in parallel, and have them mark how deeply they checked the full text.
- If instructions conflict on who handles small changes, ask the researcher once and record the answer in the operations document.
- Verification/advisory workers and execution workers use different model families to keep verification independent. Model names are chosen by configuration, not hard-coded.
- Set a worker's reasoning level (effort) to the minimum the work needs, and use the highest level only for truly hard work. Do not change the model or reasoning level of a running worker.
- When a usage limit is hit, switch to a pre-defined low-cost or free route.

### 1.2 Worker brief
Write the brief so the worker can finish without any other document. A vague brief makes workers overlap or leave gaps, and a blocked worker can look for a way around on its own and change the researcher's working environment. The brief contains everything below.

| Item | How to write it |
| --- | --- |
| Goal and boundaries | State the goal, output format, tools and sources to use, and the boundaries not to cross |
| Paths, hardware, models | Do not refer to other briefs (no "same as the other brief"); write everything into it. Give paths as absolute paths so mistakes are hard to make |
| Hardware values | Write memory limit and GPU count as actually checked. A guessed value leads to wrong decisions such as shrinking the batch or stopping |
| Comparison model | The model used for measurement and comparison is by default the adopted base row; if another row is used, state why |
| End marker | Write "write the handoff and mark the task completed" as the last step. Without it the leader's wait never wakes, and finished work looks stalled |
| Long runs | Have the worker hand off right after confirming the start; do not make it wait for the first epoch or the end. Bundle scoring and measurement after training with training into one script on the server (train → score → measure → end marker) and launch it at once. If the runner runs a smoke before training, do not run the same smoke separately |
| Environment | Do not change the working environment outside the assigned scope (connection and authentication settings, system installs, other experiments' files, open apps). When a server or outside resource cannot be reached, stop and report instead of trying to fix it |
| Questions | Do not open question prompts; when unsure, use a safe default and note it in the handoff |
| Permissions | Give only the tools and permissions the assigned work needs. Hard-to-undo actions such as sending messages, deleting and pushing are done by the leader or the researcher |
- Before launching a worker, the leader checks that the brief has no "wait until it finishes" step.

### 1.3 After launch
The completion mark is only the last check; the leader verifies worker results separately. Even well-specified roles reduce multi-agent failures only partly (Cemri et al. 2025). The leader must know the progress before the researcher asks.
- From right after launch, look directly at what the worker is actually doing (running processes, logs, GPUs and files on the remote machine). If it departs from the brief or design document (e.g. an unplanned recomputation), judge on the spot whether it is right and record it in the design document as a supplement or correction.
- Review code written by a worker line by line against the design document; the leader runs the tests, smoke and training itself. Do not train on a "tests pass" report alone; also check that the tests actually discriminate the property they target (e.g. a test comparing two models built from the same seed almost always passes).
- If a worker finds a defect after launching, it does not relaunch on its own. It stops only the PIDs it started, keeps the run folder marked as failed instead of deleting it, writes the defect and the fix into the handoff and passes it to the leader. It relaunches only when the brief allows it.
- Close a worker pane after confirming that the worker has finished (pane output, server processes). Use the force-close command only on workers confirmed finished.

### 1.4 Parallelism and merging
Run independent work at the same time to shorten the time from decision to result, and have one leader do the merging. When several agents edit the same thing, merges conflict or approved sentences get cut.
- Run independent steps at the same time on separate GPUs. A pre-measurement without a pass bar does not block training; launch training first, run the measurement alongside on another GPU, and stop training only if harm shows up.
- Workers only commit in a separate workspace (worktree); the leader merges and resolves conflicts. If the work line branched from an old main, port only the work line's values onto main's structure. The leader does not commit while workers are being launched (if the base commit changes, workspace creation fails).
- Different sections of one manuscript are edited by several workers in parallel. Give each worker a non-overlapping paragraph range and a list of approved sentences that must not be deleted, forbid committing build output, and have them report only the number of added lines instead of fitting the length. After merging, the leader builds once and fits the length across the whole manuscript.
- Judge a multi-agent tool's performance not by message count or acknowledgement count but by cost per completed task and result quality. An evaluation where the evaluator saw the task information in advance is invalid. Reusing the same prefix context and trimming tool output cuts cost greatly.

## 2. Long-job rules
Rules to paste as is into the brief when running a job that may take over 10 minutes (preprocessing, evaluation, pre-measurement). The core is: time it before launching, check once after it starts, and the one who launched it does not wait.

1. **Estimate first.** In the smoke, measure time per sample split into model compute, CPU work and scoring, and report the total expected time. If it exceeds 45 minutes, state the bottleneck and the fix. Exclude start-up cost such as model loading from the per-sample time when estimating.
2. **Use idle CPU cores from the start.** Per-sample CPU work runs in data loader workers or a process pool, heavy scoring on the GPU. It is common for compute to be fast while scoring on a single core makes the whole job several times slower.
3. **Check throughput once.** After about 5% of the job, measure GPU utilization and the busiest core. If the GPU is idle and one core is busy, stop, fix and rerun. But the script does not stop itself on this check; it only reports the numbers. Jobs bottlenecked on reading from shared storage naturally have low GPU utilization.
4. **Save intermediate results.** Save at fixed intervals so the job can resume. The output step reads only saved values, so if it dies at the last step it can be redone in seconds.
5. **The smoke passes through every branch.** Run through the actual output step and pass every data-dependent branch once. A branch the smoke did not pass can crash at the end of a long run.
6. **Record actual time too.** In the report, put the actual time next to the estimate.
7. **Hand off right after launch.** Do not wait after launching a job. Hand over the process ID, log location, output location and expected end time, then finish. Waiting is the job of one leader watcher; do not issue one long sleep. A long sleep delays noticing the result.

## 3. Servers and GPUs
Assumes the agent runs on a laptop and computation runs on a remote server. Three things to keep: launch jobs detached from the connection and handle them only by ID; do not touch others' resources and environment; keep GPUs full, but decide before results what will be stopped early.

### 3.1 Launching and stopping
- Launch long jobs detached from the shell (`setsid nohup … &`). A plain background job dies when the connection drops. Prefix `bash` for scripts without execute permission.
- Register the launch order, the command and the runner's argument format in the operations document as is, so they are not confused each time.
- Each time a training run is launched, write one run document: what is run (row, configuration, commit, script, GPU, seed, status log, watcher), what methodology it is (in plain words and field terms, what was changed against the base), what was measured before (linking to premise measurements and related result documents, with the key numbers and verdicts), the judgment criterion and branch points, and the result document when it ends. Make it and the design and result documents point to each other, and base later discussion on this document.
- After launch, check the start line in the queue log, and report "training started" only after seeing the actual training start line.
- Stop processes only by ID. Killing by name pattern also kills the command itself or other people's jobs.
- If the remote shell environment differs (e.g., the virtual environment is not activated), specify the executable path. Run long interactive work inside a terminal multiplexer.
- Make dangerous scripts stop first when arguments or required variables are missing. Rules tied to tools, such as how to write files from the shell, go into the global instructions, not the method documents (Installation and usage guide §1.4).

### 3.2 Shared resources and environment
- Do not use GPUs that others are using. Use only permitted GPUs, only in the agreed time slots. For time-limited GPUs, the runner refuses starts outside the window and makes jobs finish before the deadline.
- In time windows when shared storage becomes slow, do not start new jobs, and do not blame the code for test failures in those windows. Keep an override switch and skip the rule when the researcher allows it.
- Before installing a new tool, check whether it already exists on the server or in shared storage, and install only into a personal virtual environment.
- Stream large raw data and keep only the needed results (e.g., embeddings).

### 3.3 Keeping GPUs full
While one row runs, finish the next row's design, code and tests, and launch it as soon as the running row finishes or is stopped. If a confirmation training run fits on one GPU and there is an idle GPU, register the judgment criteria and launch it right away instead of waiting for unrelated jobs to finish.
- The CPU prepares the next input in advance.
- Small jobs that cannot fill a GPU go into a second slot on a GPU with spare memory. Training never goes into a second slot (when one training job uses nearly all of a GPU, putting two together does not raise throughput and only delays results). When there are more training rows than GPUs, chain the remaining rows in turn behind the GPU that finishes first. A small job of a type run for the first time runs alone to measure peak memory before packing. After packing, measure GPU utilization a few times, and for GPUs running two jobs together check the run ledger for out-of-memory failures. If there are failures, take that job type out of the second slot.
- When putting several runs that each do not use a full GPU onto one GPU, measure peak memory per run in a smoke run with the same configuration (including the evaluation and saving at the end of an epoch), and if the sum exceeds the line that leaves headroom on GPU capacity, launch one fewer. If usage right after launch exceeds that line, reduce before the end of the first epoch. The memory peak comes late, as at the end of an epoch, so launching by estimate kills several runs at once and also breaks the condition of running them at the same time.
- Run pre-measurements on an idle GPU with a memory cap and low priority.
- Early stopping: match past rows' learning curves against their final verdicts, register before results a line on a value that can be measured reliably mid-run ("rows this far behind have never passed by the end"), and stop a row that crosses it. Do not adopt on mid-run values (rows that led mid-run have failed the final verdict). Score a stopped row's saved checkpoint for the record as well.

### 3.4 Backups and moving machines
- Keep raw data read-only and keep one copy in another place.
- Back up results against server outages, and do not stop at backups; also test restoring. Write the restore steps in the backup folder, and do not copy again results or checkpoints already in other storage. Secrets (API keys, credentials, SSH keys) do not go into backups; enter them again on the new machine.
- When re-scoring a trained model on another machine or copy, check before running that the weight file exists and its hash, and first compare part of the scoring output against the saved predictions. Some scorers run on the base model without error when the weights are missing, so a silent substitution can be recorded as the trained model's result.
- When returning equipment or moving work to another machine, first move results, figures and documents to the machine you will work on, write in the operations document what will and will not be done on that machine (e.g. no training, only manuscript edits), and change paths in configuration files (hook settings, etc.) to the new machine's values.

## 4. Watchers and monitors
Wait on the exit of the PID saved at launch, and judge success by the end marker line in the log. Waiting only for a result string means waiting to the end for a job that died with an error right after starting, and a watcher with a wrong path neither fails nor ends; it stays silently, and the agent looks as if it stopped without a word. So every watcher has a time limit, and the human-facing monitor is kept separate, without an agent.

Attach a watcher in the order below.
1. **Confirm the start.** Some tens of seconds after launch, confirm the start from the first log line.
2. **Confirm the file to watch.** Do not guess the path of the file the watcher looks at or the shape of its lines; confirm them on the same file left by a previous run.
3. **Wait on the PID exit.** Attach the wait condition to the PID exit, not to a result string, so that any end (including errors) is caught. Make the end-marker pattern (exit line, smoke result line, first epoch line) match only this run's lines. If failure or skip lines from a previous run remain, the watcher wrongly concludes the job has already ended.
4. **Set a time limit.** Set a limit of the expected time plus a margin; when it is hit, look directly at the server's logs and files and tell the researcher right away what is late. Do not assume nothing happened just because the watcher has not woken.
5. **Stop together.** When a run is stopped, stop the watchers waiting for it too, so no watcher is left that will never end.

- A process-name search can match the watcher command itself and look "running" forever; if you use it, use a pattern that does not match itself (`[s]moke`).
- Check watcher output with grep. Word-splitting rules differ between shells, so splitting into variables can misjudge, and the GPU may sit idle meanwhile.
- Do not read long logs with tail; extract the needed lines with remote grep. With long-line logs, the tail window misses result lines.
- When a local watcher is cut by the laptop sleeping or moving and the researcher asks, check the server's queue log first, not the watcher output. The agent does not touch network settings.
- Watch with **one agent-free monitor pane**, not with agent workers. It shows one line per run every 2 minutes (epochs, latest value, done/error) and sits as one pane below the chat pane. The leader judges.
- Launch the monitor in the same turn that launches training, as a shared tool that takes only the run names and comparison runs as arguments rather than a new script per run. Long computations (checkpoint scoring, measurements) run as separate background jobs on the server that write to files; the monitor reads only those files and progress values and draws a screen immediately on launch. One line per run: on the left, words and numbers (progress, the score under the judgment definition and its epoch, comparisons written with words before the number such as "+0.73 over ○○", with ahead and behind shown by color); right of a divider, one small plot (the per-epoch median gradient trend and the last epoch's median and maximum, large values warned by color). Do not draw scores as trend bars: bars without axes, epochs or signs cannot be read. Put the definition and unit of each value in the header line (judgment definition, same-epoch comparison, per-epoch gradients). The leader does not wait in the chat pane for the monitor to appear; check it once. If the screen comes up late or the chat pane is blocked, the researcher cannot see progress, and without units it is unclear whether a value is per minutes or per epoch.
- Show on the monitor, along with progress (which epoch), the values the researcher actually looks at for judgment, but only values with the same definition as the judgment scoring (cells excluded, checkpoint used). Before showing them, match against one saved score, and if a value has a different definition, note the difference on screen and drop the comparison-against-base column. The researcher reads the trend on screen as a result, so a value defined differently from the judgment can lead to a judgment in the opposite direction.

## 5. Security and cost
Leave personal data and secrets nowhere in commands, output or records, and cap and pre-compute runs that cost money. A leaked value cannot be taken back, and an uncapped run burns through usage in moments.
- Do not put personal data such as the user's email into commands, API arguments or files. Some search APIs take contact details as request arguments, so put a prohibition sentence in research agent briefs.
- Add a filter so lines that may contain secrets (e.g., webhook addresses in old logs) are not printed, and run with the related environment variables set empty.
- Do not touch VPN or network settings. Run only the designated stop script when told to turn it off.
- Split API keys into per-person profiles, and record only amounts, never key values. Use only one key per run. Splitting one run across several keys splits the records and retries.
- For paid APIs, pick which key to use first by credit expiry date, and before running, compute cost with the measured unit price and confirm it is within the balance. If already measured with the same model and prompt, record the reason for skipping the pilot in the pre-registration document.
- Put caps on iterations, time and cost for agent runs and paid APIs; when a cap is hit, stop and notify. If usage spikes well above normal, find the cause before continuing.
- Only when the researcher has decided to work through workers because of usage limits, give the actual work (code, measurement, launches, fetching results) to a cheap model's worker as a single brief file, and let the leader do only instructing, judging and documentation. Keep answers and tool output short too, so the large model's allowance lasts the whole research period.

## 6. Commits and push
Commit only intended changes, in small revertible units, together with the corresponding documents. Push only when a person instructs it, after the checks below. Records and results must be in the same commit to trace later which result came from which code.
- Commit only the intended files. Do not add whole directories, and do not touch uncommitted files someone else was editing.
- Commit in units small enough to revert in one step, and do not commit unfinished work. Do not include intermediate files that can be regenerated, or large files.
- Put code or manuscript changes and the documents that correspond to them (design, results) in the same commit, and when reporting to the researcher, include the path of the document where it was recorded.
- Keep result data out of git, in separate storage (e.g., NAS). Track the manuscript in git too, excluding build outputs and old backups, and push the manuscript only when the repository is private.
- Commit pre-registration documents before the results to record the time. Read times from the clock or commit time, never guess.
- When regenerating a figure only to change labels, pixel-compare the old and new figure at the same resolution, and if anything other than the labels differs, stop without committing. This comparison catches figures and captions that have drifted to different versions.

Push in the order below.
1. Confirm that a person instructed it.
2. Check for secrets.
3. Check the documents: are the plan, result and design documents matching the change updated; is there a header; are failures and omissions recorded; do the paths the documents point to exist; is remaining work intended; is result data kept out of the commit; is there a one-line summary of what is pushed and why.
4. Push only to the designated remote branch; do not touch other branches or main of a shared repository. In a repository only the researcher uses, also push to main when the work branch continues straight from main (fast-forward), and never force-overwrite main.
