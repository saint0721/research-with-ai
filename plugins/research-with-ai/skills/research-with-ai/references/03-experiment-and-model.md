# Research with AI — Experiments and Model Development

| Item | Content |
| --- | --- |
| Purpose | Lets you, from this document alone, design experiments with an AI agent, build a fair and reproducible environment, and develop, measure, and judge a model one step at a time |
| When to read | When designing a new module, loss, or experiment; when setting the run environment and comparison conditions; when writing code and launching training; when judging results and choosing the next row |
| Outputs | A finalized design document, a fixed run environment and protocol settings, module code with tests, training runs with complete records, a result document and one ladder-table row |
| Structure | §0 workflow, §1–§10 methods. Domain-agnostic; can be moved as-is into agent instructions or a skill |

## 0. Workflow
The chapters an experiment passes through from design to judgment, and each chapter's output.

| Order | Chapter | Output |
| --- | --- | --- |
| Design | 1 Design dialogue | Finalized design document, verbatim decisions |
| Review | 2 Scientific review, 3 Loss and equation review | Review section of the design document |
| Preparation | 4 Experiment environment, 5 Fairness | Fixed run environment, protocol settings |
| Implementation | 6 Writing code | Module files, tests |
| Execution | 7 Development and execution, 8 In-training measurement | Smoke results, training run, hand-drawn overview |
| Judgment | 9 Judgment and next row, 10 Evaluation data and labels | Result document, one ladder-table row, next-row candidates |

## 1. Design dialogue
Model design is a dialogue: the researcher raises a topic, the AI finds what to borrow and recommends candidates, and the researcher asks, challenges, and chooses. No code or measurement starts before the design is finalized.

### 1.1 Flow of the dialogue
| Order | Researcher | AI |
| --- | --- | --- |
| ① Topic | Raises a direction, problem, thing to borrow, or concern | Restates the topic in one sentence and checks it is right |
| ② Record check | — | Checks the log and rejection list for whether the same direction is already closed or something similar was tried, and says so first |
| ③ Borrowing | — | Finds usable parts in prior papers, their code, and existing code, and shows them with the original equations and standard values |
| ④ Candidates and recommendation | — | Gives 2–4 numbered candidates, each with expected gain, adoption chance, novelty role, and cost, then recommends one |
| ⑤ Questions and objections | Asks about unclear words, behavior, risks, alternatives | Answers in plain words with examples, and records in the design document what the answer changed |
| ⑥ Decision | Picks by number, picks with a condition, or delegates the decision | Records the decision verbatim and moves to the next step (borrow → code → smoke) |
| ⑦ Post-finalization review | Hears the review results and gives final confirmation | Reviews scientific validity (§2) and loss/equations (§3) and reports them in plain words |
- ①–⑥ may loop several times in one dialogue. If one researcher question changes the design, restart from ④.

### 1.2 Topics the researcher raises
| Type of topic | Content | AI's response |
| --- | --- | --- |
| Direction | Asks to find a direction that grows the contribution | Researches and presents direction candidates tied to measured failures |
| Borrowing | Asks to build something like a module from a specific paper | Checks that module's original equations, code, and values, and shows where and how it goes into this model |
| Problem | Points out that a specific part has many errors | Confirms the problem by measurement and proposes candidate causes |
| Improvement | Asks how to make the current design better | Shows the axes to change, split into missing standard techniques, loss, placement, and strength |
| Concern | Points out a risk the design may create | Explains the conditions under which the risk actually occurs and the safeguards, and puts them into the design |
| Inference | Reasons out the design's behavior and asks whether it is right | Answers with evidence, separating the right and wrong parts |
| Direction correction | Points out that the AI's proposals have drifted from the research's center | Acknowledges why it drifted and returns the design to the researcher's axis |

### 1.3 How the AI proposes candidates
- Candidates are built from steps ②–④ of 02 §2 (measure the failure point → one cause hypothesis → the smallest intervention targeting only that cause). Each candidate carries a prior-work comparison and "does it improve with more resources?".
- Give 2–4 numbered candidates, so the researcher can choose briefly by number.
- For each candidate, state expected gain (how much it might improve), adoption chance, novelty role in the paper, and cost (time, memory). "Resources are idle" is not a reason for a candidate.
- Recommend only one, with a reason. If the recommendation overlaps the record (a direction already tried), say so first.
- Separate what the researcher chooses from details the AI may set. Set detailed values to prior-work standard values and do not ask about them separately.

### 1.4 Aligning understanding
- The researcher and the AI may understand the same word differently. If the researcher asks whether their concepts differ, the AI states its own definition first, aligns it with the researcher's, and rewrites the design.
- Explain a module's behavior as what happens from one input going in to coming out, and say at which stage of the model (input processing, intermediate representation, output) it attaches.
- When the researcher restates their understanding, answer by separating what is right from what differs.
- Record the aligned explanation in the topic page's "In plain words" section so later sessions use the same meaning.

### 1.5 Decisions and delegation
| Decision form | What the AI does |
| --- | --- |
| Choice by number | Finalizes the design document with the chosen candidate and moves to the next step |
| Conditional go-ahead (e.g., train if smoke succeeds) | Proceeds only within the condition; stops and reports if the condition breaks |
| Split execution | Does not mix into one row; splits into rows and runs them in parallel |
| Delegation | Researches the evidence, decides, and records that the decision was delegated and on what evidence |
| Correction | Fixes the design immediately and records what was misunderstood |
| Hold | Only explains; does not proceed |
- Record decisions verbatim in the log and in the design document's decision section. Do not record more broadly than what the researcher chose.

### 1.6 Pre-design overview and constraints
- Before design starts, the researcher draws the model's overview by hand. Follow one training step from input to loss, and at each place that can be changed, write "what it does now" and "decision status (open/decided)". The AI provides the list of places and explanations; all later dialogue uses this overview's place names.
- Put the constraints to keep (inputs not to use, banned techniques, fairness conditions) as a list at the top of the design document. Because the AI forgets constraints in long dialogues and re-proposes banned techniques, every design document repeats the same list.

### 1.7 Design document template
| Section | Contents |
| --- | --- |
| Problem and goal | The measured failure and what this design aims to reduce |
| What is borrowed | Parts taken from prior papers and code, original equations and standard values |
| Equations | The equations that fit on one page and the meaning of each symbol (explained separately to the researcher in plain words) |
| Controls and tables | Hypothesis written before results, rows to compare, compute-matched controls, the control variable that tests the mechanism, the shape of the ablation table |
| Benefit and role | Expected margin, adoption chance, novelty role in the paper |
| Researcher questions | Verbatim questions and answers, and what they changed |
| Decision | What was decided and by whom; for delegated decisions, the evidence |

## 2. Scientific validity review
Once the design is finalized and before writing code, discuss separately "is this design scientifically sound?". Even with correct equations, if hypothesis and measurement are misaligned the result cannot be interpreted.

- **Hypothesis–intervention link**: Check that the intervention touches only the hypothesized cause. If it also touches other causes, the result cannot tell what had the effect.
- **Premise check**: Write down the premises the design relies on (e.g., "the model playing the answer role gets this case right", "this signal carries information"), and check, right after finalization, the premises that can be checked without training.
- **Target–device conflict**: Check whether the hard region to be fixed overlaps the region the device filters out. A filtering device cannot fix errors in the region it filters out.
- **Confirmation bias**: For designs that use the model's own predictions as targets, check for paths by which wrong predictions harden. If there are any, add safeguards (a slowly following answer model, excluding uncertain cases, supervision with human-made answers).
- **Falsifiability**: Write down which result would mean the hypothesis is wrong. If the hypothesis survives any result, it is not an experiment.
- **Sufficiency of controls**: Check that there is a control matched in compute and training time, and a diagnostic that measures the mechanism directly.
- **Blocking shortcuts**: Check whether the task can be solved without the key input. Design the task so that a model without the key input performs at chance, and use that result as evidence that the task really needs the key input.
- **Discriminability**: Include only cases where the simple method actually fails. If cases solvable by the simple method are mixed in, the difference between methods is buried.
- **Variable isolation**: Make compared pairs differ only in the one factor of interest. If other factors change too, what had the effect cannot be separated.
- **Human-level check**: Measure accuracy and agreement of two or more humans, to decide whether the task is solvable by humans and where to place the model's results when reading them.

## 3. Loss and equation review
The researcher does not solve losses and equations directly; they are settled through questions and plain explanations. The AI does the equation work and review; the researcher hears the results in words and numerical examples and judges.

### 3.1 Ask about unclear words as they are
- When a word in the design is unclear, ask about it as is (the meaning of a term, what an operation does, what unit a loss matches on, etc.).
- The AI answers with numerical examples instead of equations. E.g., "The model outputs a probability per candidate for each input. If cat is 0.70, dog 0.25, other 0.05, the prediction is cat, and dog 0.25 is the remaining second-place probability."
- Aligning understanding and recording it follow 1.4.

### 3.2 Order for choosing a loss
1. **State the purpose in words.** Write in one sentence what the loss should make match what.
2. **The AI shows candidates fitting the purpose, by family.** Not just the common three (KL, MSE, JS), but other families achieving the same purpose (contrastive, noise-robust losses, etc.).
3. **Explain each candidate's property in one plain line.** E.g., "KL follows strongly even when the target is wrong", "MSE is pulled less by a wrong target", "Huber pulls less hard when the difference is large".
4. **Check whether there is something better.** Find papers comparing losses head-to-head under the same conditions and show the numbers.
5. **Consult another AI if needed.** The consultation result is evidence, not a decision.
6. **The AI recommends one and attaches one comparison row.**
7. **The researcher chooses.**
8. **Ask about expectations.** For "do you think this loss will deliver performance?", the AI estimates with evidence and corrects itself if the evidence is weak.

### 3.3 What the AI checks on the researcher's behalf
The AI does the equation review and records the results in the design document as plain answers to the questions below.

| Check | Form given to the researcher |
| --- | --- |
| When the target is wrong | "How strongly does the learning side follow when the answer side is wrong?" |
| Collapsing solution | "Is there a trap where making all outputs or representations identical gives zero loss, and what prevents it?" |
| Averaging trap | A loss that matches only the average treats, when the target is [A 0.6, B 0.4], a prediction split into "some confident A, some confident B" as zero loss → sharpen the target or also match individual predictions |
| Where the signal reaches | "Up to which layer does this loss affect the model, and does another loss already reach it by the same path?" |
| Magnitude | "Is the initial loss value of similar size to existing losses, or so large that it takes over training?" |
| Unknowns | "The equations cannot tell the size of the gain. Only training can confirm it." |
- Keep the equations themselves in the design document and unit tests (comparing hand calculations with code output); discuss with the researcher in the words of this table.

## 4. Experiment environment setup (reproducibility)
How to fix code, environment, data, configuration, and randomness before starting experiments, and record them for every run. If anything changes mid-experiment, differences between rows cannot be interpreted, so build this environment before module development.

### 4.1 What to fix
| Target | How to fix | Refuse to start when |
| --- | --- | --- |
| Code | Record the commit a run uses and run from a fixed copy of that commit | Tracked files have uncommitted changes |
| Software environment | Make one lock file of package list, versions, driver, and GPU name, and compare hashes | Lock-file hash differs |
| Data | Make a list (manifest) of path, size, and hash of every file a run reads. Check the split lists every run; check full hashes before a campaign starts and after data changes | Hash or file count of the split lists differs |
| Configuration | Write in one format (e.g., YAML) with inheritance; every key in the resolved final configuration has a value. No defaults inside the code | Unknown key, missing key, change to a protected key |
| Run arguments | The only things changeable at run time are seed (within a fixed list), GPU number, and run name | Other values changed via arguments |
| Run folder | Do not overwrite an existing folder | Folder already exists |

### 4.2 Randomness and determinism
- Split named random streams from one seed (data order, data transforms, sample selection, per feature). Turning on one feature does not change another feature's random order, so "random difference" drops out of the difference between two rows.
- Fix the data loader's worker seed and generator.
- Measure the speed cost of deterministic mode (deterministic algorithms) and any remaining nondeterministic ops. If full determinism is not possible, measure and record the difference between two runs of the same configuration (noise floor), and use it as the equivalence pass line when migrating code.
- For parts that vary between runs, such as bf16 and GPU, write that fact and its size in the result document.

### 4.3 Run records
- Keep in the run folder the resolved configuration, provenance record (commit, environment hash, data hash, configuration hash, GPU, start and end times), training log, metric records, cost records, checkpoints, and result files.
- Record failures, omissions, and non-evaluations as they are in a ledger (failure record file) and the corresponding document. Check artifacts' integrity by hash.
- Before starting, the runner checks that tests pass (at that commit), the working tree is clean, environment and data checks pass, configuration validates, and the GPU is free.
- Do not write the ladder table by hand; build it by collecting result files from a list of configuration paths and runs per row.
- Run the final test by checking out the frozen commit into a separate workspace, and check the code hash before running.
- Write re-scored or re-run results to a new folder; do not overwrite old results.
- Record a cell whose external API run failed as a failure; do not fill it with another model.
- Measure the size of the difference that appears when rerunning the same configuration, write it in the result document, and use it as the reference for interpreting differences.

## 5. Fairness setup
How to fix comparison conditions before the experiment so that comparison results reflect only the difference between methods.

### 5.1 Protected keys
- Keep split, ground truth, number of updates, batch, learning-rate schedule, evaluation method, and seed only in the protocol configuration. If a method configuration changes these values, the validator refuses.
- Comparison methods use the same protocol and the same evaluator.
- Evaluate all fixed metrics at once at a fixed point (e.g., last epoch). Do not keep a separate path that re-scores a metric.

### 5.2 Resources and devices
| Matched (resources) | Not matched (method-specific devices) |
| --- | --- |
| Base model and pretraining | Data transform family |
| Data split, label set | Loss composition |
| Batch size | Optimizer type |
| Total number of optimizer updates | Input size and cropping (may be part of the method's design) |
| Evaluation method and metrics | Learning rate (chosen per method on validation data) |
| Seed | Method-specific modules |
- Forcing devices to match can remove the method itself, so state in the result document what was not matched.
- Different costs per method (number of forwards, step time, peak memory) are allowed, but are recorded automatically and reported together.

### 5.3 Matching the training budget
1. Measure steps per epoch, batch, and number of epochs in the new method's original configuration.
2. Set the target number of updates T = new method's steps per epoch × number of epochs. Do not use the baseline's documented number of epochs as the reference.
3. Match the baseline's batch to the new method's.
4. Measure the baseline's steps per epoch and set baseline epochs = T ÷ that value.
5. State both the number of epochs and the maximum step cap so the learning-rate schedule runs to the end. Using only the cap truncates the schedule.
6. After the run, check in the log the batch, steps per epoch, total updates, whether the cap was reached, and the code commit.
- Measure steps per epoch rather than computing them by hand. Documented assumptions and measurements sometimes differ.

### 5.4 Comparison groups and reporting
- Every experiment must be comparable to prior work. Own setups without a comparison target are banned by default.
- Training our method on any data is not the problem; what must hold is that trainable comparison methods are also trained and evaluated with the same data, split, and selection rules.
- Report sample counts (per group, case, and split, with definitions) side by side with prior work's counts.
- Fix sample groups, seeds, and splits before results, and do not pick only favorable ones. Do not rewrite non-evaluated items as "excluded".
- Do not loosen frozen thresholds or caps to increase samples. If they must change, change them uniformly across everything and only before results.
- State the denominator of success rates, and report both the per-group equally weighted value and the pooled total.
- Do not change run settings such as batch within an experiment. Changes are made only in a new experiment, after writing an equivalence check criterion before results.
- Fix one rule for combining results across seeds (e.g., average per-sample probabilities, then compute the metric) and apply it identically to comparison methods.
- Include cells where comparison methods are also given our method's device, to separate whether the gain comes from the device or the model.
- If the benchmark's definition (included items, etc.) changes, keep models and thresholds as they are and recompute every reported number under the new definition.
- For paid runs, document the decision to run and the cost basis before results, then run.

## 6. Writing and managing code
Rules for writing, testing, moving, cleaning up, and pushing research code.

### 6.1 Scientific coding principles
Scientific code serves truth, not users, and the worst outcome is a plausible-looking wrong result. Apply the principles below to all research code.
- Write research code using the Scientific Coding skill ([scientific-coding-skill](https://github.com/cemde/scientific-coding-skill), MIT License). The principles below are a Korean summary of that skill's principles. Install it in the agent as a plugin so the agent reads it on its own when writing research code (it is not a skill you call directly); for workers that cannot read the skill, put the four lines written below the table at the top of the task spec.


| Principle | Meaning | Related chapter |
| --- | --- | --- |
| Understand the experiment first | First identify what is compared and what is controlled. Parts shared across conditions use the same code; only the diverging parts branch | 1, 5 |
| Work as a co-researcher | When judgment is needed, stop and hand it to the researcher | 1.5 |
| Fail loudly | Do not fill values the experiment needs with broad exception handling, fallback values, or `get(key, default)`. A failed value must not look like a real result | — |
| No hidden defaults for experiment variables | Values that change results (model, threshold, data, seed, window size) are exposed as arguments or configuration and recorded in the run record | 4.1 |
| Make everything explicit | No hidden assumptions | 4.3 |
| Correctness over speed | Do not drop verification to go faster | 6.3 |
| Preserve raw data | Do not modify raw data; write processed results to new files | 10 |
| Reproducibility | Record seeds and the size of nondeterminism (low-precision ops, GPU) | 4.2 |
| Verify with actual values | Check with actual values, not with what documents or specs say | 6.3 |
| Statistical honesty | Do not hide intervals or denominators | 9 |
| Existing tools first | Do not reinvent the wheel; do not over-engineer | 6.2 |
| Preserve verified code | Do not restructure code whose results are verified without being asked | — |
- When moving a feature or extracting it into a shared file, take the pre-change result as a reference and confirm the same inputs and seed give the same losses and outputs before moving on.
- For workers that cannot read the skill, put four lines at the top of the task spec: "fail loudly, no hidden defaults, record reproducibility, preserve verified code". In repository instructions, do not copy the principles verbatim; keep only the four lines and the source.
- Turn principles into stop conditions in code. Check scripts stop without producing results when claims and numbers disagree or when unintended changes appear. When renaming, keep internal keys and change only display names.

### 6.2 Structure
- One module = one file + one switch. Keep core training code fixed; put a new feature in its own file as a registered class and turn it on via configuration. Do not let features pile up in one file.
- Split folders by pipeline stage (data → training → judgment → evaluation, etc.), and mirror the same stage folder structure for tests. Collect run shell scripts in one folder.
- Extract computations shared by several modules (paths, records, shared ops) into one shared file.

### 6.3 Tests
- For each equation in the design, have a unit test comparing a hand calculation with the code output.
- For each new module, test "off equals the existing path", "new parameters change after one step", "the training signal does not reach where it must not", and "the configuration differs from the previous row by exactly one key".
- Pass the full test suite in the environment where it will actually run (the server). Record the cause of tests that fail due to environment differences.
- Block data leakage in code. E.g., stop immediately if test data appears in training or validation paths.
- Record whether the test or the code was wrong. If the test was at fault, say so and fix it.

### 6.4 Moving and running code
- Write code in one place (the working repository) and send it to the run server only through a fixed sync path (bundle transfer, etc.). Do not move code by pasting it into a terminal.
- Run from a fixed copy per commit, and do not touch code that a running run reads.
- The leader agent makes short code changes directly. Handing them to a worker costs more in reading code and specs than the work itself.

### 6.5 Cleanup
- Do not keep code for finished directions; delete it. If the deleting commit is recorded, git history can restore it any time.
- Do not delete, move, or commit files the researcher is in the middle of editing.
- When moving or renaming, fix references in documents and code together, and check there are no broken links.
- Do not put result data (output folders) in git. Track the manuscript in git but exclude build artifacts.

### 6.6 Committing and pushing
- Commit only the files changed in this task, named explicitly.
- Push only after the researcher approves, and only to the designated remote branch. Do not force-overwrite the default branch.
- Before pushing, check: is the corresponding document updated, is the document header correct, are failures and omissions recorded, are references valid, are there no leftover tasks or orphan processes, is no result data mixed in, is there no secret information (tokens, webhook URLs).
- Filter old logs containing secret information when printing them, and set the related environment variables to empty values.
- After editing manuscript files, compile and check the log (undefined citations and references, overflow warnings) before reporting.

### 6.7 Understanding code
- Keep a walkthrough document that follows one data item from input to result by file and line number, so the researcher can follow the code.
- The walkthrough pairs paper sections with code locations, and notes any place where the paper's description and the code differ.

## 7. Development and execution
The assembly-style development procedure of changing the model one thing at a time, and the method of learning the design by drawing it by hand while training runs. Based on practices that major vision research followed when building models.

| Practice | Where in this document | Source |
| --- | --- | --- |
| Reproduce a standard baseline, refine its training setup, then freeze it | §4, §5.1 | [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193) |
| Keep one default setup and change one factor at a time | §7.1 ③, 00 principle 6 | [MAE](https://arxiv.org/abs/2111.06377), [ConvNeXt](https://arxiv.org/abs/2201.03545) |
| Record each change and its result as a row of a ladder table | §7.1 | [ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193) |
| Screen cheaply, then confirm at scale | §7.1 | [RegNet](https://arxiv.org/abs/2003.13678), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook) |
| Adopt only gains larger than seed-to-seed variation, with the rule set before the result | §7.1, §9 | [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook) |
| Find the cause of a failed step before dropping it | §9 | [ConvNeXt](https://arxiv.org/abs/2201.03545), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/) |
| Keep core code fixed; add new parts as their own files switched on by config | §6.2 | [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation) |

### 7.1 Development order
| Step | What to do | Condition to move on |
| --- | --- | --- |
| ① Borrow | First find usable parts in prior papers' code and existing code, and record source, license, and changes | What is borrowed and what is new are separated |
| ② Design | The dialogue and review of §1–§3, the environment and fairness setup of §4–§5 | The researcher finalizes the design |
| ③ Code | Write code and tests per §6 | With the switch off, results equal the previous row; the configuration differs from the previous row by exactly one key |
| ④ Smoke | Run briefly to check that new parameters leave their initial values, the new loss is on the same order of magnitude as other losses, collapse indicators are normal, and step time and memory | All of the above are normal |
| ⑤ Training | If smoke succeeds, train immediately without waiting for approval, and give the researcher a one-page sheet for hand drawing (7.2). Report the start only after seeing the runner's start record | On failure: analyze cause → fix → smoke again |
- In the ladder table, record per row the one change, extra cost, metrics, difference from the previous row, and adoption decision.
- Changes outside the design (new direction, value tuning, fixes) are decided by the researcher.
- Screen candidates cheaply first. Make the first call with a short schedule, a small setup or a single seed, and confirm only the surviving rows at full scale with several seeds. Keep screened-out rows in the ladder table as they are.
- Final adoption requires a gain larger than seed-to-seed variation. Measure that variation by running the same setup with several seeds, and write the adoption rule in the pre-registration document before the result.

### 7.2 Drawing the overview by hand
While training runs, the researcher writes out the finalized design by hand and redraws the overview drawn in 1.6 with the new module added. The design has to be in the researcher's head to be able to say the next move on their own after a failure.

- **When**: Right after the design is finalized and training starts, before results come in. Drawing after seeing results mixes in interpretations fitted to the results.
- **What to draw**
  - Flow from input to output: which input passes through which model and where it branches.
  - Place of the new module: at which layer it takes what and outputs what, and how sizes change.
  - Position of the loss: what it matches to what, and which side plays the answer role.
  - Flow of the training signal: which parts the loss changes and which it does not.
  - Write in one plain line what the loss does, and note beside it the traps heard in 3.3 (collapsing solution, etc.).
- **AI's role**: When launching training, summarize on one page what to draw (list of places, what the loss matches to what, where the training signal reaches and where it is cut, in plain words and examples). Take the researcher's drawing and questions, compare them with the design document and code, and point out mismatches.
- **After results**: When results come in, mark on the drawing "where it differed from expectations", and choose from the drawing the place to change in the next row. Discussion of failure causes uses this drawing as the reference.

## 8. In-training measurement
How to measure and keep, without omission, everything measurable inside an actual training run. In-training measurement has one use only: explaining why the result came out as it did. Adoption is decided by the final metrics; in-training measurement is used to reveal the reason.

### 8.1 Measurement principles
- Measure everything measurable. Record now the values that might be needed later, so that a finished experiment never has to be retrained to obtain values.
- Turn on the same items for every experiment. Causes can only be separated if rows are comparable.
- Fix the measurement items before the experiment, and when building a new module, build that module's mechanism metrics with it.
- Keep measurement as a record-only module, and test that turning it on and off gives the same training results. Save and restore state so the randomness used by measurement does not change training randomness.
- If measurement is costly, increase the interval but do not drop items.

### 8.2 Measurement items
| Category | Recorded items | When |
| --- | --- | --- |
| Run information | Full configuration, commit, environment and data hashes, seed, GPU, start and end times | Start and end |
| Loss | Value per loss term, actual contribution of each term multiplied by its weight, value and share per stage (layer) | Every step or epoch average |
| Training state | Learning rate, gradient norm (total and per module), gradient-clipping rate, parameter norm, count of NaN/Inf occurrences | Every epoch |
| Performance | Main metric, guard metric, per-class, per-bin, and boundary metrics | At fixed epochs; if several models are evaluated (e.g., the original and the moving-average model), all of them |
| Prediction distribution | Per-class predicted share versus ground-truth share, confidence distribution, confidence–accuracy mismatch | At fixed epochs |
| Quality of self-made answers | Accuracy, acceptance rate, and change rate of answers the model makes (pseudo-labels, etc.), on validation data with known ground truth | At fixed epochs |
| Mechanism | Internal state the method aims to change (quality of intermediate representations, per-stage contribution, pass rate of new devices, etc.) | At fixed epochs |
| Error location | Share of errors in regions where errors concentrate (hard conditions, near boundaries, confident but wrong) | At fixed epochs |
| New parameters | Trajectories of new values such as gates and weights | Every epoch |
| Cost | Step time, peak memory, number of forwards | Every epoch |
| State preservation | Checkpoints (model, optimizer, method's internal state, random state included) | At fixed intervals (e.g., 10 epochs) and at the end |

### 8.3 How to record
- Keep every value in the run folder in a machine-readable format (one record per line), without overwriting. Keep it separate from the human-readable log.
- Do not delete records of failed or interrupted runs; record why they stopped.
- A script builds the draft result document from these records (run information, judgment, per-class differences, per-bin changes, loss shares, diagnostic trends); humans only write the interpretation.
- If a value missing from a finished experiment is needed, measure it from the saved checkpoints instead of retraining. When rerunning training steps from a checkpoint, compare the first-step loss magnitude with the original experiment to confirm the internal state is right.

### 8.4 How to read the records
After results come in, explain "why it came out that way" with the questions below.

| Question | Records to look at |
| --- | --- |
| Did what the method aimed to change actually change? | Mechanism metrics |
| Did the new loss actually act on training? | Actual weighted contribution and share, gradient norm |
| When did they diverge? | Per-bin performance differences, loss trajectories |
| Where was it gained and where lost? | Per-class metrics, error locations, per-stage values |
| Was training healthy? | Gradient-clipping rate, NaN/Inf, skew in prediction distribution, quality of self-made answers |
- Use the explanation as the basis for diagnosis and choosing the next row in §9.

## 9. Judgment and next row
Rules for deciding adoption, holding, or adjustment after results come in, and choosing the next row.

- Before discarding a row that did not improve, diagnose the cause. Look in the order implementation check → missing standard techniques → in-training measurement (8.4) and checkpoint analysis; the researcher chooses the fix. Do not automatically run pre-decided fix candidates.
- If the result is weak, before discarding the idea, check whether standard techniques such as sharpening, normalization, or weight schedules are missing.
- When checking the structure, use prior-work standard values; tune values such as weights and temperatures only after the structure has shown an effect.
- When lifting an existing constraint, lift it only as a component of the method tied to a measured failure, keep a separate ablation row, and give the baseline the same resources.
- Fix the adoption threshold in advance, and label results whose lower bound across several seeds does not exceed 0 as "1-seed result".
- Choose the next move after a failed row on the overview the researcher drew (7.2).
- Keep rows that were tried but not adopted in a table with their results as they are; they may go into the paper as an appendix table.
- If the paired interval of a new result includes 0, lower the strength of the claim (e.g., "outperforms" → "comparable"). If a result contradicts a previous claim, withdraw the claim.

### 9.1 Pre-measurement without training is for stopping only
Pre-measurement without training (attaching a device to a trained model and running it forward once) cannot see the effect of training, so it is not used as a reason to proceed, only as a reason to stop.

- **Where to use it**: Only to check whether the facts the design relies on really exist.
  - Premise check: does the phenomenon the design targets actually exist?
  - Information check: does the signal the new device will use contain information?
  - Upper-bound check: even working perfectly, is the share it can fix large enough?
- **What to look at**: Not the size of the number but present or absent. If "absent", close that direction without training. "Present" only qualifies it for a training try; it is not a reason to proceed.
- **Where not to use it**: Choosing among candidates, setting values, predicting gains.
- **When to do it**: Only when the design is finalized, the premise is uncertain, and training is expensive. Otherwise go straight to smoke and training.

## 10. Evaluation data and labels
How to handle evaluation data and human labels so that criteria or choices are not changed after seeing results.

- Split test data with a fixed seed and seal it; first verify the evaluation process on the rehearsal half, then look at the main test only once.
- Put numbers into the main text all at once after all results are in; if results are weak, do not reselect the system, only lower the strength of the wording.
- If anything was chosen differently from the pre-set rules, state how, with numbers, in the appendix.
- Do human evaluation first with machine scores sealed; if a flaw is found, preserve that round as void without opening the scores.
- Fix qualitative examples in advance (e.g., by hash order), include a wrong example, and do not reselect even when comparison targets increase.
- Choose values on the validation split and write "validation-selected" in the result document. Values chosen on the test split create optimistic gains.
- Keep external models trained on the target labels only as reference rows.
- Measure labels' self-reproducibility (agreement rate, κ) by relabeling after a time gap with the order reshuffled. State in the paper any label procedure that changed from the plan.
- Inspect benchmark items visually with model predictions hidden, remove whole categories as the unit, and if the decision was made after results, record how.
- Automatic detection results are not ground truth before human approval, and uncertain cases are not confirmed as negative.
- Set thresholds for automatic labels using training labels only, and confirm them by agreement with validation labels.
- For examples shown in figures, write the selection rule and seed first, and record statistics for all samples meeting the condition.
