# Research with AI — Paper Writing

| Item | Content |
| --- | --- |
| Purpose | Lets you structure and write a paper manuscript with an AI agent to the standards of the target venue, using this document alone |
| When to read | Starting to write a manuscript, deciding what to report and on which split, structuring a manuscript, writing and fixing sentences, tables and citations |
| Outputs | Slot table per review axis, attack-point handling table, split decision record, list of results to report, manuscript |
| Structure | §0 work order, §1–§5 methods. Mock review and verification of a finished manuscript, and external documents, are in 06 |

## 0. Work order
The order and outputs from starting a manuscript to finishing it.

| Step | Section | Output |
| --- | --- | --- |
| Criteria | 1 Writing the manuscript to review criteria | Slot table per review axis, attack-point handling table |
| Reporting | 2 Evaluation splits and ablation reporting | Split decision record |
| Content selection | 3 What goes in the paper | List of results to report, limitations vs. preparation-gaps table |
| Structure | 4 Manuscript structure | Numbered challenge chain, placement of sections, tables and figures |
| Writing | 5 Sentence, table and citation rules | Manuscript |

## 1. Writing the manuscript to review criteria
How to use the target venue's author guidelines and review criteria as the manuscript's standard before and while writing. Mock review (06 §1) evaluates a finished manuscript; this section applies the same criteria first, at the writing stage.
- Before writing, summarize the target venue's author guidelines and reviewer guidelines (the evaluation axes and score definitions of the review form) together with the date they were read, and for each axis decide where in the manuscript that axis is supported.

| Review axis | Where the manuscript supports it |
| --- | --- |
| Novelty | The gap sentence at the end of related work, the "why this combination" observation and ablation numbers at the head of the method |
| Significance | The problem and challenges in the introduction, Figure 1 |
| Quality | Fair comparison conditions, paired intervals, honest reporting of failures and limitations |
| Clarity | One or two sentences of background for readers outside the field, abbreviations spelled out at first use, figures and tables that stand alone |
- Make a list of expected attack points and handle each in one of three ways: the evidence exists but is not visible enough in the body → bring that evidence up into the body; a deliberately chosen scope → write it in the limitations section; an experiment is needed → send it to the design document and register it before results. Keep the handling result and where it was applied in the manuscript in the same document.
- Tag each proofreading comment with the name of a review axis (overclaiming, clarity, novelty etc.), so it is visible which axis the sentence weakens.
- For the title and contribution sentences, write side by side for each candidate what it promises and whether the manuscript supports that promise, and let the researcher choose.
- What the guidelines fix in form (position and content of the AI-use disclosure, supplementary references, anonymity, rebuttal rules) is written in the guidelines' own wording, and items whose violation leads to rejection go into the submission-requirements table (06 §2).

## 2. Evaluation splits and ablation reporting
How to separate the data used for design choices from the data used for final reporting.

- First survey which split papers in the same field report main results and ablations on, where they say values were chosen, and whether they report repeated seeds and standard deviations. If split practices are mixed within the field, numbers are hard to compare across papers, so state your split clearly in the manuscript.
- The basic principle is "choose on the validation split, report on the test split". Ablations and design choices use a validation split carved out of the training data; the final comparison uses the official test split.
- Carve the validation split out of the training data by group (same place, subject or source together) so it does not overlap the test data.
- State in the paper "design and ablations on the validation split, final comparison on the official test split", and show both split numbers side by side for the full model.
- Once this is stated, do not criticise ablation or analysis tables made on the validation split (number of looks, timing stress tests, etc.) for "not being the test split", or propose moving them to the supplement. They remain analysis tables even if they contain comparison rows.
- The two splits need not give the same numbers; after the model is fixed, check that the direction and order of component effects agree.
- Report repeated-seed means, standard deviations, paired differences and significance tests for the main table on the test split, and repeated-seed results for ablation rows on the validation split. Stating where values were chosen and the seed variance, which other papers do not report, is itself a basis for trust.

## 3. What goes in the paper
Principles for deciding what goes in the main text and what stays in internal records.

- The paper reports only adopted components and their ablations. Rows that did not improve and failed attempts are recorded only in internal documents and not used as analysis tables.
- Keep a method paper a method paper. Use failure analysis only as supporting material that explains the method; do not turn it into a diagnosis, analysis or negative-results paper.
- Main-text comparisons are between models trained on the same data. Comparisons with models trained on larger or different data go in a separate generalization table, and that table shows the effect of attaching our module to other models rather than our full system. Check that the comparison layout does not read to readers as "we lost", and present a small model approaching a large one as a strength.
- Do not drop datasets or sample groups after seeing that results are bad. Dropping them creates selection bias.
- Separate what the manuscript states from internal records. When an analysis or presentation was decided and when it was computed (including new analyses after the test split was opened) is kept only in the registration document (SDD); do not attach tags such as "post-result analysis" or "additional analysis after test" in the manuscript. A new analysis after the test, using saved predictions and runs, is not cherry-picking, so do not block it — what is blocked is picking only the good values among independent seeds, scenes or runs, and changing scenes, seeds, thresholds or splits after seeing results (00 principle 5).
- Do not split a table into groups where the comparison methods lose and bold within them (for example, grouping as "best among offline judges"). Separating same-condition comparisons into different groups reads as an unfair comparison.
- The definition of metrics and the layout of tables (which metrics in the main text, how defined, in which columns) may be chosen after seeing results. State the definitions in the manuscript and use the same definition for every comparison method.
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
- Draw the method figure as one unbroken flow in which an actual input example passes through shapes of the model's parts (encoder, tokens, the parts being trained) all the way to the loss. Do not split it into a table of text boxes or separate panels. The aim is to let the reader follow at a glance where the data goes in and what it trains.
- When a part's name is written in the method figure, check that the part's input is connected by a line or a small diagram from another element in the figure. A box with only a name makes the reader search the manuscript for "from what?", and the figure does not stand alone.
- If the researcher says a part does not show in the figure, before drawing, explain in one or two lines what the part does in the flow (input, output, what it makes compare or decide against what) and agree on which of these to show. The same remark can point to the input, the output or the role, and picking the wrong one produces a useless diagram.
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
Rules that keep the manuscript's sentences and tables consistent. For each manuscript, keep a document of fixed terminology and settled proofreading items (comments already decided and applied, each with its grounds and the condition for reopening it), and have it read before every proofreading pass by a person, an agent or a prompt. Settled items are not fixed or flagged again, and when shortening, the meaning of fixed sentences is not changed. When the method changes, first check that the old terms still match the current method.

### 5.1 Sentences
- Every claim sentence must be able to point to something that supports it (a figure in the manuscript, a citation, or a reference to the section that measures it). If none of the three exists, leave the sentence out.
- Do not use semicolons or colons in the body. Both hide logical connectives ("so", "that is", "although"), so choose a connective or split into two sentences.
- Do not use parenthetical explanations or lists introduced by a colon. Point to the supplement from only one place in the body, in one sentence (the venue requires supplementary references), and write the rest of the body so it stands alone without the supplement.
- Open each paragraph with a topic sentence that states its claim, starting with a noun-phrase subject (articles A/An/The are part of the subject, so "An error's direction decides …" is fine). Do not open a paragraph with a prepositional, adverbial or purpose phrase ("In Table 3, …", "Here, …", "To test this, we …"), a demonstrative ("This shows …"), or a quantifier such as "Each …" or "Every …". The claim, not the location or the procedure, should come in the first few words, so that a skimming reviewer catches the flow. Do not let two neighbouring sentences or paragraphs begin with the same word; allow a deliberate parallel pair at most twice. Venues set no official rule here. The basis is the topic-position principle of scientific writing (Gopen & Swan 1990). After editing a manuscript, extract each sentence's first word and compare neighbours.
- Write the method's parts as our design. Cite prior work and state only the difference ("X instead …", "extends X to …"); do not give a part's credit to prior work with phrases such as "follows X", "adopts X", "replaces X" or "deliberately small and simple". If the combination is the novelty, put the observation for why this combination at the head of the method, and state the effect larger than the sum of the parts (adding only one part does not help or hurts) with ablation numbers.
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
- In every comparison table in the body and appendix, attach a citation to each method-name cell. If only some have one, the missing sources stand out, so cite all or none; for the main comparison table, citing is the convention. Our method and simple baselines without a source get no citation. If citations make the table wider, adjust with column spacing.

### 5.3 Citations
- A citation must support the very phrase it is attached to. Do not reuse a citation from a neighboring topic.
- A name attached to a citation must be the name the cited paper uses for itself.
- Add bibliography entries only after checking authors, venue, volume, pages and DOI against the publisher's record; never fill them from memory.
- For API models, state the official system card, model id and time of use, and use the official product name so it is not confused with other models of the same generation. When correcting a name, change tables, figures and number-check files at once.
