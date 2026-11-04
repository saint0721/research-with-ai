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

## 1. Roles of leader and workers
How to decide who does what when using several agents. Having the leader finish the work directly is often faster and cheaper than adding workers.

- The leader writes and runs pre-measurement scripts and small code changes directly. The time a worker spends reading the brief and code and setting up the environment is often far longer than the actual computation, and workers sometimes stop after writing code without running it.
- Launch workers only when the researcher asks. When used, give one worker one question and one file scope; the leader merges results from several workers into one document. Do not use workers for short document tasks.
- Split research into several narrow questions, launch research agents in parallel, and have them mark how deeply they checked the full text.
- Run independent steps at the same time on separate GPUs. Do not chain them on one GPU. Splitting steps and overlapping them greatly shortens the time from decision to training start.
- A pre-measurement without a pass bar does not block training. Launch training first, run the measurement alongside on another GPU, and stop training only if harm shows up.
- If the runner runs a smoke before training, workers do not run the same smoke separately.
- Keep only one final watcher per agent so it wakes once, and stop the agent after it commits. Keeping agents running makes token cost grow quickly.
- Workers only commit in a separate workspace (worktree); the leader merges and resolves conflicts. If the work line branched from an old main, port only the work line's values onto main's structure.
- The leader analyses and reviews code written by a worker line by line against the design document, and runs the tests, smoke and training itself. Do not train on a worker's "tests pass" report alone (also check that the worker's tests actually discriminate the property they target; for example, a test comparing two models built from the same seed almost always passes).
- The worker brief says not to touch networking, VPN, ssh configuration or desktop apps outside the assigned scope, and when a server or other outside resource cannot be reached, to stop and report instead of trying to fix it. A blocked worker can look for a way around on its own and change the researcher's working environment (connections, open apps).
- The worker brief says not to open question prompts. When unsure, the worker uses a safe default and notes it in the handoff.
- Verification/advisory workers and execution workers use different model families to keep verification independent. Model names are chosen by configuration, not hard-coded.
- When a usage limit is hit, switch to a pre-defined low-cost or free route and reuse the policy copy as is.
- Do not judge a multi-agent tool's performance by message count or acknowledgement count. The metrics are cost per completed task and result quality; an evaluation where the evaluator saw the task information in advance is invalid. Reusing the same prefix context and trimming tool output cuts cost greatly.
- If instructions conflict on whether the leader or a worker handles small code changes, ask the researcher once and record the answer in the operations document.

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
- How to keep GPUs full: the CPU prepares the next input in advance, and small jobs that cannot fill a GPU go into a second slot on a GPU with spare memory. Training never goes into a second slot. For a job type run for the first time, run it alone to measure peak memory before packing it.
- Do not change run settings such as batch size in an ongoing experiment. The numbers may change.
- Back up results against server outages, and do not stop at backups; also test restoring.

## 4. Watchers and monitors
How to notice that a long job has finished, and common mistakes.

- Confirm the end with an end marker line in the log (exit line, smoke result line, first epoch line). A process-name search can match the watcher command itself and look "running" forever; if you use it, use a pattern that does not match itself (`[s]moke`).
- When looking for the end marker, make the pattern match only this run's lines. If failure or skip lines from a previous run remain, the watcher wrongly concludes the job has already ended.
- Check watcher output with grep. Word-splitting rules differ between shells, so splitting into variables can misjudge, and the GPU may sit idle meanwhile.
- Moving the laptop or letting it sleep cuts local watchers and the VPN and delays notifications. When the researcher comes back and asks, check the server's queue log first, not the watcher output. The agent does not touch network settings; a person reconnects.
- When a run is stopped, stop the watchers waiting for it too. Do not leave watchers that will never end.
- Keep the human-facing monitor as one pane below the chat pane and show only short output.
- Do not read long logs with tail; extract the needed lines with remote grep. With long-line logs, the tail window misses result lines.

## 5. Security and cost
Rules for personal data, secrets, external transfer and paid APIs.

- Do not put personal data such as the user's email into commands, API arguments or files. Some search APIs take contact details as request arguments, so put a prohibition sentence in research agent briefs.
- Add a filter so lines that may contain secrets (e.g., webhook addresses in old logs) are not printed, and run with the related environment variables set empty.
- Do not touch VPN or network settings. Run only the designated stop script when told to turn it off.
- Split API keys into per-person profiles, and record only amounts, never key values. Use only one key per run. Splitting one run across several keys splits the records and retries.
- For paid APIs, pick which key to use first by credit expiry date, and before running, compute cost with the measured unit price and confirm it is within the balance. If already measured with the same model and prompt, record the reason for skipping the pilot in the pre-registration document.
- Turn the security terms of a contract or grant directly into design requirements. E.g., no external transfer → a model that runs locally, encrypted storage, deletion confirmation. The researcher decides whether to keep the originals.

## 6. Commits and push
Rules for recording and publishing changes to code, documents and manuscripts.

- Commit only the intended files. Do not add whole directories, and do not touch uncommitted files someone else was editing.
- Push only when a person instructs it, and check for secrets before pushing. Push only to the designated remote branch; do not touch other branches or main of a shared repository. In a repository only the researcher uses, also push to main when the work branch continues straight from main (fast-forward). Never force-overwrite main.
- Document check before push: are the plan, result and design documents matching the change updated; is there a header; are failures and omissions recorded; do the paths the documents point to exist; is remaining work intended; is result data kept out of the commit; is there a one-line summary of what is pushed and why.
- Keep result data out of git, in separate storage (e.g., NAS).
- Track the manuscript in git too, excluding build outputs and old backups. Push the manuscript only when the repository is private.
- Commit pre-registration documents before the results to record the time. Read times from the clock or commit time, never guess.
- When regenerating a figure only to change labels, pixel-compare the old and new figure at the same resolution, and if anything other than the labels differs, stop without committing. This comparison catches figures and captions that have drifted to different versions.
