# Research with AI — Critique, Paper Writing, External Documents

| Item | Content |
| --- | --- |
| Purpose | Lets you critique your own research with an AI agent, structure, write and verify a manuscript, and produce documents for external readers, using this document alone |
| When to read | Finding weaknesses before submission, deciding how to report evaluation splits and ablations, structuring a manuscript, fixing sentences, tables and citations, proofreading and verifying a manuscript, writing external reports and shared documents |
| Outputs | Review response table, split decision record, manuscript, item-by-item proofreading response document, verified build, external documents |
| Structure | §0 work order, §1–§7 methods |

## 0. Work order
The order and outputs for bringing one manuscript to a submittable state.

| Step | Section | Output |
| --- | --- | --- |
| Critique | 1 Mock review and the reviewer's view | Per-comment verdict table, review response table |
| Reporting | 2 Evaluation splits and ablation reporting | Split decision record |
| Content selection | 3 What goes in the paper | List of results to report, limitations vs. preparation-gaps table |
| Structure | 4 Manuscript structure | Numbered challenge chain, placement of sections, tables and figures |
| Writing | 5 Sentence, table and citation rules | Manuscript |
| Verification | 6 Manuscript verification | Proofreading response document, verified build |
| External sharing | 7 Documents for external readers | External document |

## 1. Mock review and the reviewer's view
How to imitate review with AI before submission to find weaknesses first. Review comments are not accepted as is; each is judged.

- Get reviews from several reviewers in different fields plus an editor role. Giving each reviewer a field and a confidence level keeps comments from overlapping.
- Judge each comment as "correct / wrong", and rebut wrong comments with evidence. Turn correct comments into experiment or manuscript-revision items. A review narrows the rejection reasons to a few, so address those reasons first.
- Along with the review, check that references actually exist, and remove quotation marks from quotes that are not verbatim.
- Repeat the review in the same format after some time and track score changes. Mark probability estimates such as acceptance chance as close to guesswork.
- List the questions reviewers are likely to ask in order, and for each decide whether to answer with an experiment or a manuscript sentence. If you decide not to run a costly experiment, state the reason in one sentence in the manuscript.
- If a new comparison breaks an existing claim, withdraw the claim the same day. Do not change the comparison to protect the claim.
- For reviews of a previous submission, map each item to "where it will be answered (experiment, table, sentence)" in a table, so nothing is missed when rewriting.
- If results look good, ask whether an easier explanation exists (data bias, information leakage), and add control experiments that rule it out.
- Summarize how far similar work has developed its methods to find what your method lacks, and question yourself whether the comparison conditions are set up in your favor.

## 2. Evaluation splits and ablation reporting
How to separate the data used for design choices from the data used for final reporting.

- First survey which split papers in the same field report main results and ablations on, where they say values were chosen, and whether they report repeated seeds and standard deviations. If split practices are mixed within the field, numbers are hard to compare across papers, so state your split clearly in the manuscript.
- The basic principle is "choose on the validation split, report on the test split". Ablations and design choices use a validation split carved out of the training data; the final comparison uses the official test split.
- Carve the validation split out of the training data by group (same place, subject or source together) so it does not overlap the test data.
- State in the paper "design and ablations on the validation split, final comparison on the official test split", and show both split numbers side by side for the full model.
- The two splits need not give the same numbers; after the model is fixed, check that the direction and order of component effects agree.
- Report repeated-seed means, standard deviations, paired differences and significance tests for the main table on the test split, and repeated-seed results for ablation rows on the validation split. Stating where values were chosen and the seed variance, which other papers do not report, is itself a basis for trust.

## 3. What goes in the paper
Principles for deciding what goes in the main text and what stays in internal records.

- The paper reports only adopted components and their ablations. Rows that did not improve and failed attempts are recorded only in internal documents and not used as analysis tables.
- Keep a method paper a method paper. Use failure analysis only as supporting material that explains the method; do not turn it into a diagnosis, analysis or negative-results paper.
- Main-text comparisons are between models trained on the same data. Comparisons with models trained on larger or different data go in a separate generalization table, and that table shows the effect of attaching our module to other models rather than our full system. Check that the comparison layout does not read to readers as "we lost", and present a small model approaching a large one as a strength.
- Do not drop datasets or sample groups after seeing that results are bad. Dropping them creates selection bias.
- Split "we did not do X" sentences into two.
  - **Limitation**: a deliberately chosen scope or a weakness confirmed by experiment. Write it in the limitations section as is.
  - **Preparation gap**: something that could have been done but has not been yet (e.g., running fewer repeats for the comparison methods only). Do not leave it in the manuscript as "not measured"; fill it with an experiment before freezing, or redefine the scope and record that decision.
- Name the type of contribution precisely. A structural change that remains at inference is an architectural contribution; a module or loss attached only during training is a training-method contribution. If the inference network is the same, do not write "new architecture". Present a training-method contribution with the strength "improves at no inference cost".
- Prove a contribution with an ablation row that differs only in that component, with the same architecture and the same data. Components that did not meet the adoption criteria are not listed as contributions.

## 4. Manuscript structure
Structural principles that make the whole manuscript one connected chain. Pick one well-structured paper as a template and follow only its structure, not strong phrases such as "first" or "state of the art".

- Compare a few papers in the same field published in the target journal to check conventions for the number of modules, datasets and experimental conditions, and align the manuscript's composition.
- Fix the manuscript's frame first in three lines: problem → solution → limitations.
- Define 2–3 challenges and number them. The same numbers and names recur in the abstract, Figure 1, introduction, method, ablations and conclusion.
- One module handles one challenge, and the module name is used as is in section titles and table column names.
- Figure 1 shows "challenge + failure of the existing best method (with its original input) + success of our method". Comparisons whose difference is too small to see in a figure are handled by a main-text table instead. State the rule for picking figure examples in the caption.
- Order the experiment section as setup → baseline comparison → main evaluation → ablations → generalization.
- Start ablations with a checkmark table that turns modules on and off, then go into analysis inside the modules. When adding a new module or input, add a row too.
- Show separately, in a generalization table, that the contribution is not tied to a specific model.
- Result sentences read the table as "which challenge's cells improved" rather than listing numbers. Keep a few numbers per paragraph and move detailed values to the appendix.
- Reduce main-text tables to those needed for the claims, and move details such as algorithm boxes to the supplementary material.
- The introduction does not give result numbers; it states what was shown in words and section references.
- The conclusion closes by returning to the challenge numbers and states remaining limitations with numbers.
- Divide related work into subsections, and pin down the gap in the final sentence, e.g., "no work addresses both challenges together".
- Divide the body into subsections instead of bold-lead paragraphs, and write the rest as continuous prose whose first sentence states the topic.
- Each time content is added to the manuscript, check the structure against the items in this section and record the result in the manuscript-revision section of the result document.

## 5. Sentence, table and citation rules
Rules that keep the manuscript's sentences and tables consistent. For each manuscript, keep fixed terminology and the list of already-fixed defects as a skill and load it before editing. When the method changes, first check that the skill's old terms still match the current method.

### 5.1 Sentences
- Every claim sentence must be able to point to something that supports it (a figure in the manuscript, a citation, or a reference to the section that measures it). If none of the three exists, leave the sentence out.
- Do not use semicolons or colons in the body. Both hide logical connectives ("so", "that is", "although"), so choose a connective or split into two sentences.
- Do not use parenthetical explanations, lists introduced by a colon, or body sentences that mention the appendix.
- Write captions as sentences, not "symbol: description" lists. Within a short limit, say "what it shows and what can be learned".
- Set length limits for the abstract, captions, tables and body, and check word counts with a script. Information lost while shortening is not deleted but moved to the body or appendix.

### 5.2 Tables
- Use the same name for the same model in all tables, body text and appendix.
- Do not attach input conditions or training status to the model name; mark them with checkmark columns. Mark only what is on and leave what is off blank.
- Bold the best value in each column. Main-text tables have no difference (Δ) column; paired differences and intervals go in the appendix table and body sentences.
- Do not put two values in one cell separated by a slash.
- Do not report the same result in two tables. Split experiments of different nature (retrained ablations vs. robustness with only test-time input changes) into separate tables.
- Divide per-condition comparisons with left row groups and separator lines, and order rows within a group by improving score so our method is at the bottom.
- Report each baseline with the strongest setting measured. If our method appears to get favorable input or training, give the baseline the same setting.
- Keep only the rows and columns supporting the claims in main-text tables, and move internal variants and auxiliary columns to the full appendix table.

### 5.3 Citations
- A citation must support the very phrase it is attached to. Do not reuse a citation from a neighboring topic.
- A name attached to a citation must be the name the cited paper uses for itself.
- Add bibliography entries only after checking authors, venue, volume, pages and DOI against the publisher's record; never fill them from memory.
- For API models, state the official system card, model id and time of use, and use the official product name so it is not confused with other models of the same generation. When correcting a name, change tables, figures and number-check files at once.

## 6. Manuscript verification
How to verify a finished manuscript with machines and a different AI. Separate the AI that writes from the AI that reviews.

- **Skeleton read**: extract only section titles and first sentences of paragraphs to read the flow, and check in a table whether each paragraph "does one thing". Rewrite weakly flowing sections into subsections by what they do, such as definition, construction and evaluation.
- **Automatic number check**: wrap every number in the manuscript in a macro and check it mechanically against the result report. Hand-copied numbers go wrong repeatedly, so wrap them without exception. Stop the build if a sentence link breaks or the point estimate behind an "outperforms" claim is 0 or below.
- **Tie claim words to intervals**: state in the manuscript the rule that "outperforms" is used only when the paired interval is above 0, recompute with every new result, and weaken the wording to "comparable" if it falls short.
- **Pre-register figure examples**: fix the rule for picking examples in a document before picking them, and record per-model results for all examples meeting the condition, to show the shown examples were not cherry-picked.
- **Input labeling**: in figures and tables, clearly mark with group headers which model saw which input (full image, cropped window, etc.).
- **Interlock the abstract**: the last sentence of the abstract takes up the challenges named at its start in the same order and closes with "this is how we solved them". Do not end with "it works well" alone.
- **Citation check**: find names without citations and unused bibliography entries, and check every entry against web records.
- **Length control**: build with the official build engine after every change and check page count and section start positions. Other build engines differ in line count and mislead the page count. If it overflows, shorten with sentences of the same meaning; build errors and undefined references must be 0.
- **Independent review**: have an AI other than the one that wrote the manuscript review it, and run it in the order of §6.1.

### 6.1 Running proofreading
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
| 1. Get comments only | Give a read-only reviewer only the PDF and source, and have it produce a numbered list without fixing anything. For each item, record severity, location, quoted passage, proposed fix and length impact | Do not tell it the writing AI's intent or judgment in advance (answers get pulled that way) |
| 2. Judge in groups | Sort comments by nature: fact (numbers, tables or citations wrong), rule violation, structure or narrative (needs a human decision), taste. Fix facts right away after confirming with the evidence file, fix all rule violations, and let a person choose on structure | Comments can be wrong. Open the evidence file to confirm before fixing or rebutting |
| 3. Item-by-item response document | For each item, record fixed / partial / rebutted / awaiting decision, with the evidence file path and before→after sentence. Rebut comments that overlap decisions already made by a person, citing that decision | Many comments overlap decisions already made or are matters of taste. Recording the evidence in a response document keeps the same comments from recurring in the next review |
| 4. Machine checks after fixing | After every fix: build, page count and section position check, number check, length and per-paragraph number check, test run | One extra line can overflow a page. Shorten with sentences of the same meaning too |
| 5. Re-review by the same reviewer | Give the same reviewer the response document and the changed manuscript and have it (a) check that fixed items were fixed correctly, (b) open files to check that rebuttal evidence holds, (c) find new problems introduced by the fixes | The first pass finds big problems (page overflow, overclaiming); the re-review finds new errors from fixes and the writing AI's wrong assertions. Run both |
| 6. Turn into mechanisms | Comments that appear twice move into memory, instructions or check scripts (punctuation ban → check, number mismatch → wider number-check scope) | Number errors come from tables outside the check script, so widening the check scope is the surest prevention |

- Do not proofread after every edit; run it once per stage, such as after a structural change, after numbers change substantially, and before submission. After small edits, run only the machine checks.
- Decisions that change the manuscript's scope, such as whether to submit an appendix, are made by a person and recorded when changed.
- Decisions where conventions diverge, such as notation (interval notation, abbreviations, symbols), get a separate consultation, and the supporting papers and rejected alternatives are recorded.

## 7. Documents for external readers
Rules for producing documents for external readers separately from internal records.

- Remove all internal traces (project phase numbers, mentions of other internal documents, internal code names).
- Do not leave estimate markers or change history in external documents.
- Write like a report, matched to what the reader wants to know. If the reader wants results, do not use a requesting tone, state the scope of observation, and do not add a section that repeats a summary.
- Do not present results that have not yet been obtained as results. Base schedules and outcomes on the original plan.
- Do not repeat items already written or add unnecessary items.
- The wiki is an internal document; external documents are based on the dated cards and result documents that serve as evidence.
- Before putting an unpublished manuscript or data into an external AI service, check the institution's and venue's policies, and base the AI-use disclosure on the work records.
