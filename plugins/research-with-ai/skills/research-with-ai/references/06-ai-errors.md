# Research with AI — Types of AI Errors and Responses

| Item | Content |
| --- | --- |
| Purpose | Lets you notice in advance where an AI agent repeatedly goes wrong during research, correct it when it does, and turn the fix into a mechanism so it does not recur, using this document alone |
| When to read | When the AI's answers, results or reports look odd, when the same mistake appears twice, before judging results or handing over a manuscript or report |
| Outputs | Corrected results and documents, correction history, memory, instructions or automatic mechanisms that prevent recurrence |
| Structure | §0 work order, §1–§5 signals and responses by error type, §6 common responses |

## 0. Work order
The order to follow when something odd is found in AI output, and the output of each step.

| Step | Section | Output |
| --- | --- | --- |
| Notice the signal | "Signal" column of §1–§5 | List of suspect items |
| Check against the source | §6 | Result of checking the source and execution path |
| Correct | "Response" column of §1–§5 | Corrected results and documents, correction history |
| Prevent recurrence | §6 | One memory entry, instruction or automatic mechanism |

## 1. Judgment and interpretation errors
Errors that arise when the AI reads results or proposes directions. They come out as plausible sentences, so they are easy to miss unless the evidence is checked separately.

| Error type | Signal | Response |
| --- | --- | --- |
| Over-reading early fluctuation | Says "it is improving" from mean differences in the first few epochs | Fix the judgment point in advance and judge on values after training stabilizes. Early means are noise and can soon reverse |
| Using a pre-measurement as grounds to proceed | Cites a small gain from a measurement without training as evidence that "it will work" | Use pre-measurements only as grounds to stop. Gains without training repeatedly flip sign once trained |
| Re-proposing a closed direction | Proposes again, under a new name, a direction already tested and closed | Before proposing, search the log, decision records and rejection list, and disclose any overlap first. When the context changes, the AI does not remember closed directions |
| Recording a broader decision | Records a wider decision than the researcher chose (e.g., settling the next step too) | Record the decision in the researcher's own words, and ask back if the scope is unclear |
| Unfounded explanation | Answers with unmeasured examples as if they were evidence | When asked for evidence, check the records first, and separate what was measured from what is estimated |
| Judging from the paper text only | Explains a prior method's behavior only from the paper's sentences | Before using it as evidence, check the actual behavior in the public code. The text and the code sometimes differ |
| Expectation on weak grounds | States expected performance assertively, and the grounds collapse at the next question | Mark expectations as estimates with their grounds, and correct immediately when the grounds weaken |
| Concluding from part of the metrics | Draws a conclusion from one metric only | Look again at all judgment metrics and correct the conclusion. Another metric can give the opposite conclusion |
| Declaring a weak result an idea failure | Concludes "no effect" right away when results are flat or bad | Before discarding, check the implementation and missing standard techniques (normalization, sharpening, weight schedule) first |
| Frame skewed toward a specific technique | Every proposal is built around a specific technique rather than the problem | Rebuild proposals from the measured problem, and keep the technique in the role of a tool |
| Misunderstanding the existing implementation | Proposes as a new contribution something the baseline code already does | Read the relevant code directly before proposing |
| Reasoning beyond the condition | Says a result under one condition also holds under other conditions | Mark it as an estimate until measured again under the changed condition |
| Numeric unit errors | Mixes percentage points with relative ratios | Recompute numbers from the source and state the unit alongside |
| Inserting non-existent achievements | Writes achievements or studies into a document that do not exist or are not confirmed | Take achievements and schedules only from the original plan and actual records |

## 2. Experiment and code errors
Errors that arise when designing and running experiments or changing code. Numbers come out even when results are wrong, so when results look odd, suspect the execution path first.

| Error type | Signal | Response |
| --- | --- | --- |
| Auto-running a pre-set fix | After a failure, immediately runs a pre-decided fix without diagnosing the cause | Diagnose first; the researcher chooses the fix |
| Proposing experiments without a reason | Proposes an experiment "because resources are idle" | State the expected gain and role of each proposal first. Do not propose if the gain is small and there is no role |
| Retraining to get values that already exist | Reruns a finished experiment to see intermediate values | Save checkpoints and measure from them |
| Several changes at once | The score dropped but the cause cannot be isolated | One change per row |
| Checking against a modified copy | Judges "matches" by comparing with a file someone else modified | Check against the original repository and the paper's equations. Using a modified copy as reference lets a wrong port pass |
| Scoring-path bug | Results are at chance level or the output distribution is nearly flat | For oddly bad (or good) results, check weight loading and the scoring path first. Such results easily slip into the manuscript's claims |
| Rerun with missing state | Loss magnitude of a measurement rerun from a checkpoint differs greatly from the original | Compare the first-step loss magnitude with the original run, and save the method's internal state as well |
| New parameters not moving | The smoke checks only that it runs and its memory | In the smoke, check that new values leave their initial values. Finding this late wastes a long training run |
| Content damaged by batch edits | After a scripted edit, sections shrink or headers break | After editing, check line count, section titles, headers and change statistics |
| Overwriting output | A missing output path overwrites a registered result file | Write only to new folders, and keep registered versions read-only |
| Labeling or ID bugs | Class labels or download failure counts are oddly high | Confirm the cause with a post-hoc auxiliary diagnosis and record it in the ledger |
| Arbitrary thresholds in pre-registration | The AI inserts pass thresholds without grounds | Pre-measurement registrations contain only rankings and descriptions, no thresholds |
| Values in the design document differ | The design document's settings differ from the actual training settings | Copy design values from the code configuration |
| Queueing without prerequisites | Queues a comparison experiment without the porting or fixes that must come first | Before queueing, check the prerequisites in the related plan document |

## 3. Manuscript and table errors
Errors that arise when handling manuscripts and tables. They mostly occur where automatic number checks do not reach.

| Error type | Signal | Response |
| --- | --- | --- |
| Swapped table cells | Checkmarks or cell values differ from the result report | Add an independent review and check every table against the report cell by cell. Automatic number checks do not see checkmarks |
| Summary numbers without a source | Numbers in the abstract or body match no table or figure cell | Take numbers from actual cells and state the range |
| Claims inconsistent with intervals | Writes "better" when the confidence interval includes 0 | Keep a rule for claim sentences and recheck with every new result |
| Assertion without checking | Says "it comes out like this" without looking at the build or output | Check the actual build result before asserting |
| Misleading figures or tables | A marker attached to only one item makes another item's condition read wrong | Mark conditions in group headers |
| Figure and caption version mismatch | Only the figure remains an old version and disagrees with the caption | When regenerating a figure, pixel-compare it with the old one |

## 4. Data and visual-reading errors
Errors that arise when the AI reads or produces images and data. Human checks are the reference.

| Error type | Signal | Response |
| --- | --- | --- |
| Visual-reading errors | The AI's reading differs from what a person saw directly | Use the human-checked image as the reference and keep a correction history |
| High-confidence false detections | A high-confidence detection is actually a different object, and the equipment reacts to false detections and exhausts resources | Do not filter on confidence alone; keep a check column where a person writes the identity, and a reading page |
| Metadata mismatch | The time in the file name differs from the time shown on screen | Use the value shown on screen as the reference |
| Errors in generated records | Much of the records or notes produced by a model are wrong | Do not trust generated records as is; inspect a sample |
| Defects in generated evaluation items | Defects are mixed into evaluation items produced by the AI | If a defect is found during evaluation, discard that round without opening the scores |
| Test information exposure | There is output that saw test data information | Delete the output, and disclose in the paper that it was seen once |

## 5. Communication and operations errors
Errors that arise in conversation and run operations. Most reappear after the context grows long or is summarized.

| Error type | Signal | Response |
| --- | --- | --- |
| Drifting response language | After context summarization, or in short status reports, replies come in another language | Keep the language rule in memory and apply it to short reports too |
| Using terms without explanation | The researcher asks "what does that mean?" | Explain in plain words with concrete magnitudes and examples |
| Misreporting progress | Reports a job still in pre-check as "training" | Report training start only after confirming the actual start marker |
| Guessing times | Times in the records differ from reality | Always read times from the clock or commit time |
| Personal data leak | User information goes into an external API request | Put a prohibition sentence in the research brief |
| Ignoring existing tools | Installs a tool that already exists | Check whether it exists before installing |
| Missing documentation | Records are missed even after repeated instructions | Add an automatic check at the end of each response |
| Watcher failure | No notification, or a late one, after the job finished | Judge by the log's end marker, not the process name; do not rely on shell word splitting; if late, read the server records first |
| Time-estimate errors | The expected time of a short test is far off | Estimate from step time, excluding start-up cost |
| Excessive agent cost | Several agents wake for every job and reread the context | One watcher per agent, and do mechanical wrap-up in a single script run |
| Tool's faulty completion handling | A task is marked complete without verified evidence | Accept completion only with evidence from an exact commit, and report the defect to the tool's developer |

## 6. Common responses
Response principles shared across several types.

- Do not use AI output for visual readings, numbers, units or citations as is; pass it through a human check column or a source comparison, then keep a correction history.
- If results differ greatly from expectations, check the execution path (scoring, state, settings) before doubting the method.
- When the AI admits and corrects an error, record the correction in the log so the next session does not repeat the same judgment.
- When the same mistake appears twice, do not point it out verbally again; move it into memory, instructions or an automatic mechanism. Choose an automatic mechanism if it can be judged mechanically, instructions if judgment is needed.
