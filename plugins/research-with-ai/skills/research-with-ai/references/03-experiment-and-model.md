# Research with AI — Experiments and Model Development

| Item | Content |
| --- | --- |
| Purpose | Lets you, from this document alone, design experiments with an AI agent, build a fair and reproducible environment, and develop, measure, and judge a model one step at a time |
| When to read | When designing a new module, loss, or experiment; when setting the run environment and comparison conditions; when writing code and launching training; when judging results and choosing the next row |
| Outputs | A finalized design document, a fixed run environment and protocol settings, module code with tests, training runs with complete records, a result document and one ladder-table row |
| Structure | §0 workflow, §1–§10 methods |

## 0. Workflow
The chapters an experiment passes through from design to judgment, and each chapter's output.

| Order | Chapter | Output |
| --- | --- | --- |
| Design | 1 Design dialogue | Finalized design document, verbatim decisions |
| Review | 2 Scientific review, 3 Loss and equation review | Review section of the design document |
| Preparation | 4 Experiment environment, 5 Fairness | Fixed run environment, protocol settings |
| Implementation | 6 Writing code | Module files, tests |
| Execution | 7 Development and execution, 8 In-training measurement | Smoke results, training run, hand-drawn overview |
| Judgment | 9 Judgment and next row, 9.5 Mechanism measurement of a row that rose, 10 Evaluation data and labels | Result document, one ladder-table row, mechanism measurement results, next-row candidates |

## 1. Design dialogue
Model design is a dialogue: the researcher raises a topic, the AI finds what to borrow and candidates and recommends one, and the researcher asks, challenges, and chooses. No code or measurement starts before the design is finalized.

### 1.1 Flow of the dialogue
The design dialogue cycles through three stages: topic, questions, and choice. What the AI does at each stage is in the order below.
1. When the researcher raises a topic (a direction, problem, thing to borrow, or concern), the AI ① restates it in one sentence and checks it is right, ② checks the log and rejection list for whether the same direction is already closed and says so first, ③ finds usable parts in prior papers and code along with the original equations and standard values, and ④ gives 2–4 numbered candidates and one recommendation (1.3).
2. When the researcher asks and challenges, answer in plain words with examples, and record in the design document what the answer changed. If one question changes the design, restart from the candidates.
3. When the researcher chooses, record the decision verbatim (1.4) and move to borrow → code → smoke. After finalization, review scientific validity (§2) and loss/equations (§3) and report them in plain words.

### 1.2 Topics and aligning understanding
Before answering a topic, first check that the AI and the researcher mean the same thing. A design written while meanings diverge drifts off the research's axis, so the aligned meaning is kept for use in later sessions as well.
- Restate the topic in one sentence to check it, then answer according to its type. For borrowing, give the original equations, code, and values and where they go; for a problem, the measurement and candidate causes; for improvement, the missing standard techniques and the axes to change (loss, placement, strength); for a concern, the conditions under which the risk occurs and the safeguards; for an inference, the right and wrong parts, with evidence.
- When corrected that the proposals have drifted from the research's center, acknowledge why they drifted and return the design to the researcher's axis.
- If the researcher asks whether their concepts differ, the AI first states its own definition, aligns it, and rewrites the design. Explain a module's behavior as what happens from one input going in to coming out, and the stage it attaches to (input processing, intermediate representation, output).
- Record the aligned explanation in the topic page's "In plain words" section so later sessions use the same meaning.

### 1.3 How the AI proposes candidates
Candidates are given in the same frame so the researcher can lay them side by side and choose. For each candidate, first state what it changes and any fact that could block it, and give only one recommendation, with a reason.
- Build candidates from steps ②–④ of 02 §2 (measure the failure point → one cause hypothesis → the smallest intervention targeting only that cause), and give 2–4 of them, numbered.
- For each candidate, state the prior-work comparison, "does it improve with more resources?", expected gain, adoption chance, novelty role, and cost (time, memory). "Resources are idle" is not a reason for a candidate.
- For each candidate, first state in one line which target (ground truth, self-made answers, etc.) of which data (e.g., labelled data, unlabelled data) the module changes. When the data the research question targets and the data the candidate handles diverge, the researcher can hardly notice.
- Attach one line each giving the meaning of any newly coined word in a candidate and the reason a loss or target is set that way, and redefine abbreviations used earlier, including their size and source. Also state any fact in existing measurements that could block the candidate. Bringing up a blocking fact late forces a reversal of the chosen option.
- Recommend only one, with a reason. If it overlaps a direction already tried, say so first. Set detailed values to prior-work standard values and do not ask about them separately.

### 1.4 Decisions and delegation
Follow the researcher's decision only within the scope chosen, and record it in the words chosen. What the AI does differs by the kind of decision (conditional, split, on hold, delegated, correction).
- Proceed with a conditional go-ahead (e.g., train if smoke succeeds) only within the condition; stop and report if the condition breaks.
- Split execution is not mixed into one row; split it into rows and run them.
- On hold, only explain.
- For a delegated decision, research the evidence and decide, and record that it was delegated and on what evidence.
- Apply a correction to the design immediately and record what was misunderstood.
- Record decisions verbatim in the log and in the design document's decision section, and do not record more broadly than what the researcher chose (07 §1).

### 1.5 Pre-design overview and constraints
Before design, the researcher draws the model's overview by hand. Follow one training step from input to loss, and at each place to be changed, write what it does now and its decision status (open/decided). The AI provides the list of places and explanations, and later dialogue uses these place names.

Put the constraints to keep (inputs not to use, banned techniques, fairness conditions) as a list at the top of the design document, and repeat it in every design document. In long dialogues the AI re-proposes banned techniques.

### 1.6 Design document template
A design document has all the sections below, and an analysis without training also gets a short design document first.

| Section | Contents |
| --- | --- |
| Problem and goal | The measured failure and what this design aims to reduce |
| What is borrowed | Parts taken from prior papers and code, original equations and standard values |
| Equations | The equations that fit on one page and the meaning of each symbol (explained separately to the researcher in plain words) |
| Controls and tables | Hypothesis written before results, rows to compare, compute-matched controls, the control variable that tests the mechanism, the shape of the ablation table |
| Benefit and role | Expected margin, adoption chance, novelty role in the paper |
| Researcher questions | Verbatim questions and answers, and what they changed |
| Decision | What was decided and by whom; for delegated decisions, the evidence |

- Even a draft has the whole template and the review sections (§2 scientific review, 3.1 choosing the loss, 3.2 loss table, the new mechanism metrics in §8) from the start. For a small row (one base technique, say), do not delete sections that do not apply; write "not applicable" and why. A shortened draft misses the problems the missing sections would show (for example, the base and the intervention changing together relative to the previous row, so the variables are not separated).
- Analyses and re-aggregations without training also get a short design document first: purpose, inputs (existing files used), metrics and how intervals are computed, gates fixed before results (how each outcome will be read), and what will not change. Write the result document in the order gate passed or not → result table → reading for the researcher → next move.

## 2. Scientific validity review
Once the design is finalized and before writing code, discuss separately "is this design scientifically sound?". Even with correct equations, if hypothesis and measurement are misaligned the result cannot be interpreted. The items below are independent checks; record any that are hit in the design document's review section.

- **Hypothesis–intervention link**: Check that the intervention touches only the hypothesized cause. If it also touches other causes, the result cannot tell what had the effect.
- **Premise check**: Write down the premises the design relies on (e.g., "the model playing the answer role gets this case right", "this signal carries information"), and check first, after finalization, the premises that can be checked without training.
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
- Ask about unclear words (a term, what an operation does, what unit a loss matches on) as they are, and the AI answers with numerical examples. E.g., "If cat is 0.70, dog 0.25, other 0.05, the prediction is cat, and dog 0.25 is the remaining second-place probability." Record the aligned explanation as in 1.2.

### 3.1 Order for choosing a loss
State the purpose in words, lay the candidates out beyond the usual families and compare them with evidence; the final choice is the researcher's.
1. **State the purpose in words.** Write in one sentence what the loss should make match what.
2. **Lay out candidates by family.** Show not just the common three (KL, MSE, JS) but other families achieving the same purpose (contrastive, noise-robust losses, etc.), and explain each one's property in one plain line. E.g., "KL follows strongly even when the target is wrong", "Huber pulls less hard when the difference is large".
3. **Check whether there is something better.** Find papers comparing losses head-to-head under the same conditions and show the numbers. Another AI's consultation is evidence, not a decision.
4. **The AI recommends one and attaches one comparison row; the researcher chooses.**
5. **When asked about expectations**, estimate with evidence, and correct the estimate if the evidence is weak.

### 3.2 What the AI checks on the researcher's behalf
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
For each target, the way to fix it and the condition under which the runner refuses to start.

| Target | How to fix | Refuse to start when |
| --- | --- | --- |
| Code | Record the commit a run uses and run from a fixed copy of that commit | Tracked files have uncommitted changes |
| Software environment | Make one lock file of package list, versions, driver, and GPU name, and compare hashes | Lock-file hash differs |
| Data | Make a list (manifest) of path, size, and hash of every file a run reads. Check the split lists every run; check full hashes before a campaign starts and after data changes | Hash or file count of the split lists differs |
| Configuration | Write in one format (e.g., YAML) with inheritance; every key in the resolved final configuration has a value. No defaults inside the code | Unknown key, missing key, change to a protected key |
| Run arguments | The only things changeable at run time are seed (within a fixed list), GPU number, and run name | Other values changed via arguments |
| Run folder | Do not overwrite an existing folder | Folder already exists |

### 4.2 Randomness and determinism
Fix random streams and GPU computation together so the same configuration gives the same result, and measure the spread that remains after fixing to use as a judgment criterion. Fixing removes random difference from the difference between rows; the measured spread is the criterion for whether that difference is real.

Split named random streams from one seed (data order, data transforms, sample selection, per feature), and fix the data loader's worker seed and generator. Turning on one feature does not change another feature's random order, so random difference drops out of the difference between two rows.

Reproducibility also needs deterministic GPU computation. One seed switch fixes every random stream (language, numerical library, and framework, CPU and GPU) and turns on deterministic kernels at the same time (kernel autotuning off, a fixed matrix-library workspace, the framework's deterministic mode). With nondeterministic kernels, tiny differences in summation order grow over a long training run, and two runs of the same configuration can differ by more than the decision line. For an op with no deterministic kernel, use warning mode and write down what that op changes (only a logged value, or the gradients too). After turning it on, confirm reproduction by checking that the parameters of two runs trained a few steps from the same seed are bitwise equal, and by comparing two full trainings of the same configuration.

Even when deterministic, spread between rows remains (one module changes the order of operations and the consumption of random numbers). Run the baseline configuration several times early in development (e.g., three times) to measure its mean and spread, and call a row different only when it falls outside "baseline mean ± spread". Record a difference inside the band as "cannot be told apart" (when to run several seeds is in 7.1), and write the measured spread in the result document as the reference for interpretation. The sources of spread are not just one seed but initialization, data order, augmentation, data split, and hyperparameter search. Compare rows during development with the same seed; in the final comparison, randomize these sources together and use several splits where possible (Bouthillier et al. 2021). Varying only one source makes the spread look smaller.

- After changing a global setting that applies to every row, such as deterministic mode, first measure speed and memory with a short run of the baseline configuration, and only then launch the new module row. If both change together, whether the slowdown came from the module or the setting cannot be separated.
- For parts that vary between runs, such as bf16 and GPU, write that fact and its size in the result document.

### 4.3 Run records and runner checks
Keep in the run folder everything about what each run ran with and how, and have the runner check conditions before starting. Failures and re-run results are kept, not deleted or overwritten, and when continuing on another machine, confirm reproduction first.
- Keep in the run folder the resolved configuration, provenance record (commit, environment hash, data hash, configuration hash, GPU, start and end times), training log, metric records, cost records, checkpoints, and result files.
- Before starting, the runner checks that tests pass (at that commit), the working tree is clean, environment and data checks pass, configuration validates, and the GPU is free.
- Record failures, omissions, and non-evaluations as they are in a ledger (failure record file) and the corresponding document. Record a cell whose external API run failed as a failure; do not fill it with another model. Check artifacts' integrity by hash.
- Write re-scored or re-run results to a new folder; do not overwrite old results. Do not write the ladder table by hand; build it by collecting result files from a list of configuration paths and runs per row.
- For paid runs, document the decision to run and the cost basis before results, then run (cost calculation in 05 §5).

When adding seeds or rows on another machine, check the transferred material against the original by file count, bytes, and hash, and re-measure one existing value with the same code to confirm it matches (reproduction gate) before writing new values. Write in the result document that the machine differed. If the samples drawn differ per seed, check before training that the auxiliary inputs attached to those samples (precomputed boxes, feature caches, etc.) cover the new samples. Fill what is missing with the same code and the same configuration, do not regenerate existing values, and add that handling to the design document before results.

## 5. Fairness setup
How to fix comparison conditions before the experiment so that comparison results reflect only the difference between methods. Resources and evaluation are matched across all methods, and what to count and how to combine it is set before results. The practices below rest on the following sources on comparison fairness.

| Practice | Where in this document | Source |
| --- | --- | --- |
| Run comparison methods with the same implementation, base, and tuning budget | 5.4 | Melis et al., ICLR 2018 · Oliver et al., NeurIPS 2018 · Musgrave et al., ECCV 2020 · Henderson et al., AAAI 2018 |
| Keep the validation set at a realistically usable size | 5.2 | Oliver et al., NeurIPS 2018 |
| Look at sources of spread beyond the seed | 4.2 | Bouthillier et al., MLSys 2021 |
| Use intervals and robust aggregates with few runs | 5.6, 9.2 | Agarwal et al., NeurIPS 2021 · Henderson et al., AAAI 2018 |
| Report the tuning budget together with validation performance | 5.7 | Dodge et al., EMNLP-IJCNLP 2019 |
| Check leakage by type | Ch. 10 | Kapoor & Narayanan, Patterns 2023 |
| Register before results, and state deviations from the plan and exploratory results separately | Ch. 10, 00 principle 5 | Nosek et al., PNAS 2018 |

### 5.1 Protected keys
Values that decide the comparison are set in one place only, the protocol configuration, and every method is evaluated with the same values and the same evaluator.
- Keep split, ground truth, number of updates, batch, learning-rate schedule, evaluation method, and seed only in the protocol configuration. If a method configuration changes these values, the validator refuses.
- Comparison methods use the same protocol and the same evaluator.
- Evaluate all fixed metrics at once at a fixed point (e.g., last epoch). Do not keep a separate path that re-scores a metric.

### 5.2 Resources and devices
Resources are matched across all methods; method-specific devices are not. State in the result document what was not matched and the costs that differ per method.

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
- Keep the validation set used to choose values at a realistically usable size. For example, in a low-label setting, do not choose values with a validation set larger than the training labels. Values chosen on a large validation set do not reproduce under real conditions.

### 5.3 Matching the training budget
The training budget is matched on the new method's measured step count, not on the baseline's documentation. Set it in the order below and check the log after the run.
1. Set the target number of updates T = steps per epoch measured in the new method's original configuration × number of epochs. Do not use the baseline's documented number of epochs as the reference.
2. Match the baseline's batch to the new method's, measure its steps per epoch, and set its number of epochs = T ÷ that value. Do not compute steps by hand (documented assumptions and measurements sometimes differ).
3. State both the number of epochs and the maximum step cap so the learning-rate schedule runs to the end. Using only the cap truncates the schedule.
4. After the run, check in the log the batch, steps per epoch, total updates, whether the cap was reached, and the code commit.

### 5.4 Conditions of comparison groups
Rules for making sure comparison methods are trained and evaluated under the same conditions as our method.
- Every experiment must be comparable to prior work. Own setups without a comparison target are banned by default.
- Training our method on any data is not the problem; what must hold is that trainable comparison methods are also trained and evaluated with the same data, split, and selection rules.
- Before calling a comparison method "the same recipe" or putting it in a table, check its input conditions (cropping, marks, prompts, data counts, seeds) cell by cell against our method in the run ledger. Fix and rerun cells that differ, or state the difference in the manuscript. If the comparison methods were frozen when our method's recipe changed, record the resulting condition difference right away. Found late, the fixes spread across the whole manuscript.
- Include cells where comparison methods are also given our method's device, to separate whether the gain comes from the device or the model.
- Run comparison methods with the same implementation, base, augmentation, and optimizer as our method, and do hyperparameter search the same way with the same number of trials. Do not carry over values tuned on another dataset as they are. An under-tuned baseline inflates the gain.
- Do not change run settings such as batch within an experiment. Changes are made only in a new experiment, after writing an equivalence check criterion before results.

### 5.5 Checking the remaining gap before fixing the base
A method for measuring, before fixing the base (baseline method and training conditions) on which a method will be built, whether there is room for the method's effect to show under those conditions. If the base conditions are strong and already close to the upper bound, any method's difference gets buried in run-to-run variation, and this is discovered only after much development.
1. Measure three scores under the same conditions: training on the labelled data only (lower bound), the base method, and training with all labels (upper bound).
2. Compute the remaining gap (upper bound − base) and the filled ratio ((base − lower bound) ÷ (upper bound − lower bound)).
3. Write them next to the same three scores from prior papers of the same family. If both the lower and upper bounds are higher than the prior work's, the training conditions themselves differ, so first reproduce the prior conditions with the original code to separate the cause of the difference.
4. If the remaining gap is not sufficiently larger than the variation between base runs, reset the conditions (data ratio, training conditions, comparison protocol) before fixing the base.
- When reproducing prior numbers, use the original code and original schedule as they are, and change nothing except execution links such as paths and file names. Record in the result document how defects of the original code were worked around.
- When the conditions change, do not carry over numbers and adoption judgments from the earlier conditions (01 §6.1).

### 5.6 Samples, seeds, and aggregation
Rules for fixing what to count and how to combine it before results, so that only favorable values cannot be picked.
- Fix sample groups, seeds, and splits before results, and do not pick only favorable ones. Do not rewrite non-evaluated items as "excluded". Do not loosen frozen thresholds or caps to increase samples. If they must change, change them uniformly across everything and only before results.
- Fix one rule for combining results across seeds (e.g., average per-sample probabilities, then compute the metric) and apply it identically to comparison methods.
- Match the number of seeds of comparison methods to our method's. Comparison methods having fewer seeds is a lack of preparation, so fill it with experiments; until then, state in the text that the comparison paired seeds with each other.
- When several runs were made (timing in 7.1), do not show only the mean: give stratified bootstrap intervals and robust aggregates (IQM, etc.) together, and keep the per-run raw data. Improvement can also be judged by the paired win rate P(A>B) and its interval, and with many comparisons, correct for multiple comparisons. With few runs, a single point estimate easily reverses the conclusion.
- Compute paired intervals by bootstrap paired on the evaluation unit (scene, photo, etc.), and state the unit and the number of resamples.
- Compute paired intervals used for claims with the same aggregation as the values in the table (pooled, group mean). If the two aggregations reach different conclusions, record both and call it a borderline result; the researcher decides whether to use the stronger wording.

### 5.7 Reporting results
What to state alongside when reporting comparison results as numbers.
- Report sample counts (per group, case, and split, with definitions) side by side with prior work's counts. State the denominator of success rates, and report both the per-group equally weighted value and the pooled total.
- For each result, write the tuning budget (search range, number of trials, selection criterion) and the corresponding validation performance. Do not use comparisons with different budgets as grounds for "outperforms".
- If the benchmark's definition (included items, etc.) changes, keep models and thresholds as they are and recompute every reported number under the new definition.

## 6. Writing and managing code
Rules for writing, testing, moving, and cleaning up research code. Research code must above all not produce wrong results that look plausible, so the principles are turned into stop conditions and tests, and verified code is not changed lightly. Committing and pushing are in 05 §6.

### 6.1 Scientific coding principles
Scientific code serves truth, not users, and the worst outcome is a plausible-looking wrong result.
- Research code is written with the Scientific Coding skill ([scientific-coding-skill](https://github.com/cemde/scientific-coding-skill), MIT License) installed as a plugin; the agent reads it on its own when writing research code. Its core: understand the experiment first (parts shared across conditions use the same code; only the diverging parts branch), stop and hand off when judgment is needed, fail loudly (do not fill experiment values with broad exception handling, fallback values, or `get(key, default)`), no hidden defaults for values that change results, correctness over speed, preserve raw data, verify with actual values, do not hide intervals or denominators, existing tools first, and do not restructure verified code without being asked.
- For workers that cannot read the skill, put four lines at the top of the task spec: "fail loudly, no hidden defaults, record reproducibility, preserve verified code". In repository instructions, do not copy the principles verbatim; keep only the four lines and the source.
- When moving a feature or extracting it into a shared file, take the pre-change result as a reference and confirm the same inputs and seed give the same losses and outputs before moving on.
- Turn principles into stop conditions in code. Check scripts stop without producing results when claims and numbers disagree or when unintended changes appear. When renaming, keep internal keys and change only display names.

### 6.2 Structure
Split code by feature so that turning a new feature on or off does not touch the core training code.
- One module = one file + one switch. Keep core training code fixed; put a new feature in its own file as a registered class and turn it on via configuration. Do not let features pile up in one file.
- Split folders by pipeline stage (data → training → judgment → evaluation, etc.), and mirror the same stage folder structure for tests. Collect run shell scripts in one folder.
- Extract computations shared by several modules (paths, records, shared ops) into one shared file.

### 6.3 Tests
Tests check that equations and code agree, that a new module is attached as intended, and that a pass verdict can be trusted. A test becomes the condition for the next step only when it runs in the real environment and is judged by its exit status.
- For each equation in the design, have a unit test comparing a hand calculation with the code output.
- For each new module, test "off equals the existing path", "new parameters change after one step", "the training signal does not reach where it must not", and "the configuration differs from the previous row by exactly one key".
- When adding a loss term to an existing training loop, trace the variable to the end to check whether it is reassigned later, and test that the new term actually produces gradients (the gradient difference at the same step with it off and on, or nonzero parameter gradients from a backward on that term alone). A value appearing in the log file is not evidence that it entered training.
- Pass the full test suite in the environment where it will actually run (the server). Record the cause of tests that fail due to environment differences.
- Block data leakage in code. E.g., stop immediately if test data appears in training or validation paths.
- Record whether the test or the code was wrong. If the test was at fault, say so and fix it.
- When passing verification is the condition for the next step (commit, training, report), check it from the verification's own exit status and pass/fail counts, not from shortened output or a summary. A command that trims the output changes the exit status to that of the last command and lets a failure read as a pass.
- Size checks to the risk. Do not re-measure facts already shown by a measurement. If the official code is used as is and the only changes are a few lines guarded by switches, confirm equivalence by reviewing the changed lines and a short smoke, without a separate training run. Before launching a new check run, write in one line "what does this result change?", and if it changes nothing, do not launch it.

### 6.4 Moving and running code
Code is written in one place and sent to the server only by a fixed path; when launching several runs or scaling up, weigh dependencies and cost first.
- Write code in one place (the working repository) and send it to the run server only through a fixed sync path (bundle transfer, etc.). Move the tags the scripts use along with it. Do not move code by pasting it into a terminal.
- Run from a fixed copy per commit, and do not touch code that a running run reads.
- Who takes a short code change follows 05 §1.
- When launching several runs at once, bundle only those that do not depend on each other's verdict (independent conditions, folds, seeds). Launch a run whose content is set by an earlier run's verdict after that verdict. Launched together, a change that will be rejected leaks into the later run.
- Before moving from a small scale to a large one, estimate per processing unit how time and memory grow with scale, and check the estimate once against progress during the run (amount processed, memory). If it deviates widely, stop, fix, confirm the small scale gives the same result, and run again. An estimate scaled only by data size misses the per-unit cost and can be off several-fold.

### 6.5 Cleanup
When closing a row that was not adopted, move its module file to an archive folder, remove its hooks from the training loop, and confirm with the baseline configuration that the first-step loss for the same seed equals the loss before cleanup. Tag the commit just before cleanup, and reproduce old runs from the commit in their run records. If rows are not cleared away when closed, unused modules and hooks pile up in the main code.
- Do not delete, move, or commit files the researcher is in the middle of editing.
- When moving or renaming, fix references in documents and code together, and check there are no broken links. Do not put result data (output folders) in git. Track the manuscript in git but exclude build artifacts.

### 6.6 Understanding code
- Keep a walkthrough document that follows one data item from input to result by file and line number, so the researcher can follow the code.
- The walkthrough pairs paper sections with code locations, and notes any place where the paper's description and the code differ.

## 7. Development and execution
The assembly-style development procedure of building up the model by changing one thing at a time, and the method of learning the design by drawing it by hand while training runs. Based on common practices that major vision research followed when building models (reproduce a standard baseline and freeze it, change one factor at a time, a ladder-table row per change, screen cheaply then confirm at scale, adopt only gains larger than seed-to-seed variation, find the cause of a failed step before dropping it, attach new parts as their own files and configuration) ([ConvNeXt](https://arxiv.org/abs/2201.03545), [DINOv2](https://arxiv.org/abs/2304.07193), [MAE](https://arxiv.org/abs/2111.06377), [RegNet](https://arxiv.org/abs/2003.13678), [Deep Learning Tuning Playbook](https://github.com/google-research/tuning_playbook), [Karpathy, "A Recipe for Training Neural Networks"](https://karpathy.github.io/2019/04/25/recipe/), [Detectron2](https://github.com/facebookresearch/detectron2), [MMSegmentation](https://github.com/open-mmlab/mmsegmentation)).

### 7.1 Development order
Assembly-style development goes through the steps below in order, moving to the next step only after passing each step's condition. Each row changes only one thing, and its result is kept as one ladder-table row.

| Step | What to do | Condition to move on |
| --- | --- | --- |
| ① Borrow | First find usable parts in prior papers' code and existing code, and record source, license, and changes | What is borrowed and what is new are separated |
| ② Design | The dialogue and review of §1–§3, the environment and fairness setup of §4–§5 | The researcher finalizes the design |
| ③ Code | Write code and tests per §6 | With the switch off, results equal the previous row; the configuration differs from the previous row by exactly one key |
| ③-1 External review | After the design and code (tests included) are done and before launching training, get a read-only independent review from one other strong model. Give it the design document, the code paths, and 2–4 questions whose answers would change what you do, and do not hand the reviewer your hypothesis as a conclusion. Check each point against the code, and record in a table in the design document's review section what to fix and which points were wrong | The points are addressed and the tests pass again |
| ④ Smoke | Run briefly to check that new parameters leave their initial values, the new loss actually produces gradients (6.3) and is on the same order of magnitude as other losses, collapse indicators are normal, and step time and memory | All of the above are normal |
| ⑤ Training | If smoke succeeds, train immediately without waiting for approval, and give the researcher a one-page sheet for hand drawing (7.2). Report the start only after seeing the runner's start record | On failure: analyze cause → fix → smoke again |
- In the ladder table, record per row the one change, extra cost, metrics, difference from the previous row, and adoption decision. If several changes are bundled in one idea, split them into steps and register each step as a row. Changing them all at once means separating the cause only after the score drops.
- Changes outside the design (new direction, value tuning, fixes) are decided by the researcher.
- Screen candidates cheaply first. Make the first call with a short schedule, a small setup, or a single seed, and confirm only the surviving rows at full scale. Keep screened-out rows in the ladder table as they are, and do not use first-call results as manuscript numbers. But when the screening threshold is smaller than the spread of re-running the same setup, a single-seed screen is decided by luck; if resources allow (memory saving or mixed precision to fit several runs on one device), agree with the researcher to skip the screen and run several seeds together from the start, judged once. Use a short-schedule screen only when early scores have been confirmed to predict final scores.

The researcher decides when to run multiple seeds. If the researcher has not decided, run them after the model configuration is fixed, on the fixed configuration and its comparison row together, to measure the spread. So during development, even when a row passes its registered criterion, do not run more seeds; move to the next row. The AI does not first propose or queue extra seeds even for a row that rose, does not run them to rescue a row that fell or to measure the spread in advance, and does not add seed procedures the researcher did not state when recording a judgment rule. Single-seed judgment during development uses the baseline spread of 4.2.

### 7.2 Drawing the overview by hand
While training runs, the researcher redraws the finalized design by adding the new module onto the overview from 1.5. The design has to be in the researcher's head to be able to say the next move on their own after a failure. Drawing follows the order below.
1. Draw right after the design is finalized and training starts, before results. Drawing after seeing results mixes in interpretations fitted to the results.
2. Draw the flow from input to output, the place of the new module (at which layer it takes what and outputs what, and how sizes change), the position of the loss and which side plays the answer role, which parts the training signal changes and which it does not, and one line on what the loss does along with the traps from 3.2.
3. When launching training, the AI gives the things to draw on one page, compares the researcher's drawing and questions with the design document and code, and points out mismatches.
4. When results come in, mark on the drawing where it differed from expectations, and choose from the drawing the place to change in the next row. Discussion of failure causes uses this drawing as the reference.

## 8. In-training measurement
How to measure and keep, without omission, everything measurable inside an actual training run. In-training measurement has one use only: explaining why the result came out as it did. Adoption is decided by the final metrics; in-training measurement is used to reveal the reason.

### 8.1 Measurement principles
Measure without omission, with items fixed before the experiment, and without changing training results.
- Measure everything measurable, and turn on the same items for every experiment. Record now the values that might be needed later so finished experiments are not retrained, and separate causes by comparing rows.
- Fix the measurement items before the experiment, and when building a new module, build that module's mechanism metrics with it.
- Keep measurement as a record-only module, and test that turning it on and off gives the same training results. Save and restore state so the randomness used by measurement does not change training randomness. If measurement is costly, increase the interval but do not drop items.

### 8.2 Measurement items
The items turned on for every experiment and when they are recorded.

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
| Per-sample results | Prediction and confidence for every evaluation sample (for segmentation: per-image confusion counts, prediction map, confidence map, reduced class probabilities), for every model worth evaluating (original, moving average, auxiliary heads) | At the last and intermediate checkpoints |
| Early state | If results split early in training, a checkpoint every early epoch (moving-average model, optimizer and random state included) | Every early epoch |

### 8.3 How to record
Keep records machine-readable so a script builds the result document, and fill missing values from checkpoints instead of retraining.
- Keep every value in the run folder in a machine-readable format (one record per line), without overwriting. Keep it separate from the human-readable log.
- Fix the record format (fields and meanings) in a schema document with a version; when the format changes, issue a new version, and reading code checks the version.
- Do not delete records of failed or interrupted runs; record why they stopped.
- A script builds the draft result document from these records (run information, judgment, per-class differences, per-bin changes, loss shares, diagnostic trends); humans only write the interpretation.
- Do not cut records to save storage. The final evaluation keeps per-sample results, not only metrics, so later analyses (paired bootstrap, splits by sample or region, confidence, comparisons between models) read only that file without re-scoring. Before producing a new value, a later analysis script first checks that it reproduces the stored headline numbers (e.g., the confusion-matrix sum) and records whether it did in an index.
- If a value missing from a finished experiment is needed, measure it from the saved checkpoints instead of retraining. Also when a recording device such as diagnostics or seed fixing is newly added, do not rerun a setting that already has results; turn it on from the runs still to come. When rerunning training steps from a checkpoint, compare the first-step loss magnitude with the original experiment to confirm the internal state is right.

### 8.4 How to read the records
After results come in, explain "why it came out that way" with the questions below.

| Question | Records to look at |
| --- | --- |
| Did what the method aimed to change actually change? | Mechanism metrics |
| Did the new loss actually act on training? | Actual weighted contribution and share, gradient norm |
| When did they diverge? | Per-bin performance differences, loss trajectories |
| Where was it gained and where lost? | Per-class metrics, error locations, per-stage values |
| Was training healthy? | Gradient-clipping rate, NaN/Inf, skew in prediction distribution, quality of self-made answers |
- When using the error share of a region or group as evidence, write it next to that region's base share (area, sample count), and say "it errs more there" only when the density (errors ÷ base) differs. An error share equal to the base share is a number that shows nothing (the same applies to the diagnosis in §9).
- Use the explanation as the basis for diagnosis and choosing the next row in §9.

## 9. Judgment and next row
Rules for deciding adoption, holding, or adjustment after results come in, and choosing the next row. 9.1–9.3 judge trained rows, 9.4 covers measurement before training, and 9.5 covers measurement after a row rises.

### 9.1 Diagnosing a row that did not improve
Before discarding a row that did not improve, diagnose the cause. Look in the order implementation check → missing standard techniques (sharpening, normalization, weight schedules, a weight that matches a new loss's scale to the other losses, etc.) → in-training measurement (8.4) and checkpoint analysis. A diagnostic report starts with one line each on the implementation check and on missing standard techniques, and only then moves to measurement analysis. When a measurement stands out it is easy to skip the first two steps, and then an implementation error or a plain scale imbalance is misread as a problem of mechanism.

Choices after diagnosis follow the rules below.
- The researcher chooses the fix. Do not automatically run pre-decided fix candidates.
- When checking the structure, use prior-work standard values; tune values such as weights and temperatures only after the structure has shown an effect.

### 9.2 Adoption and the judging score
Adopt only by the threshold and judging score fixed before results. The threshold exists to pick good rows; the rule only guards against reading noise as gain. Changing the criterion or score to fit results after seeing them picks only the side that came out well, so change the criterion only before seeing that row's results (including seeds not yet run); after seeing them, change it from the next row on. If it was changed after seeing part of the same row's results (earlier seeds), record that fact and whether the row would also have passed the original criterion in the judgment record.
- Fix the adoption threshold before results in a pre-registration document.
- When asking to keep a rule, explain it with the measured noise size the rule guards against (re-running the same setup, seed spread), and, if results are not yet in, give the researcher the option to change the criterion as choices (keep, relax, adopt by the researcher's judgment). A rule that sounds like form detached from its purpose leaves the researcher without grounds to decide.
- For a component whose targeted failure appears only in some seeds (a device that rescues bad branches, for example), a gain near 0 on already-good seeds is normal, so before results consider judging by the mean paired difference instead of a condition such as "> 0 on every seed".
- During development, judge a single-seed row by the baseline spread of 4.2.
- For final adoption with several seeds: for a row that adds something, require the paired-interval lower bound > 0 and a difference at least twice the single-seed spread; for a row that removes something (simplification), require the paired-interval lower bound to exceed the pre-set tolerated loss (−margin). Measure the spread by actually running the same configuration with several seeds. Label results whose lower bound across several seeds does not exceed 0 as "1-seed result".
- When setting a decision line as a ratio of shares, measure each bin's base share (area, sample count) before registration and check that the line can be crossed mathematically (1 ÷ base share ≥ line). If it cannot, set the line on another scale such as a per-cell rate. A line that cannot be crossed returns "absent" regardless of the result and cannot test the hypothesis.
- When choosing the judging score, check the field's convention first. A common convention is to judge on one validation split and only report the test split, measured with the same checkpoint. A two-split average may also be used if fixed before results, but if the researcher chooses the convention, re-pin to it.
- If judging splits disagree in direction for a row run once (e.g., validation down, test up), judge that row only by the registered score, and pin a new judging score for later rows before their results. The purpose is not to read only the side that came out well (the cherry-picking ban of 00 principle 5); do not re-explain it as "protecting the score by never looking at the test split".
- If the paired interval of a new result includes 0, lower the strength of the claim (e.g., "outperforms" → "comparable"). If a result contradicts a previous claim, withdraw the claim.

### 9.3 Choosing the next row
Choose the next row so it follows from the measured failure and the overview the researcher drew; if adding things keeps failing, extract rules first.
- Choose the next move after a failed row on the overview the researcher drew (7.2).
- When lifting an existing constraint, lift it only as a component of the method tied to a measured failure, keep a separate ablation row, and give the baseline the same resources.
- If several rows added one at a time on the same base fail to improve in a row, stop adding and extract rules from those rows' results into a table (what raises the score, what lowers it). Write the next module with those rules as conditions, and design only candidates that follow directly from the problem statement. Each row is still one change, but candidates are chosen not as "things to try adding" but as "things that aim at the problem while keeping the rules".
- Keep rows that were tried but not adopted in the ladder table with their results as they are. Do not put them in the paper (00 principle 16, 04 §5.2).

### 9.4 Pre-measurement without training is for stopping only
Pre-measurement without training (attaching a device to a trained model and running it forward once) cannot see the effect of training, so it is not used as a reason to proceed, only as a reason to stop.
- Its only use is checking facts the design relies on: does the targeted phenomenon exist (premise), does the signal the new device will use contain information (information), and even working perfectly, is the share it can fix large enough (upper bound). Do not use it for choosing candidates, setting values, or predicting gains. Do it only when the design is finalized, the premise is uncertain, and training is expensive; otherwise go straight to smoke and training.
- What to look at is not the size of the number but present or absent. If "absent", close it without training; "present" only qualifies it for a training try. Write in the first line of the report and the registration: "passing makes it worth trying (necessary condition); whether it solves the problem is known only from training; on failure this option is dropped".
- Do not decide present or absent from one number. Report together (1) the separability (e.g., AUROC), (2) at the point where the signal is used (per threshold, or the replacement rule itself) the number fixed and the number broken and the resulting change in the metric, and (3) values per stratum such as class or size. With several sources, judge each source separately, and do not use the measurement to choose between sources.
- Before results, check whether the measurement can in principle move the judgment. For hyperparameters of a borrowed method, check that the units and range of the quantity they act on match the original paper (normalizing the input changes them), and compute the maximum effect first. If the result is exactly 0, suspect the form of the measurement before concluding.
- If the target set was chosen by that model's outputs (wrong answers, confidence), check whether a metric measured with the same model's representations is determined by the selection alone (circularity), and include reference points (another model, a random set, a label-using upper bound). If circular, "absent" is not evidence. When one such flaw is found, recheck at once the other "absent / not" judgments in the same batch of work, and the places where "not" was said in words without measurement.
- Closing as "absent" closes only the one form the measurement imitated. Keep axes of a different form (replacement versus removal, frozen versus jointly trained, one-shot versus feedback, per-cell versus per-image input) open by writing them in the result document as "outside this measurement"; if the same form fails several times, close only that form and ask the researcher whether to test the remaining axes as training rows.
- If the measurement said "present" but training stays low, do not conclude it was a measurement error or a single code mistake. Both can be right while the link between them breaks (the signal fades during training, the source comes to resemble the teacher, changed answers harden through the teacher, side effects outside the measured region, the loss cannot use the information, noise). Check implementation → missing standard techniques → the broken link, and for this register in the mechanism measurements that quantities measured beforehand are also logged during training with the same definitions.

### 9.5 Mechanism measurement of a row that rose
When a row passes the judgment criterion, before adding the next row, measure, as the next thing after the score, "did the targeted problem actually shrink?", using the checkpoints of the row that rose and the row directly below it (the base). No retraining.
- Scores also rise from regularization, compute, training length, and chance, so the problem → component correspondence holds only when the targeted errors and the internal state change together. The remaining share becomes the next component's target, and this measurement grounds the paper's analysis section and ablations. Measured later in bulk, the shares cannot be separated between rows that have already piled up.
- Write what to measure in the design document before results, as "what to measure if it rises" (02 §2.1 ⑥). A measurement chosen after seeing results fits its interpretation to the results.
- Measure the two rows side by side in the same run, with the same tools, definitions, and data lists as when the problem was first measured (02 §2.1 ②), using existing measurement tools first. Do not stop at one number; report the count of targeted errors, the cause metric, and per-stratum values together.

| Result | How to read it and the next move |
| --- | --- |
| Targeted errors and the cause metric shrink together, and a share remains | Design the next component aimed at the remaining share, and use these values as that component's judgment baseline and smoke-check items |
| Errors shrank but the cause metric is unchanged | It was fixed by another path. Propose to the researcher a measurement or ablation row that separates that path |
| Only the score rose; errors and cause are unchanged | The gain came from elsewhere. Withdraw the problem → component claim and propose a control row that separates the source of the gain (compute, regularization, etc.). The row stays in the ladder table as is |
| Losses appear where nothing was targeted | Write the location of the side effect (with the base share and density of 8.4) as a constraint for the next design |
- The next component's design, control rows, and replacing the base are decided by the researcher after seeing these results.

## 10. Evaluation data and labels
How to handle evaluation data and human labels so that criteria or choices are not changed after seeing results. Test data and code are sealed and looked at only once, and deviations from the plan and leakage-check results are stated in every report. Human labels have their self-reproducibility measured, and automatic labels are not used as ground truth before human approval.

- Split test data with a fixed seed and seal it; first verify the evaluation process on the rehearsal half, then look at the main test only once.
- Run the final test by checking out the frozen commit into a separate workspace, and check the code hash before running.
- Freezing and sealing are safeguards against looking at results and picking only good values (cherry-picking under 00 principle 5). They do not block analyses that re-aggregate already saved test runs and predictions with later code (new metrics, other groupings, reweighting). If the gate blocks even this, keep a separate entry point that "only reads what is saved", and do not do new runs, re-scoring, or threshold changes through that path.
- State deviations from the pre-results plan (including anything chosen differently from the pre-set rules): what was changed and why, with numbers; mark results that came from exploration separately from the confirmatory results registered before results.
- Attach a leakage checklist to each report, writing for each item "none" and its basis in one line: incomplete separation of training and evaluation (no test set, preprocessing before splitting, feature selection on the test set, duplicate samples), features not available at prediction time, test distribution different from the distribution the claim is about (temporal leakage, non-independence, sampling bias).
- Do human evaluation first with machine scores sealed; if a flaw is found, preserve that round as void without opening the scores.
- Choose values on the validation split and write "validation-selected" in the result document. Values chosen on the test split create optimistic gains. Keep external models trained on the target labels only as reference rows.
- Measure labels' self-reproducibility (agreement rate, κ) by relabeling after a time gap with the order reshuffled. State in the paper any label procedure that changed from the plan.
- Inspect benchmark items visually with model predictions hidden, remove whole categories as the unit, and if the decision was made after results, record how.
- Automatic detection results are not ground truth before human approval, and uncertain cases are not confirmed as negative. Set thresholds for automatic labels using training labels only, and confirm them by agreement with validation labels.
- Choosing qualitative examples to show in figures follows 06 §2.
