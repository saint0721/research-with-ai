# Research with AI — Critique, Manuscript Review, External Documents

| Item | Content |
| --- | --- |
| Purpose | Lets you critique and verify a finished manuscript yourself with an AI agent, and produce documents that go to external readers, using this document alone |
| When to read | Finding weaknesses before submission (mock review), handling feedback and reviews, proofreading and verifying a manuscript, checking submission requirements, writing external reports and shared documents |
| Outputs | Review response table, item-by-item proofreading response document, verified build, submission requirements table, external documents |
| Structure | §0 work order, §1–§3 methods. How to write the manuscript is in 04 |

## 0. Work order
The order and outputs for bringing a finished manuscript to a submittable state and sending it out.

| Step | Section | Output |
| --- | --- | --- |
| Critique | 1 Mock review and the reviewer's view | Per-comment verdict table, review response table |
| Verification | 2 Manuscript verification | Proofreading response document, verified build, submission requirements table |
| External sharing | 3 Documents for external readers | External document |

## 1. Mock review and the reviewer's view
How to imitate review with AI before submission to find weaknesses first. Review comments are not accepted as is; each is judged.

- A mock review follows the target venue's actual review process and form. Assign three reviewers from different fields and an AC role, and have each reviewer fill in the fields of the actual review form in the same order (summary, contribution type, strengths and weaknesses, quality, clarity, significance and originality scores, questions, whether limitations are addressed, overall score, confidence, ethics and format concerns).
- The order is ① a first review reading only the main text → ② our rebuttal (for each comment, an answer checked against the manuscript and the location of the evidence) → ③ final reasons and revised scores after reading only the main text, the rebuttal and the supplementary material the rebuttal points to → ④ the AC meta-review and decision. Not giving the supplement from the start shows whether the main text stands on its own, and the score change between before and after the rebuttal is the key signal.
- The AC meta-review does not average the scores but combines them weighted by confidence, points out each reviewer's character (sharp-questioning, borderline-scoring, positive), and separately lists, even on acceptance, the comments to fix in the final version and the background and abbreviation explanations needed for readers outside the field. The decision is given in the venue's decision form (oral, poster, reject).
- Give the reviewers in advance the document of confirmed proofreading items (04 §4) and the principles the researcher has set; give the reference-check results only to the AC. Mock review scores have no reference point, so have a few published real reviews and decisions reviewed with the same prompt, compute a calibration of how lenient or harsh the AI scores are, and read the scores after that. Write uncalibrated scores as "uncalibrated", and do not state them as an acceptance probability.
- Judge each comment as "correct / wrong", and rebut wrong comments with evidence. Turn correct comments into experiment or manuscript-revision items. A review narrows the rejection reasons to a few, so address those reasons first.
- Remove quotation marks from quotes that are not verbatim. The reference check is in §2.
- Repeat the review in the same format after some time and track score changes.
- List the questions reviewers are likely to ask in order, and for each decide whether to answer with an experiment or a manuscript sentence. If you decide not to run a costly experiment, state the reason in one sentence in the manuscript.
- If a new comparison breaks an existing claim, withdraw the claim the same day. Do not change the comparison to protect the claim.
- For reviews of a previous submission, map each item to "where it will be answered (experiment, table, sentence)" in a table, so nothing is missed when rewriting.
- Keep feedback from the advisor and co-authors in its original words; check each comment against the manuscript's values and sort it into already present, to be answered with a sentence, and needs an experiment; then propose handling bundles (tasks, cost), get a decision, and record in the same document where each was applied.
- When reporting the handling status of earlier comments, write items the researcher has settled as a principle as "settled as a principle (basis: location of the rule)", and do not classify them as unresolved or risks. If a reviewer asks again, answer with that principle. Reviving a settled decision as a risk makes the researcher explain the same decision over and over.
- When using a review as grounds for a design or decision, quote the original sentence and record whether the object of the criticism is the base structure or the size of the contribution built on it. If only a paraphrase is kept, the criticism shifts as if it targeted something else, and a decision that does not answer it gets chosen.
- When judging novelty, do not carry over an earlier self-assessment (a conclusion such as "the method is simple" in a survey document); check directly in the manuscript's numbers (a) the observation for why this combination, (b) an effect larger than the sum of the parts, (c) transfer to other models. If it reads as weak, report whether the cause is the writing or the content.
- When criticising or rebutting with the setting numbers of another study, check the units in the code as in 02 §4.2 and convert to a common unit before comparing.
- If results look good, ask whether an easier explanation exists (data bias, information leakage), and add control experiments that rule it out.
- Summarize how far similar work has developed its methods to find what your method lacks, and question yourself whether the comparison conditions are set up in your favor.

## 2. Manuscript verification
How to verify a finished manuscript with machines and a different AI. Separate the AI that writes from the AI that reviews.

- **Skeleton read**: extract only section titles and first sentences of paragraphs to read the flow, and check in a table whether each paragraph "does one thing". Rewrite weakly flowing sections into subsections by what they do, such as definition, construction and evaluation.
- **Automatic number check**: wrap every number in the manuscript in a macro and check it mechanically against the result report. Hand-copied numbers go wrong repeatedly, so wrap them without exception. Stop the build if a sentence link breaks or the point estimate behind an "outperforms" claim is 0 or below.
- **Tie claim words to intervals**: state in the manuscript the rule that "outperforms" is used only when the paired interval is above 0, recompute with every new result, and weaken the wording to "comparable" if it falls short.
- **Choosing figure examples**: the examples shown in a figure (qualitative examples) and the comparison methods placed in that figure may be chosen after counting cases under several conditions and combinations. What the fairness rules forbid is editing table or numeric results, or picking only favourable scenes or seeds to produce numbers — not choosing examples. Instead, state in the caption or supplement under which condition the example was chosen and facts such as whether the model's 'answer' is a threshold decision, and keep in the result document the number of cases meeting the condition and the per-model error rate.
- **Input labeling**: in figures and tables, clearly mark with group headers which model saw which input (full image, cropped window, etc.). Where the manuscript describes the comparison conditions as, for example, "the same recipe", check them cell by cell against the run ledger (03 §5.4).
- **Interlock the abstract**: the last sentence of the abstract takes up the challenges named at its start in the same order and closes with "this is how we solved them". Do not end with "it works well" alone.
- **Citation check**: find names without citations and unused bibliography entries. The reference hallucination check covers only the entries the manuscript actually cites; search public scholarly databases by title, but do not send the manuscript text. Judge as 'hallucinated' an entry that cannot be found anywhere, has a badly wrong author list or names a venue that does not exist, and as 'to fix' wrong author spellings, venue names or numbers; do not decide from automatic results alone, but confirm each one directly. Venues treat two or more hallucinated references, or one together with 'signs of AI writing' (unsupported numbers, repeated phrasing, references to figures or tables that do not match, nonexistent section numbers), as grounds for rejection, so check for those signs too. Keep the results as a table of item, verdict, evidence and action.
- **Submission requirements check**: make a requirements table (rejection-cause flag, our status, to-do) together with the date the venue's author guidelines were read, and review it again before the deadline. Include the author profile and author-change deadlines, page count, AI-use paragraph, anonymity, external links, supplement references, human-subjects statement, data release, citation of concurrent work, and rebuttal rules.
- **Length control**: build with the official build engine after every change and check page count and section start positions. Other build engines differ in line count and mislead the page count. If it overflows, shorten with sentences of the same meaning; build errors and undefined references must be 0. With every build, also check by script that each section title is followed by at least 3 lines of body text in the same column and that the conclusion ends within the last allowed page.
- **Independent review**: have an AI other than the one that wrote the manuscript review it, and run it in the order of §2.1.
- **Section-by-section writing check**: when polishing the manuscript, check one section at a time before the researcher asks, and first propose the places to fix in a table. In addition to the structure in 04 §2 and the sentence rules in 04 §4.1, check the following.
  - Read the introduction for missing links between sentences (such as "so the only option is to look again"). The experimental setup section introduces only the comparison methods and conditions; comparison and interpretation belong in the results section, and the results section includes the quantitative analysis that the table values allow.
  - Ablation and analysis sections open each paragraph with "component A solves challenge i", and gather the evidence for that challenge in one paragraph.
  - The metrics section keeps only the equations and short symbol definitions, and checks function by function that the explanation under each equation matches the definition in the code (direction of the threshold, handling of ties).
  - If an "it" or "this" at the end of a paragraph refers to something other than the subject just before it, name the subject. If two models are bundled into one claim, check that each model fits the claim in every cell of the table; if not, drop it or write it separately.
  - Write captions about what is actually visible in the figure, and do not use phrases such as "most cleanly" that a single threshold can refute.
  - After fixing, keep the length by cutting meaningless words within the same section or restoring meaningful words that were cut earlier.

### 2.1 Running proofreading
Run proofreading in the order "get comments → judge → fix → recheck". The same AI does not comment and fix in one go.
- Proofreading uses Hyungtae Lim's paper-proofreading prompt collection ([awesome-claudecode-paper-proofreading](https://github.com/LimHyungTae/awesome-claudecode-paper-proofreading), MIT license). The prompts are not copied into this document; they are taken from the original repository. The criteria are distilled from 100+ conference and journal reviews. Clone the repository once and load the prompt files by absolute path from the manuscript workspace. A citation-support check is added separately, for three passes in total.
- Run the three in this order.

| Order | Prompt | What it checks |
| --- | --- | --- |
| 1 | `01_latex_workspace_review.md` | Does the manuscript build and submit cleanly (preamble settings, package order, macros, cross-references, labels, bibliography, figure and table files, leftover TODOs) |
| 2 | `02_paper_proofreading.md` | Is the writing clear and the claim honest (grammar and tense, awkward phrasing, overclaiming, structure and flow, figures, tables and captions, abstract and conclusion, notation consistency, hyphenation). Give the root `.tex` and the built PDF together |
| 3 | Citation-support check (not in the original; added separately) | Do the cited sources actually say this. For each claim–citation pair, retrieve the source passage; anything that could not be retrieved is not filled from memory but marked `UNVERIFIED` |
- These prompts also work in two phases. In phase 1 they list every issue with a number (`[1]`, `[2]` …) and stop; only after the researcher picks the numbers to fix do they fix them in phase 2. This is the same principle as the operating order in the table below.

| Step | Method | Caution |
| --- | --- | --- |
| 1. Get comments only | Give a read-only reviewer the PDF, the source and the document of confirmed proofreading items, and have it produce a numbered list without fixing anything. For each item, record severity, location, quoted passage, proposed fix and length impact | Do not tell it the writing AI's intent or judgment in advance (answers get pulled that way) |
| 2. Judge in groups | Sort comments by nature: fact (numbers, tables or citations wrong), rule violation, structure or narrative (needs a human decision), taste. Fix facts right away after confirming with the evidence file, fix all rule violations, and let a person choose on structure | Comments can be wrong. Open the evidence file to confirm before fixing or rebutting |
| 3. Item-by-item response document | For each item, record fixed / partial / rebutted / awaiting decision, with the evidence file path and before→after sentence. Rebut comments that overlap decisions already made by a person, citing that decision | Many comments overlap decisions already made or are matters of taste. Recording the evidence in a response document keeps the same comments from recurring in the next review |
| 4. Machine checks after fixing | After every fix: build, page count and section position check, number check, length and per-paragraph number check, test run | One extra line can overflow a page. Shorten with sentences of the same meaning too |
| 5. Re-review by the same reviewer | Give the same reviewer the response document and the changed manuscript and have it (a) check that fixed items were fixed correctly, (b) open files to check that rebuttal evidence holds, (c) find new problems introduced by the fixes | The first pass finds big problems (page overflow, overclaiming); the re-review finds new errors from fixes and the writing AI's wrong assertions. Run both |
| 6. Turn into mechanisms | Comments that appear twice move into memory, instructions or check scripts (punctuation ban → check, number mismatch → wider number-check scope) | Number errors come from tables outside the check script, so widening the check scope is the surest prevention |

- Do not proofread after every edit; run it once per stage, such as after a structural change, after numbers change substantially, and before submission. After small edits, run only the machine checks.
- Decisions that change the manuscript's scope, such as whether to submit an appendix, are made by a person and recorded when changed.
- Decisions where conventions diverge, such as notation (interval notation, abbreviations, symbols), get a separate consultation, and the supporting papers and rejected alternatives are recorded.

## 3. Documents for external readers
Rules for documents given, outside the manuscript, to readers seeing the research results for the first time (result reports, model design and structure descriptions).
- Do not use execution terms such as code variables, column names, file and folder paths, run names, commits, seeds or folds, internal code names, or mentions of other internal documents; write the same content in plain words (e.g. `p_fut` → risk probability, sealed test → an evaluation test kept apart and not used in development). Keep the reproduction details in the internal run records.
- State the scope of observation, and do not add estimate markers, change history or a section that repeats a summary.
- The wiki is an internal document; external documents are based on the dated cards and result documents that serve as evidence.
- In an AI-use disclosure (such as a venue's LLM Usage Statement), state only what the AI actually did: writing and running code, drawing figures from result files, polishing text, checking numbers, searching the literature. Research ideas, experimental design and figure layout belong to the researcher; the AI answers questions and carries out and organizes what the researcher decided. The basis of the disclosure is the work records (00 §4.5).
