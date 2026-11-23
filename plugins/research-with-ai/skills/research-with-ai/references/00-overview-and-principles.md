# Research with AI — Overview and Principles

| Item | Content |
| --- | --- |
| Purpose | Collects the principles common to every stage of using an AI agent as a research collaborator, the research flow, and which reference section to read in each situation |
| When used | Choosing a research topic, checking prior work, designing experiments, adding modules and training, judging results, running servers, writing and verifying manuscripts, documenting research |
| Structure | The entry point of the skill. Always read only §1 (how to read) and §2 (principles) first, and read the rest when needed. §1 how to read, §2 common principles and approval scope, §3 research flow (stages, movement criteria, pivots), §4 operating principles, §5 signals to stop and check. Details within each stage are in reference documents 01–08; installation, connection and request patterns are in the "Installation and usage guide" |

## 1. How to read
Do not read the whole document every time; read only the sections the current work needs, when it needs them (read on demand). For every piece of research work, read this §1 and §2 (principles) first, then find the row in the table below that matches the current work and read its sections. Find a section by its heading (`## n.`, `### n.m`) and read up to the next heading of the same level. When the work changes or a judgment not in the table is needed, read the relevant section then.
- Documents: [01](01-tools-and-rules.md) Tools and rules · [02](02-topic-question-prior-work.md) Topic, question, prior work, gap · [03](03-experiment-and-model.md) Experiment and model development · [04](04-writing.md) Paper writing · [05](05-operations.md) Operations · [06](06-critique-and-review.md) Critique, manuscript verification, external documents · [07](07-ai-errors.md) AI error types and responses · [08](08-judgment-and-evaluation.md) Result judgment and evaluation data

| Current work | Sections to read |
| --- | --- |
| Starting a session or resuming interrupted work | 00 §4.1, 01 §5.3 |
| Starting a new study or repository, bringing an archived project back | 00 §3, 01 §1–5 |
| Creating or editing instructions, memory, skills or hooks | 01 §3–4 |
| Creating a wiki, or recording results, decisions or corrections | 01 §5–6 |
| Editing method documents or leaving improvement candidates | 01 §7 |
| Choosing a topic | 02 §1 |
| Deriving a method from measured failures | 02 §2 |
| Setting questions, judgment rules and the task definition | 02 §3 |
| Surveying prior work | 02 §4 |
| Judging novelty, targets and alternatives | 02 §5 |
| Designing modules and losses | 03 §1–3 |
| Fixing the execution environment and reproducibility | 03 §4 |
| Setting comparison conditions and fairness, or choosing a base | 03 §5 |
| Choosing and reporting a hyperparameter value | 03 §5, 08 §2 |
| Writing and testing research code | 03 §6 |
| Launching a smoke or training, or adding a new row | 03 §7, 05 §1–2 |
| Setting measurements during training, or reading the records | 03 §8 |
| Judging results and choosing the next row | 08 §1.1–1.3 |
| Doing pre-measurement without training | 08 §1.4 |
| Measuring the mechanism of a row that improved | 08 §1.5 |
| Handling test data, labels and freezing | 08 §2 |
| Using workers or writing task briefs | 05 §1 |
| Handling long jobs, servers, GPUs and monitoring | 05 §2–4 |
| Re-scoring a trained model on another machine, or moving machines | 05 §3.4 |
| Handling secrets, paid APIs, commits and pushes | 05 §5–6 |
| Starting a manuscript, deciding the audience, claims and outline | 04 §1–2, 04 §6 |
| Deciding evaluation splits and results to report | 04 §5 |
| Writing or editing the manuscript's words, sentences, figures, tables and citations | 04 §3–4 |
| Using a comparative word such as "outperforms" in the manuscript | 06 §2 |
| Checking a finished manuscript against the venue, choosing the title and contribution sentences | 04 §7 |
| Running a mock review, checking whether the manuscript achieved its stated purpose, handling feedback and reviews | 06 §1 |
| Proofreading and verifying a manuscript, or checking submission requirements | 06 §2 |
| Repeating rounds of sentence and logic polishing | 06 §2.2 |
| Writing an external report or an AI-use disclosure | 06 §3 |
| Judging the research flow, stage transitions and direction changes | 00 §3 |
| Reporting or explaining to the researcher, or interpreting a request | 00 §4.3 |
| Naming terms, frameworks or tasks | 00 §4.3, 04 §2 |
| Using a theorem or proof produced by the AI | 07 §1.1, 02 §1 |
| AI output looks wrong, or the same mistake repeats | 00 §5, 07 (1 judgment and interpretation, 2 experiments and code, 3 manuscripts and tables, 4 data and visual reading, 5 communication and operations, 6 common responses) |

## 2. Basic principles
Principles that apply to every stage. When they conflict with a detailed procedure, these principles take precedence. The principles fall into three groups — judgment and decisions (1–4), experiments and judgment (5–12), recording and improvement (13–18) — followed by the boundary of what the AI may do alone (approval scope).

### 2.1 Judgment and decisions
The researcher decides; the AI prepares the explanations, candidates and grounds that decision needs. A decision taken without understanding, or a re-proposal of a direction already closed, wastes research time, so explanation and checking the records come before the decision.

1. **The researcher decides.** The AI gives explanations, candidates, a recommendation and the grounds; the researcher chooses. Matters that hinge on the researcher's value judgments (the venue's novelty bar, lineage with the researcher's own earlier work, evaluating the researcher's past work, assigning work to people, the next step given the researcher's goals) are not pre-empted or settled by the AI through a recommendation. Show similarities and binding constraints in a table and ask for the judgment as options; before using past work as an achievement, first ask how the researcher views that work; and propose assignments to people only when asked. If the AI makes these judgments on the researcher's behalf, promising directions get erased in advance, or records and instructions remain that differ from the researcher's own assessment. If the researcher delegates a decision, the AI investigates the grounds, decides, and records that the decision was delegated and why.
2. **Explanation first, decision later.** Do not take a decision while the researcher has not understood it. Attach a recommendation and reason to each option, and do not ask for several decisions at once.
3. **Speak to the researcher in plain words with numeric examples.** Do not use formulas or internal code names, and state decisions by their content, not their numbers (the number goes only in parentheses as a tag for looking it up, 01 §6.2). The AI does the formula calculations and checks, and reports the results in words.
4. **Check the records before proposing.** Before proposing, check the log, decision records and rejection list for directions already closed. State for each proposal the expected gain, the chance of adoption, and its role in the study. Read a closed record together with the conditions it was measured under (base model, protocol, data split, seed, checkpoint, judgment rule); if the conditions have changed, do not use it as evidence that the direction is "still closed" — say only that it was closed under those conditions, and let the researcher decide whether to reopen it. When an old result is used to block a new proposal, consider whether re-measuring under the current rules could reverse it, separating "failure" from "no gain seen under one condition", and first check that the blocking criterion fits the current goal (fixing an error or exploring performance). When rejecting an external review or the researcher's proposal, do not rely on memory either: find the definition that grounds the rejection (manuscript section, code, data table) and write its location in the reason for rejection. A rejection based on weak negative evidence or on memory closes a direction the researcher wants, or hides a real error.

### 2.2 Experiments and judgment
Principles that fix judgment criteria, comparison conditions and the order of work before results, so that results are not pulled toward expectations. If criteria change after results or several changes go in at once, no result can serve as evidence and the cause of a failure cannot be isolated.

5. **Fix judgment criteria before results.** Record splits, thresholds, evaluation targets and adoption rules in a document before results, and do not change them after seeing results.
   - What this principle prevents is **cherry-picking**: reporting only the good values among independent seeds, scenes or runs, or changing scenes, seeds or thresholds after seeing results to manufacture a number. Which metrics the manuscript defines, how, in which table, and how the tables are laid out may be chosen after seeing results (provided every run's values are used as they are and the definitions are stated in the manuscript). Do not stop the researcher by reading a presentation choice as "post-hoc manipulation". Changing the evaluation protocol after seeing results (e.g. scoring with the weight-averaged model instead of the student) is also not cherry-picking, provided it is applied to every row, seed and comparison method alike and the instructions and the registered original are amended to record it — what is prevented is picking whichever side favours each row. Do not cite "the risk that it looks that way" as a reason; judge by this criterion.
   - "Report results as they are, good or bad" means reporting **to the researcher**: when a result comes out, tell the researcher everything, unfavourable values included, and keep it in the result document. Whether it goes into the manuscript and in what sentence is decided by the researcher after seeing the result. Do not fix manuscript sentences in advance in a design document; if you write any, write them only as a proposal for the report to the researcher.
6. **Change one thing at a time.** Fix the baseline, add only one change per row, and measure under the same conditions. This principle concerns the number of changes within one row; when there are several resources (GPUs), running different rows at the same time is fine.
7. **When something fails, diagnose first.** Look for the cause in the order implementation check → missing standard techniques → checkpoint analysis; the researcher chooses the fix. Tune values only after the structure has shown an effect.
8. **Use pre-measurement without training only to stop.** Check whether the facts the design relies on (premise, information, upper bound) exist; if "absent", close the direction. "Present" is not a reason to proceed. Do not use it to pick candidates, set values or predict gains.
9. **Fix reproducibility and fairness before the experiment.** Fix code, environment, data, configuration and random state, and record them for every run. Match resources with the comparison methods but not their method-specific devices, and train the comparison methods on the same data and splits.
10. **During training, measure and keep everything measurable.** Record the actual contribution of each loss term, training state, performance, prediction distribution, mechanism, error locations, cost and checkpoints with the same items in every experiment. Use these records only to explain why a result came out as it did. **Do not obtain the same result twice:** before proposing a check run, a retraining or an extra measurement, write in one line which decision its result would change, and check down to the path whether a result with the same setting and the same data already exists. If it changes no decision or the result already exists, do not do it. Size checks to the risk (03 §6.3, 07 §2).
11. **When closing a direction, record the grounds and conditions.** There is no limit on how often the direction changes, and the researcher decides whether to move. The AI does not block the researcher's direction change with a count rule such as "you cannot move until N trained rows have accumulated". When closing, distinguish whether it was closed on trained rows or stopped on a "premise absent" result from measurement without training, and record under which conditions (base, data, judgment rule) the result was measured, so that it can be reopened when the conditions change.
12. **Keep the order of work.** Build the model configuration with one seed; multi-seed repeats, other datasets and additional comparisons come after the model is fixed. Large measures that change the character of the study are postponed to the next study or decided by the researcher.

### 2.3 Recording and improvement
Principles for recording results, decisions and lessons in the turn they appear, and for moving repeated instructions and mistakes into documents or mechanisms. If a record is late or missing, the next session repeats the same judgments and mistakes.

13. **Record in the turn where a result, decision or explanation appears.** Update one log line, the topic page and the status index of the project wiki (01 §5) in the same turn. Number each decision and keep it together with the researcher's words. Simple status checks are not recorded.
14. **Turn repeated instructions into mechanisms.** An instruction repeated twice or more becomes an instruction file, memory, skill or hook.
15. **Check AI output against the originals.** Papers, citations, numbers and visual readings are used only after checking the original text, result files or source data.
16. **Record all failures, but put only adopted components and their ablations in the paper.**
17. **Apply methods the researcher sets to the documents in the same turn.** When the researcher corrects you or sets a new way of working, edit the relevant chapter of the method document within that turn, without asking for separate approval, and add one line to the improvement log. If it applies only to that study, put it in that study's repository instructions; lessons from work that is not research do not go into the method documents. Procedure in 01 §7.2.
18. **Collect lessons the AI found by itself as candidates without being asked, and ask about them together at a work milestone.** In the turn where a signal appears, add one line with the general lesson to the improvement-candidate note; if there is no answer, ask again at the start of the next session. Signals, format and handling in 01 §7.2. Publish to the public release only when the researcher says to.
- The locations of the method documents, the improvement log and the candidate note follow the global instructions; if none is given, only inform the researcher.

### 2.4 Approval scope
The boundary between what the AI may do alone, what needs the researcher's approval, and what is not done.

| Category | Work |
| --- | --- |
| AI does alone | Checking records, research, explanation, design drafts, code and tests, smoke, training after a successful smoke, diagnosis, result documents and wiki records, commits of specified files |
| Researcher approval needed | Topic and scope, judgment rules, design confirmation, direction changes, lifting constraints, value tuning, choosing a fix, costly work (multiple seeds, long computation, paid APIs), using multi-agent tools, push and external publication, creating actual skill files |
| Not done | Changing network or VPN settings, using other people's resources, killing processes by name pattern, sending personal information or secrets, selectively changing criteria after seeing results (cherry-picking, principle 5), choosing values on test data |
- If an item needs approval and the researcher is away, take the safe default (do not proceed) and record what is being waited for.
- A scope the researcher has pre-approved (e.g. train if the smoke succeeds) is used only within that scope.

## 3. Research flow
How a study proceeds from topic to manuscript, and when to go forward, go back or change direction. Methods within each stage are in the reference documents in the table. A stage is passed only when its outputs are documented and the researcher confirms them; when failures on the same axis accumulate, go back or change direction in one of the defined forms.

### 3.1 Stages
A study divides into 12 stages, from preparation to manuscript and verification. In each stage the AI produces drafts, measurements and candidates, the researcher handles scope, choice and confirmation, and the end of a stage is checked by its outputs.

| Stage | What the AI does | What the researcher decides | Output | Reference |
| --- | --- | --- | --- | --- |
| ① Preparation | Drafts of instructions, wiki, documentation timing and check hooks; building a reproducible environment | Scope of rules, prohibitions | Instruction files, wiki skeleton, fixed execution environment | 01, 03 §4 |
| ② Topic | Reverse-analysis of good papers, checking resource limits and overlap with existing work, proposing candidates and falsifying experiments | Topic and scope, boundaries between studies | One-sentence problem definition, instructions stating the boundary | 02 §1 |
| ③ Method derivation | Measuring failures of the strongest baseline, cause hypothesis, minimal intervention candidates | Choice of cause and intervention | One cause and 2–3 intervention candidates | 02 §2 |
| ④ Question and judgment | Questions per axis and falsification conditions, draft judgment rules | Fixing judgment rules and metrics | Pre-registration document | 02 §3 |
| ⑤ Prior work and gap | Coverage table, saturation/gap map, practice survey, novelty judgment per module | Contributions to claim and not to claim | Prior-work document, claim sentence | 02 §4–5 |
| ⑥ Fixing the baseline | Reproducing the baseline under fair comparison conditions, fixing environment and data | Choice of baseline | First row of the ladder table | 03 §4–5 |
| ⑦ Design | Slot list, design document, scientific review, loss candidates with plain explanations | Design confirmation | Design document | 03 §1–3 |
| ⑧ Development and training | Borrowing → code and tests → smoke → training, a one-page sheet for hand drawing, full measurement during training | Drawing the overview by hand | Training run and records | 03 §6–8, 05 |
| ⑨ Judgment | Automatic result document, explanation of causes, fix candidates, measuring the mechanism of a row that improved (targeted errors, causes, remaining share) | Adopt, revert, next row | Result document, one ladder-table row, starting value for the next component | 08 §1–2 |
| ⑩ Direction review | Failure diagnosis, grounds for closing, next candidates | Closing and changing direction | Rejection list, decision record | 3.3 |
| ⑪ Freeze and test | Freezing the main system, one evaluation on sealed test data | Freeze timing | Freeze record, test results | 08 §2 |
| ⑫ Manuscript and verification | Mock review, separating limitations from missing preparation, manuscript verification | Content to include and claim strength | Verified manuscript | 04, 06 |
- The AI does not take over what the researcher decides. The AI gives options, a recommendation and grounds, and records the researcher's decision verbatim.
- Operational cleanup, moving repeated instructions into instructions, memory and automatic mechanisms, happens continuously regardless of stage and speeds up later stages.

### 3.2 Stage movement criteria
Movement between stages is judged by outputs and the researcher's confirmation. The conditions for going forward, staying, going back, and moving to the test and manuscript stages are set out below.
- **Move to the next stage**: only when the stage's outputs are documented and confirmed by the researcher. Do not start module development without judgment criteria.
- **Stay in the same stage**: do not change direction before at least 3 trained rows exist in one direction. Moving after one or two failures leaves no direction checked to the end.
- **Go back to an earlier stage**: if failures on the same axis continue, return to the question and prior-work stages and revisit the problem definition and fit criteria before changing the method further.
- **The test stage happens once**: open the test data only once after freezing the main system, and do not re-select the system after seeing the result. If the ranking on validation and test is the same, treat it as reproduced.
- **Condition for the manuscript stage**: finalize the manuscript after the model configuration is fixed and the multi-seed repeats and needed additional dataset experiments are done. Until then the manuscript stays a draft.

### 3.3 Forms of direction change
A direction change is made, when a trigger appears, in one of the forms below. Each form pairs a trigger with an action, so that the method is not changed arbitrarily when failures accumulate.

| Change | Trigger | Action |
| --- | --- | --- |
| Redefine the problem | Experiments on the same axis fail repeatedly | Before changing the method, redefine the problem using the target venue's fit criteria, and record which venue the previous design fits |
| Replace the baseline | In a fair comparison, the proposed method does not beat a stronger baseline | Take that baseline as the new base and rebuild the ladder from the start |
| Close a direction | The problem is confirmed by measurement but there is no signal to fix it, or several trained rows all fail to improve | Close the direction and add it to the rejection list with the grounds (measurements, conditions) |
| Narrow the claim | Rejected in mock review, or a simple alternative beats the proposed structure | Withdraw the structural claim and reduce to a simple method and an honest benchmark; in exchange, secure reproducibility of the results |
| Change the question | A pre-fixed judgment comes out FAIL | Do not change the judgment; change the question toward what the result actually shows. A re-measurement with a larger sample is split into a new plan |
| Branch the study | Available resources and conditions make it hard to prove an effect, or a topic of a different character appears | Split a topic feasible with available resources alone into a separate study and write the boundary into the instructions |
| Tool reuse | A tool or harness is built during research | Reuse it as a working tool for other studies; evaluate the tool itself separately, under the condition that the comparison setup is not changed after seeing results |

### 3.4 Flow record
- Keep the research flow in the project wiki (01 §5). The status index holds only the current row, the next steps and a few recent decisions; stage transitions and pivots are written in the log with their decision numbers.
- Write a closed or changed direction on the closed-directions page with its grounds (measurements, conditions). Write numbers as the judgment metric and the difference from the baseline, and cite the result document as the source.

## 4. Operating principles
Principles for starting sessions, waiting for training, reporting to the researcher and interpreting requests, and handling the execution environment. Details in 01 and 05. All four principles go by the records and the runner's state, not by memory or summaries.

### 4.1 Starting and resuming a session
After a new session, a context summary, a usage limit or a disconnection, restore the state in the same order.
1. Read the status index to check the current baseline, work in progress and next steps.
2. Read the relevant topic pages and recent log entries to check the last decisions and the researcher's words.
3. Check the actual state of running jobs (training, queues, watch commands) from the runner records. Do not trust memory or summaries.
4. If there are finished results not yet recorded, record and report them first.
5. If the improvement candidate note has candidates the researcher has not answered, ask again in one line.
6. Then handle the researcher's new request. Do not proceed on work that needs the researcher's approval while disconnected.

### 4.2 While training runs
Use the time while training runs to prepare the next row; do not fill it with new experiments or early conclusions.
- Do: support the researcher's hand-drawn overview and check it against the design, discuss the next row's design, prepare the result document template, measure on already saved checkpoints, tidy documents and the wiki.
- Do not: run experiments only because resources are idle, retrain finished experiments, draw conclusions before results, poll at short intervals.
- When asked for interim results, answer from the training records, and state that numbers before the judgment point are "interim".

### 4.3 Reporting and interpreting requests
Write reports so the researcher can read them and judge at once, and before acting on a request, first establish what is wanted. Put the conclusion and what to decide at the start and end, write in the researcher's language, and follow the dedicated rules for explanations that are often misread, such as formulas, ratios and similar terms.

Write a report in this order.
1. Put the conclusion first, grounds and numbers after.
2. Compare in tables, and attach a verdict (adopted, on hold, unverified) to numbers.
3. End with what the researcher must decide and what comes next. When the work has a defined final output (a proposal, a manuscript etc.), put drafting that output first among the next steps, and fit the surrounding work into the draft as gaps to fill. If only side work piles up without the output, nothing is left before the deadline. In review or learning conversations where the researcher leads the order, do not decide and propose the next item; answer only what was asked. An order set by the AI breaks the researcher's flow.

- Write in the researcher's language, using plain words instead of internal code names. State decisions by their content and put the number only in parentheses (e.g. "the base is set to row 3 (D12)").
- Say that work in progress is in progress, and state start and end only after seeing the runner records.
- Keep it short and do not say the same thing twice.
- When offering options over several turns, use labels that do not overlap between lists (first list A, B, C; next list P, Q, R etc.), and when the researcher answers with a label alone, restate the chosen option by name before proceeding. If labels overlap, measurements and code go out on an option the researcher did not choose.

When reporting a measurement or check result, restate three lines before the conclusion: **what was measured** (in plain words, what was compared with what), **why it was measured** (which question it answers, who asked for it and how the wording of the request differs from what was actually done, which decision the result changes), and **the judgment criterion** (the threshold fixed before the numbers). Then write the result and "so what changes". The researcher runs several pieces of work in parallel, so restate these every time a result comes out, even if they were explained at registration. Spell out internal stage and batch names. Put the same three fields in the header table of the result document.

When explaining a formula (expected value, decision rule, metric), do not start with the formula: where possible, first show in a table the outcome and cost for each possible case (true state), derive the formula by weighting with probabilities, then compute it once with a small numeric example. State the assumptions the formula simplifies as well. Given only the formula, the researcher asks again where it came from and has trouble answering review questions alone.

For a threshold or metric set as a ratio, state the denominator in words ("what percent of all what"), together with the good direction (lower or higher is better) and the cost the value means. A ratio without its denominator is read as a share of the whole, and its meaning is understood backwards. Also, for metrics or terms with similar names or symbols, contrast them at the first explanation with their similar counterpart: what each measures differently (the information used, the good direction, one example where the values diverge). If the same word is used in two senses in the manuscript, attach a definition.

When referring to a concept, use the field's standard term instead of a coined word. At its first appearance write the term together with its original (e.g. connected component, surrounding context, context bias, confident error), and attach a one-line definition and one concrete example. If no standard term exists and a new name is truly needed, state "(newly coined name)" and write how it differs from the closest standard term. Do not call the same object by different words in different conversations. Coined words keep the researcher from mapping them to prior work and manuscript sentences, and sound like new concepts that inflate novelty. In documents that persist, such as research proposals, summaries and wikis, the names of frameworks (names of axes, stages and solutions) also take the standard term as their proper name; plain words (e.g. "unknown", "different", "ladder") are used only when first explaining in conversation. Do not use the form that keeps the plain word as the proper name with the standard term in parentheses either. When a plain word becomes the name of an output, the document reads as childish and reviewers cannot read it as a concept of the field.

If the same concept is not understood after two explanations, do not add a new analogy; find the one intermediate step the explanation assumes (such as the rule that turns a number into an answer), show only that step concretely, and move on. Changing the analogy while skipping the same step gets stuck in the same place.

Taking a request on guesswork and producing the wrong output, or handing over only an empty result, costs another round of conversation and adds to the checking burden. So when a request comes in, first consider the following. Cases where the referent is ambiguous are in 07 §5.
- If the request also names other people (team members, students) or asks about a way of doing things, such as "how should we do this", confirm in one line before acting whether the output is something the AI makes directly or an instruction or division of work for people; if unclear, give the instruction draft first. If the AI makes what should be handed to people, it only adds time and checking burden.

### 4.4 Execution environment
Below are only the operating rules from 05 that apply to every session, in short form; the detailed procedures are in 05.
- The main agent does short tasks itself; workers and multi-agent tools are used only when the researcher asks or it has been decided to work that way. The criteria for launching workers within that are in 05 §1.
- Launch long jobs detached from the session, judge completion by an end marker, and report "unverified" if there is no end marker.
- Do not touch other people's resources (GPUs etc.) or network settings. Stop processes only by process ID.
- Do not put personal information or secrets in request arguments, output or commits.
- Commit only the files changed, and push only after approval and only to the designated branch.

### 4.5 Unpublished research and AI-use disclosure
Putting unpublished manuscripts or data into external AI services, and disclosing AI use, follow the policies of the institution and the venue.
- Before putting unpublished manuscripts or data into an external AI service, check the AI-use policies of the institution and the venue.
- Record which work (research, code, proofreading etc.) used AI, and disclose it from that record when the venue requires.

## 5. Signals to stop and check
Stop and check when you see these signals during work or before handing over results or documents. Responses by type are in 07. Most signals point to AI output that may disagree with the records or originals, so check by comparing against those records and originals.

| Signal | Check |
| --- | --- |
| A proposal that seems already tried | Whether it is a closed direction in the log or rejection list, and whether the closing conditions are the same as now |
| A confident explanation without grounds, a conclusion from early-training numbers | Whether it is a measured fact or an estimate, and whether the judgment point was fixed in advance |
| Criteria changed after seeing results | Whether the pre-registration document and the rules used are the same |
| Suspiciously good or bad results | Scoring and evaluation path, weight loading, simpler explanations (bias, leakage) |
| A proposal after a long conversation | Whether earlier decisions and constraints were forgotten (re-read the decision document first) |
| "Started" or "finished" reports | Whether they match the runner's start and end records |
| Proposal of an experiment, check run, retraining or extra measurement | Whether it changes a decision and has a gain, and whether results, checkpoints or tools with the same setting and data already exist (without mistaking a run on a different split for the same one) |
| Comparison results | Whether the comparison methods got the same resources, data and input conditions |
| Papers, citations and numbers in manuscripts and reports | The original page (title, first author, year, venue) and whether it is a formal publication, the reading depth for each judgment, the original passage for quotations, the numbers in the result files |
| Records | Whether the log, topic pages and status index were updated in the same turn |
| Text the researcher will read | Whether it is written in plain words and examples, without code or formulas |
- When the same mistake happens twice, move it into memory, instructions or a mechanism.
