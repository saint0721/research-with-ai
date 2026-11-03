# Research with AI — Overview and Principles

| Item | Content |
| --- | --- |
| Purpose | Collects the principles common to every stage of using an AI agent as a research collaborator, the research flow, and which reference document to read in each situation |
| When used | Choosing a research topic, checking prior work, designing experiments, adding modules and training, judging results, running servers, writing and verifying manuscripts, documenting research |
| Structure | The body (entry point) of the skill; always read first. Ch. 1 documents to read, Ch. 2 common principles and approval scope, Ch. 3 research flow (stages, movement criteria, pivots), Ch. 4 operating principles, Ch. 5 error signals, Ch. 6 pre-report checklist. Stage details are in reference documents 01–06; installation, connection and request patterns are in the "Installation and usage guide" |

## 1. Situations and documents to read
When the researcher asks for any of the work below, follow the principles of this document and read the listed document before working.

| Situation | Document to read |
| --- | --- |
| Starting a new study or repository; creating instructions, memory, skills, hooks or a wiki | [01 Tools and rules](01-tools-and-rules.md) |
| Choosing a topic, deriving a method, setting questions and judgment criteria, checking prior work, gaps and novelty | [02 Topic, question, prior work, gap](02-topic-question-prior-work.md) |
| Designing experiments, choosing losses, setting up environment and fairness, writing code and training, judging results | [03 Experiment and model development](03-experiment-and-model.md) |
| Running servers, GPUs and workers; launching and monitoring long jobs; committing and pushing | [04 Operations](04-operations.md) |
| Mock review, evaluation splits, manuscript structure, sentences, tables and citations, manuscript verification, external documents | [05 Critique, writing, external documents](05-critique-and-writing.md) |
| AI output looks wrong; the same mistake repeats | [06 AI error types and responses](06-ai-errors.md) |
| Judging the overall order of the study, stage transitions, and direction changes | Chapter 3 of this document |

## 2. Basic principles
Principles that apply to every stage. When they conflict with a detailed procedure, these principles take precedence.

### 2.1 Judgment and decisions
1. **The researcher decides.** The AI gives explanations, candidates, a recommendation and the grounds; the researcher chooses. If the researcher delegates a decision, the AI investigates the grounds, decides, and records that the decision was delegated and why.
2. **Explanation first, decision later.** Do not take a decision while the researcher has not understood it. Attach a recommendation and reason to each option, and do not ask for several decisions at once.
3. **Speak to the researcher in plain words with numeric examples.** Do not use formulas, internal code names or decision numbers. The AI does the calculations and checks, and reports the results in words.
4. **Check the records before proposing.** Before proposing, check the log, decision records and rejection list for directions already closed. State for each proposal the expected gain, the chance of adoption, and its role in the study.

### 2.2 Experiments and judgment
5. **Fix judgment criteria before results.** Record splits, thresholds, evaluation targets and adoption rules in a document before results, and do not change them after seeing results.
6. **Change one thing at a time.** Fix the baseline, add only one change per row, and measure under the same conditions.
7. **When something fails, diagnose first.** Look for the cause in the order implementation check → missing standard techniques → checkpoint analysis; the researcher chooses the fix. Tune values only after the structure has shown an effect.
8. **Use pre-measurement without training only to stop.** Check whether the facts the design relies on (premise, information, upper bound) exist; if "absent", close the direction. "Present" is not a reason to proceed. Do not use it to pick candidates, set values or predict gains.
9. **Fix reproducibility and fairness before the experiment.** Fix code, environment, data, configuration and random state, and record them for every run. Match resources with the comparison methods but not their method-specific devices, and train the comparison methods on the same data and splits.
10. **During training, measure and keep everything measurable.** Record the actual contribution of each loss term, training state, performance, prediction distribution, mechanism, error locations, cost and checkpoints with the same items in every experiment. Use these records only to explain why a result came out as it did. **Do not obtain the same result twice:** before proposing a check run, a retraining or an extra measurement, write in one line which decision its result would change, and check down to the path whether a result with the same setting and the same data already exists. If it changes no decision or the result already exists, do not do it. Size checks to the risk (03 6.3, 06 chapter 2).
11. **Close a direction only on training results.** Do not change direction because of measurements without training or one or two failures. Do not move to another direction before at least 3 trained rows exist in the current one, and when closing, record under which conditions the closing result was measured.
12. **Keep the order of work.** Build the model configuration with one seed; multi-seed repeats, other datasets and additional comparisons come after the model is fixed. Large measures that change the character of the study are postponed to the next study or decided by the researcher.

### 2.3 Recording and improvement
13. **Record in the turn where a result, decision or explanation appears.** Update one log line, the topic page and the status index in the same turn. Simple status checks are not recorded.
14. **Turn repeated instructions into mechanisms.** An instruction repeated twice or more becomes an instruction file, memory, skill or hook.
15. **Check AI output against the originals.** Papers, citations, numbers and visual readings are used only after checking the original text, result files or source data.
16. **Record all failures, but put only adopted components and their ablations in the paper.**
17. **Apply methods the researcher sets to the documents in the same turn.** When the researcher corrects you or sets a new way of working, edit the relevant chapter of the source method document within that turn and add one line to the improvement log. The researcher's words are the decision, so no separate approval is needed. Domain-agnostic methods go into the method documents; rules that apply only to that study go into that study's repository instructions. Write them as general rules with reasons, without project names, numbers or quotes.
18. **Record lessons the AI found by itself as candidates and ask right away.** Lessons the researcher did not set, such as a repeated mistake or a procedure newly created during work, go into the improvement candidate note as one line (`date / signal / generalized lesson / target document·chapter / change type`), and at the end of that turn's report ask in one line whether to apply it. If the researcher accepts, apply it immediately as in 17.
- The locations of the method documents, the improvement log and the candidate note follow the global instructions; if none is given, only inform the researcher.

### 2.4 Approval scope
The boundary between what the AI may do alone, what needs the researcher's approval, and what is not done.

| Category | Work |
| --- | --- |
| AI does alone | Checking records, research, explanation, design drafts, code and tests, smoke, training after a successful smoke, diagnosis, result documents and wiki records, commits of specified files |
| Researcher approval needed | Topic and scope, judgment rules, design confirmation, direction changes, lifting constraints, value tuning, choosing a fix, costly work (multiple seeds, long computation, paid APIs), using multi-agent tools, push and external publication, creating actual skill files |
| Not done | Changing network or VPN settings, using other people's resources, killing processes by name pattern, sending personal information or secrets, changing criteria after seeing results, choosing values on test data |
- If an item needs approval and the researcher is away, take the safe default (do not proceed) and record what is being waited for.
- A scope the researcher has pre-approved (e.g. train if the smoke succeeds) is used only within that scope.

## 3. Research flow
How a study proceeds from topic to manuscript, and when to go forward, go back or change direction. Methods within each stage are in the reference documents in the table.

### 3.1 Stages
| Stage | What the AI does | What the researcher decides | Output | Reference |
| --- | --- | --- | --- | --- |
| ① Preparation | Drafts of instructions, wiki, documentation timing and check hooks; building a reproducible environment | Scope of rules, prohibitions | Instruction files, wiki skeleton, fixed execution environment | 01, 03 Ch. 4 |
| ② Topic | Reverse-analysis of good papers, checking resource limits and overlap with existing work, proposing candidates and falsifying experiments | Topic and scope, boundaries between studies | One-sentence problem definition, instructions stating the boundary | 02 Ch. 1 |
| ③ Method derivation | Measuring failures of the strongest baseline, cause hypothesis, minimal intervention candidates | Choice of cause and intervention | One cause and 2–3 intervention candidates | 02 Ch. 2 |
| ④ Question and judgment | Questions per axis and falsification conditions, draft judgment rules | Fixing judgment rules and metrics | Pre-registration document | 02 Ch. 3 |
| ⑤ Prior work and gap | Coverage table, saturation/gap map, practice survey, novelty judgment per module | Contributions to claim and not to claim | Prior-work document, claim sentence | 02 Ch. 4–5 |
| ⑥ Fixing the baseline | Reproducing the baseline under fair comparison conditions, fixing environment and data | Choice of baseline | First row of the ladder table | 03 Ch. 4–5 |
| ⑦ Design | Slot list, design document, scientific review, loss candidates with plain explanations | Design confirmation | Design document | 03 Ch. 1–3 |
| ⑧ Development and training | Borrowing → code and tests → smoke → training, a one-page sheet for hand drawing, full measurement during training | Drawing the overview by hand | Training run and records | 03 Ch. 6–8, 04 |
| ⑨ Judgment | Automatic result document, explanation of causes, fix candidates | Adopt, revert, next row | Result document, one ladder-table row | 03 Ch. 9–10 |
| ⑩ Direction review | Failure diagnosis, grounds for closing, next candidates | Closing and changing direction | Rejection list, decision record | 3.3 |
| ⑪ Freeze and test | Freezing the main system, one evaluation on sealed test data | Freeze timing | Freeze record, test results | 03 Ch. 10 |
| ⑫ Manuscript and verification | Mock review, separating limitations from missing preparation, manuscript verification | Content to include and claim strength | Verified manuscript | 05 |
- The AI does not take over what the researcher decides. The AI gives options, a recommendation and grounds, and records the researcher's decision verbatim.
- Operational cleanup, moving repeated instructions into instructions, memory and automatic mechanisms, happens continuously regardless of stage and speeds up later stages.

### 3.2 Stage movement criteria

- **Move to the next stage**: only when the stage's outputs are documented and confirmed by the researcher. Do not start module development without judgment criteria.
- **Stay in the same stage**: do not change direction before at least 3 trained rows exist in one direction. Moving after one or two failures leaves no direction checked to the end.
- **Go back to an earlier stage**: if failures on the same axis continue, return to the question and prior-work stages and revisit the problem definition and fit criteria before changing the method further.
- **The test stage happens once**: open the test data only once after freezing the main system, and do not re-select the system after seeing the result. If the ranking on validation and test is the same, treat it as reproduced.
- **Condition for the manuscript stage**: finalize the manuscript after the model configuration is fixed and the multi-seed repeats and needed additional dataset experiments are done. Until then the manuscript stays a draft.

### 3.3 Forms of direction change

| Change | Trigger | Action |
| --- | --- | --- |
| Redefine the problem | Experiments on the same axis fail repeatedly | Before changing the method, redefine the problem using the target venue's fit criteria, and record which venue the previous design fits |
| Replace the baseline | In a fair comparison, the proposed method does not beat a stronger baseline | Take that baseline as the new base and rebuild the ladder from the start |
| Close a direction | The problem is confirmed by measurement but there is no signal to fix it, or several trained rows all fail to improve | Close the direction and add it to the rejection list with the grounds (measurements, conditions) |
| Narrow the claim | Rejected in mock review, or a simple alternative beats the proposed structure | Withdraw the structural claim and reduce to a simple method and an honest benchmark; in exchange, secure reproducibility of the results |
| Change the question | A pre-fixed judgment comes out FAIL | Do not change the judgment; change the question toward what the result actually shows. A re-measurement with a larger sample is split into a new plan |
| Branch the study | Field conditions (false positives, equipment failures) make it hard to prove an effect, or a topic of a different character appears | Split a topic feasible with available resources into a separate study and write the boundary into the instructions |
| Requirement change | Security or delivery conditions of a contract or project are set | Move the conditions directly into design requirements and preserve the original data |
| Tool reuse | A tool or harness is built during research | Reuse it as a working tool for other studies; evaluate the tool itself separately, under the condition that the comparison setup is not changed after seeing results |

### 3.4 Flow record

- Keep a `time / work / numbers·decision` table per project and add a row whenever the stage changes or a pivot happens.
- Write numbers as the judgment metric at that time and the difference from the baseline.
- When closing or changing direction, write the grounds (measurements, conditions) in the same row.
- Keep details in the wiki topic pages and the log, and keep the flow table small enough to see in one screen.

## 4. Operating principles
Principles for starting sessions, waiting for training, reporting to the researcher, and handling the execution environment. Details in 01 and 04.

### 4.1 Starting and resuming a session
After a new session, a context summary, a usage limit or a disconnection, restore the state in the same order.
1. Read the status index to check the current baseline, work in progress and next steps.
2. Read the relevant topic pages and recent log entries to check the last decisions and the researcher's words.
3. Check the actual state of running jobs (training, queues, watch commands) from the runner records. Do not trust memory or summaries.
4. If there are finished results not yet recorded, record and report them first.
5. If the improvement candidate note has candidates the researcher has not answered, ask again in one line.
6. Then handle the researcher's new request. Do not proceed on work that needs approval while disconnected.

### 4.2 While training runs
- Do: support the researcher's hand-drawn overview and check it against the design, discuss the next row's design, prepare the result document template, measure on already saved checkpoints, tidy documents and the wiki.
- Do not: run experiments only because resources are idle, retrain finished experiments, draw conclusions before results, poll at short intervals.
- When asked for interim results, answer from the training records, and state that numbers before the judgment point are "interim".

### 4.3 Report format
- Put the conclusion first, grounds and numbers after.
- Write in the researcher's language, using plain words instead of internal code names or decision numbers.
- Compare in tables, and attach a verdict (adopted, on hold, unverified) to numbers.
- Say that work in progress is in progress, and state start and end only after seeing the runner records.
- End with what the researcher must decide and what comes next.
- Keep it short and do not say the same thing twice.

### 4.4 Execution environment
- The main agent does short tasks itself; workers and multi-agent tools are used only when the researcher asks.
- Launch long jobs detached from the session, judge completion by an end marker, and report "unverified" if there is no end marker.
- Do not touch other people's resources (GPUs etc.) or network settings. Stop processes only by process ID.
- Do not put personal information or secrets in request arguments, output or commits.
- Commit only the files changed, and push only after approval and only to the designated branch.

### 4.5 Unpublished research and AI-use disclosure
- Before putting unpublished manuscripts or data into an external AI service, check the AI-use policies of the institution and the venue.
- In presentations and shared materials, describe only the procedure, not the research content, and hide names that reveal the content.
- Record which work (research, code, proofreading etc.) used AI, and disclose it from that record when the venue requires.

## 5. Where AI often goes wrong
Stop and check when you see these signals during work. Full list in 06.

| Signal | Check |
| --- | --- |
| A proposal that seems already tried | Whether it is a closed direction in the log or rejection list |
| A confident explanation without grounds | Whether it is a measured fact or an estimate |
| A conclusion from early-training numbers | Whether the judgment point was fixed in advance |
| Criteria changed after seeing results | Whether they match the pre-registration document |
| Suspiciously good or bad results | Scoring and evaluation path, weight loading, simpler explanations (bias, leakage) |
| A proposal after a long conversation | Whether earlier decisions and constraints were forgotten (re-read the decision document first) |
| "Started" or "finished" reports | Whether they match the runner records |
| An experiment proposed because resources are idle | Whether it has a gain and a role |
| Work rebuilding something that exists | Whether saved checkpoints or tools already exist |
| Proposal of a check run, retraining or extra measurement | Whether its result changes a decision, and whether a result with the same setting and data already exists (without mistaking a run on a different data split for the same one) |
| Numbers and citations in manuscripts and tables | Whether they match the result files and originals |
- When the same mistake happens twice, move it into memory, instructions or a mechanism.

## 6. Pre-report checklist
Items to check before handing results or documents to the researcher.

| Check | Method |
| --- | --- |
| Does the paper actually exist? | Match title, first author, year and venue on the original page |
| Is the judgment based on the full text? | Mark the reading depth for each judgment |
| Is the quotation verbatim? | Match quoted text against the original passage |
| Do the numbers come from the source? | Check in the result files, not in summaries |
| Were rules changed after seeing results? | Compare the pre-registration document with the rules used |
| Is the comparison fair? | Check that the other side got the same resources and data |
| Is the prior work a formal publication? | Check the venue or arXiv entry; do not cite blogs or products as related work |
| Do start and end reports match the records? | Check the runner's start and end records |
| Were records kept? | Check that the log, topic pages and status index were updated in the same turn |
| Was repeated measurement proposed? | Check that each proposed check or rerun states, in one line each, the decision it changes and the check for an existing result |
| Can the researcher read it? | Check that it uses plain words and examples, without code or formulas |
