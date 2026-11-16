# Research with AI — Types of AI Errors and Responses

| Item | Content |
| --- | --- |
| Purpose | Lets you notice in advance where an AI agent repeatedly goes wrong during research, correct it when it does, and turn the fix into a mechanism so it does not recur, using this document alone |
| When to read | When the AI's answers, results or reports look odd, when the same mistake appears twice, before judging results or handing over a manuscript or report |
| Outputs | Corrected results and documents, correction history, memory, instructions or automatic mechanisms that prevent recurrence |
| Structure | §0 work order, §1–§5 signals and responses by error type, §6 common responses. When the response rule lives in another chapter, the response points to that chapter |

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
| Over-reading early fluctuation | Says "it is improving" from mean differences in the first few epochs | Fix the judgment point in advance and judge on values after training stabilizes |
| Using a pre-measurement as grounds to proceed | Cites a small gain from a measurement without training as evidence that "it will work" | Use it only as grounds to stop (03 §9.4). Gains without training repeatedly flip sign once trained |
| Re-proposing a closed direction | Proposes again, under a new name, a direction already tested and closed | Before proposing, search the log, decision records and rejection list, and disclose any overlap first (00 principle 4) |
| Recording a broader decision | Records a wider decision than the researcher chose, or records the leader's interpretation as if it were the researcher's decision | Record the decision in the researcher's own words, and ask back if the scope is unclear. Mark interpretations and follow-on rules the leader added separately as "leader proposal", and do not turn them into rules before the researcher confirms them. Once an added sentence spreads into several documents its source cannot be traced, and it gets proposed again on the strength of that sentence |
| Unfounded explanation | Answers with unmeasured examples as if they were evidence | When asked for evidence, check the records first, and separate what was measured from what is estimated |
| Judging from the paper text only | Explains a prior method's behavior only from the paper's sentences | Check the actual behavior in the public code (02 §4.2) |
| Expectation on weak grounds | States expected performance assertively, and the grounds collapse at the next question | Mark expectations as estimates with their grounds, and correct immediately when the grounds weaken |
| Judging results against a sentence stated in advance | When results differ from the expectation sentence stated at proposal time, reports them as "unfavorable" | Judge against the paper's actual claim, the base rate of the experimental setting, and the comparison reference (the best fixed policy). Write expectation sentences only as hypotheses |
| Over-reading fairness rules | Blocks, or proposes tagging in the manuscript as "post-hoc manipulation" or "not a test", things such as picking figure examples, improving the method after validation, choosing metrics and table layout, ablation tables on the validation split, and re-aggregating saved test runs. Raises settled points again as risks | The cause is applying the wording of the rule while forgetting its purpose (preventing cherry-picking). Before blocking or flagging, check against the purpose of 00 principle 5 and the settled correction items (04 §4), and do not block unless it is a matter of picking only good values to make the numbers |
| Following an overturned decision from old records | Reads an old sentence from memory or a guide that differs from a decision the researcher changed (submission scope, worker use, seed procedure, etc.) and follows it as is | In the turn where the decision is overturned, fix or delete the old memory or guide sentence (01 §4.1). When using a rule as grounds, check its date against recent decisions |
| Concluding from part of the metrics | Draws a conclusion from one metric only | Look again at all judgment metrics and correct the conclusion |
| Declaring a weak result an idea failure | Concludes "no effect" right away when results are flat or bad | Diagnose in the order of 03 §9.1 |
| Frame skewed toward a specific technique | Every proposal is built around a specific technique rather than the problem | Rebuild proposals from the measured problem, and keep the technique in the role of a tool |
| Misunderstanding the existing implementation | Proposes as a new contribution something the baseline code already does | Read the relevant code directly before proposing |
| Reasoning beyond the condition | Says a result under one condition also holds under other conditions | Mark it as an estimate until measured again |
| Numeric unit errors | Mixes percentage points with relative ratios | Recompute numbers from the source and state the unit alongside |

## 2. Experiment and code errors
Errors that arise when designing and running experiments or changing code. Numbers come out even when results are wrong, so when results look odd, suspect the execution path first.

| Error type | Signal | Response |
| --- | --- | --- |
| Auto-running a pre-set fix | After a failure, immediately runs a pre-decided fix without diagnosing | 03 §9.1 |
| Proposing experiments without a reason | Proposes an experiment "because resources are idle" | State the expected gain and role first, and do not propose if there are none (00 principle 10) |
| Retraining to get values that already exist | Reruns a finished experiment, or after adding a recording device reruns a baseline row that already has results | 03 §8.3 |
| Excessive checking and proving | Re-measures facts already shown, or proposes checks that change no decision. The researcher ends up asking "why are we doing this again?" | There are three causes: after being burned once by a hidden difference, checks extend even where there is no risk; the decision a check would change is not asked before checking; doing many checks is mistaken for being careful. Response: 03 §6.3 |
| Several changes at once | The score dropped but the cause cannot be isolated | One change per row (00 principle 6) |
| Checking against a modified copy | Judges "matches" by comparing with a file someone else modified | Check against the original repository and the paper's equations (02 §4.2) |
| Scoring-path bug | Results are at chance level or the output distribution is nearly flat | For oddly bad (or good) results, check weight loading and the scoring path first. Such results easily slip into the manuscript's claims |
| Rerun with missing state | Loss magnitude of a measurement rerun from a checkpoint differs greatly from the original | 03 §8.3. Save the method's internal state as well |
| New term not trained | New parameters stay at their initial values, or an added loss term is overwritten by later code so its gradient is 0 | 03 §6.3, 7.1 ④ |
| Content damaged by batch edits | After a scripted edit, sections shrink or headers break | After editing, check line count, section titles, headers and change statistics |
| Overwriting output | A missing output path overwrites a registered result file | Write only to new folders, and keep registered versions read-only (03 §4.3) |
| Labeling or ID bugs | Class labels or download failure counts are oddly high | Confirm the cause with a post-hoc auxiliary diagnosis and record it in the ledger |
| Arbitrary thresholds in pre-registration | The AI inserts pass thresholds without grounds | Pre-measurement registrations contain only rankings and descriptions, no thresholds |
| Values in the design document differ | The design document's settings differ from the actual training settings | Copy design values from the code configuration |
| Queueing without prerequisites | Queues a comparison experiment without the porting or fixes that must come first | Before queueing, check the prerequisites in the plan document |

## 3. Manuscript and table errors
Errors that arise when handling manuscripts and tables. They mostly occur where automatic number checks do not reach.

| Error type | Signal | Response |
| --- | --- | --- |
| Swapped table cells | Checkmarks or cell values differ from the result report | Add an independent review and check every table against the report cell by cell. Automatic number checks do not see checkmarks |
| Summary numbers without a source | Numbers in the abstract or body match no table or figure cell | Take numbers from actual cells and state the range |
| Claims inconsistent with intervals | Writes "better" when the confidence interval includes 0 | Claim-word rules in 06 §2 |
| Assertion without checking | Says "it comes out like this" without looking at the build or output | Check the actual build result before asserting |
| Misleading figures or tables | A marker attached to only one item makes another item's condition read wrong | Mark conditions in group headers |
| Figure and caption version mismatch | Only the figure remains an old version and disagrees with the caption | Pixel comparison in 05 §6 |
| Misattributing credit | The AI-use disclosure is written as if the AI did the ideas or design, or our own parts are written as "following" or "adopting" prior work, giving the credit to prior work | 04 §4.1, 06 §3 |

## 4. Data and visual-reading errors
Errors that arise when the AI reads or produces images and data. Human checks are the reference.

| Error type | Signal | Response |
| --- | --- | --- |
| Visual-reading errors | The AI's reading differs from what a person saw directly | Use the human-checked material as the reference and keep a correction history |
| Errors in generated records | Much of the records or notes produced by a model are wrong | Do not trust them as is; inspect a sample |
| Defects in generated evaluation items | Defects are mixed into evaluation items produced by the AI | If a defect is found during evaluation, discard that round without opening the scores |
| Test information exposure | There is output that saw test data information | Delete the output, and disclose in the paper that it was seen once |

## 5. Communication and operations errors
Errors that arise in conversation and run operations. Most reappear after the context grows long or is summarized.

| Error type | Signal | Response |
| --- | --- | --- |
| Using terms without explanation | The researcher asks "what does that mean?" or "explain it simply" | Explain in plain words with concrete magnitudes and examples. Measurement results, too, first say with examples "what was measured and what came out", then attach the table (00 §4.3) |
| Misidentifying the referent | Takes a numbered item (table, section, figure), or a word that can also be read as a different target from the previous work ("main", "title"), as something else and makes a long proposal | For a number, find that exact label and restate in one line what it is before starting. For a word readable as two targets, write in the first line of the proposal which unit of which document is being handled, and confirm first if it differs from the flow of the previous work |
| Misjudging a deadline | Says the deadline has passed from an AoE or UTC date alone | Convert to the researcher's local time, write date and time together, and say whether it has passed by comparing with the current local time |
| Misreporting progress | Reports a job still in pre-check as "training" | 05 §3 |
| Guessing times | Times in the records differ from reality | 01 §6.1 |
| Personal data leak | User information goes into an external API request | 05 §5 |
| Missing documentation | Records are missed even after repeated instructions | 01 §5.3, response-end check hook (01 §5.4) |
| Watcher failure | No notification, or a late one, after the job finished | 05 §4 |
| Taking the command's end for the job's end | When the launch command ends, reports the job as finished too or launches it again. The job keeps running in the background | Before relaunching or saying it has finished, check with the process and the log (05 §4) |
| Time-estimate errors | The expected time of a short test is far off | 05 §2 |
| Excessive agent cost | Several agents wake for every job and reread the context | 05 §1 |

## 6. Common responses
Response principles shared across several types.

- Do not use AI output for visual readings, numbers, units or citations as is; pass it through a human check column or a source comparison, then keep a correction history.
- If results differ greatly from expectations, check the execution path (scoring, state, settings) before doubting the method.
- When the AI admits and corrects an error, record the correction in the log so the next session does not repeat the same judgment.
- When the same mistake appears twice, do not point it out verbally again; move it into memory, instructions or an automatic mechanism. Choose an automatic mechanism if it can be judged mechanically, instructions if judgment is needed.
- When the same kind of correction comes up several times, do not add one more case rule ("this is fine too"); write down in one sentence the purpose of what that rule is meant to prevent. If only cases pile up, the same correction repeats at the next case.
