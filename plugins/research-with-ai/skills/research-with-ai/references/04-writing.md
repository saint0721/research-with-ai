# Research with AI — Paper Writing

| Item | Content |
| --- | --- |
| Purpose | Lets you structure and write a paper with an AI agent following the principles of scientific writing, and check it against the target venue at the end, using this document alone |
| When to read | Starting to write a manuscript, setting the order of the argument and the structure, writing and fixing words, sentences, figures, tables and citations, deciding what to report and on which split, checking against the venue |
| Outputs | Primary reader, purpose and list of claims, outline mixed with sentences, manuscript, split decision record, list of results to report, venue checklist |
| Structure | §0 work order, §1–§7 methods. The writing principles summarize and follow Alley, *The Craft of Scientific Writing*, 4th ed. (2018) and Gopen & Swan (1990). Mock review and verification of a finished manuscript, and external documents, are in 06 |

## 0. Work order
The order and outputs from preparing a manuscript to finishing and checking it.

| Step | Section | Output |
| --- | --- | --- |
| Preparation | 1 Audience, purpose and claim strength | Primary reader, purpose, list of claims with their evidence and scope |
| Structure | 2 Argument order and structure | Outline mixed with sentences, numbered challenge chain |
| Evidence | 5 Honest reporting of evidence | Split decision record, list of results to report |
| Writing | 3 Words and quantities, 4 Sentences, figures, tables and citations | Manuscript |
| Revision | 6 Writing process | Revised manuscript |
| Checking | 7 Checking against the venue | Slot table per review axis, attack-point handling table |

## 1. Audience, purpose and claim strength
The principle of deciding first, before writing, who reads and why, and what is claimed. These answers set the scope, the emphasis, the order and which terms to define (Alley, ch. 1). Audience and purpose decide how the text unfolds, and the claims and their evidence decide what goes into it, so the answers of this section are written down before the outline of §2.

Pick one primary reader (e.g., a reviewer in the same field), and write down what that reader knows and why they read. Background needed by other readers goes where it does not break the flow of the body (a short definition, the appendix). Then judge whether the text informs or persuades. A paper persuades, so it states not only what and how but why, and for claims a reader is likely to doubt, it shows the evidence first and then the claim.

The unit of the text is the claim. For each claim, write down the evidence that supports it (a measurement, a figure, a citation) and the scope the evidence reaches (conditions, sample, uncertainty), and leave out any sentence that cannot point to evidence. Write what was measured, what was inferred from measurements and what is estimated separately, and do not mix concept, prediction and limitation in one sentence. Match the strength of the wording (outperforms, is comparable, may show) to the strength of the evidence, and write "outperforms" only when the paired interval excludes 0 (06 §2). For the same reason, if you know of a factor that may have contaminated the results, always state it. Honesty comes before persuasion.

## 2. Argument order and structure
The principle of arranging the whole text so the reader can follow it by anticipating what comes next from what came before (Alley, ch. 6–8). Pick one well-structured paper as a template and follow only its structure, not strong phrases such as "first" or "state of the art". Fix the frame first in the order problem and gap → question and hypothesis (falsification condition) → method → evidence → interpretation → limitations. What ties this frame together from start to end is the numbered challenge chain, and the rest of this section is placement that keeps the reader from losing that chain.

Define 2–3 challenges and number them, and repeat the same numbers and names in the abstract, Figure 1, introduction, method, ablations and conclusion. One module handles one challenge, and the module name is used as is in section titles and table column names. Repeat the key results in three places: the abstract, the body and the conclusion. The abstract states the results first and is written to stand alone using only what is in the body, and its last sentence takes up the challenges named earlier in the same order and closes with "this is how we solved them". The conclusion returns to the challenge numbers to synthesize the body's results and states the remaining limitations with numbers, bringing in no new evidence.

The following applies to the front of the text.
- The title specifies the scope (it carries the key variables or effects) rather than being short and catchy.
- Before the body, the introduction explains what was done, why it matters, what is needed to understand it and how the text unfolds. Show importance with concrete results instead of writing "it is important", and state assumptions and limitations together with the scope.
- The introduction does not give result numbers; it states what was shown in words and section references.
- The first sentence of a document or section starts from what the reader knows and takes one step toward something new. Do not open with a peripheral detail or an overly grand preamble, and announce the subsection structure at the head of a long section.
- Divide related work into subsections that expose the gap rather than listing papers, and pin down the gap in the final sentence. Criticize other work in a respectful tone.

Figure 1 shows "challenge + failure of the existing best method (with its original input) + success of our method". Comparisons whose difference is too small to see in a figure are handled by a main-text table, and the rule for picking figure examples is stated in the caption.

Draw the method figure as one unbroken flow in which an actual input example passes through shapes of the model's parts (encoder, tokens, the parts being trained) all the way to the loss. Do not split it into a table of text boxes or separate panels. The aim is to let the reader follow at a glance where the data goes in and what it trains. So when a part's name is written in the method figure, check that the part's input is connected by a line or a small diagram from another element in the figure. A box with only a name makes the reader search the manuscript for "from what?", and the figure does not stand alone. If the researcher says a part does not show in the figure, before drawing, explain in one or two lines what the part does in the flow (input, output, what it makes compare or decide against what) and agree on which of these to show. The same remark can point to the input, the output or the role, and picking the wrong one produces a useless diagram.

Order the experiment section as setup → baseline comparison → main evaluation → ablations → generalization. Start ablations with a checkmark table that turns modules on and off, then go into analysis inside the modules, and when adding a new module or input, add a row too. Show separately, in a generalization table, that the contribution is not tied to a specific model. Result sentences read the table as "which challenge's cells improved" rather than listing numbers. Keep a few numbers per paragraph and move detailed values to the appendix. Keep only what the claims need in main-text tables, and move details such as algorithm boxes to the supplementary material.

Emphasis and form follow the rules below.
- Place emphasis in the title, at the beginning and end of sections and paragraphs, and in figures.
- When adding a detail, also write why it is there so its weight is visible, and move long secondary information down to the appendix.
- Write the argument as continuous prose rather than breaking it into bullets.
- Divide the body into subsections instead of bold-lead paragraphs.
- Each time content is added to the manuscript, check the structure against the items in this section and record the result in the manuscript-revision section of the result document.

## 3. Words and quantities
The principle of keeping precision and clarity together so the reader's attention goes to the content rather than to decoding sentences (Alley, ch. 2–4). Precision comes from fixing and defining terms and stating numbers only as far as the evidence goes; clarity comes from short words with one meaning and sentences whose verbs carry the action.
- Fix one term for one concept and do not switch to synonyms. Readers read a different word as a different concept. Use the same name for the same model in all tables, body text and appendix.
- Define terms and variables once at first appearance (unit, denominator, which direction is better).
- For a ratio, state what percentage of what whole it is, and for metrics with similar names, contrast how they differ (00 §4.3).
- Pin down abstract nouns such as "method" or "criterion" at first appearance with a concrete list or example.
- Report effects with their size, interval and sample size, and do not mix percentage points with relative ratios.
- Remove exaggerating adjectives and adverbs, and use words such as "prove" or "optimal" only with rigorous grounds. One exaggeration erodes trust in the whole text.

Pick the shorter word with the same meaning, and unpack long stacked noun phrases and nominalizations that hide the verb. The force of a sentence comes from its verb; use the active voice by default and the passive only when the focus is on the object of study. Delete redundancy and empty clichés, but do not simplify the content itself.
- Replace words that can be read two ways with words that have one meaning, and put modifiers such as "only" right next to what they modify.
- If the referent of "it" is unclear even for a moment, repeat the noun, and do not use "this" alone but attach a noun.

## 4. Sentences, figures, tables and citations
Rules for linking sentences and paragraphs to the information before them, and for weaving equations, figures, tables and citations into the text (Alley, ch. 5; Gopen & Swan 1990). For each manuscript, keep a document of fixed terminology and settled proofreading items (comments already decided and applied, each with its grounds and the condition for reopening it), and have it read before every proofreading pass by a person, an agent or a prompt. Settled items are not fixed or flagged again, and when shortening, the meaning of fixed sentences is not changed. When the method changes, first check that the old terms still match the current method.

### 4.1 Sentences and paragraphs
Start each sentence with information that links to the previous sentence and put new information at the end. If the link sits at the end of a sentence, the reader has to reread. Vary sentence openings and lengths so the same pattern does not repeat, and make logical relations visible with connectives. The punctuation rules below serve the same purpose.
- Do not use semicolons or colons in the body. Both hide logical connectives ("so", "that is", "although"), so choose a connective or split into two sentences.
- Do not use parenthetical explanations or lists introduced by a colon.
- Point to the supplement from only one place in the body, in one sentence (the venue requires supplementary references), and write the rest of the body so it stands alone without the supplement.
- Set length limits for the abstract, captions, tables and body, and check word counts with a script. Information lost while shortening is not deleted but moved to the body or appendix.

The first sentence of a paragraph is a topic sentence that states the paragraph's claim, starting with a noun-phrase subject (articles A/An/The are part of the subject, so "An error's direction decides …" is fine). Do not open a paragraph with a prepositional, adverbial or purpose phrase ("In Table 3, …", "Here, …", "To test this, we …"), a demonstrative ("This shows …"), or a quantifier such as "Each …" or "Every …". The claim, not the location or the procedure, should come in the first few words, so that a skimming reviewer catches the flow. Venues set no official rule here; the basis is the topic-position principle of scientific writing (Gopen & Swan 1990).

For the same reason, do not let two neighbouring sentences or paragraphs begin with the same word; allow a deliberate parallel pair at most twice. After editing a manuscript, extract each sentence's first word and compare neighbours.

Write the method's parts as our design. Cite prior work and state only the difference ("X instead …", "extends X to …"), and do not give a part's credit to prior work with phrases such as "follows X", "adopts X", "replaces X" or "deliberately small and simple". If the combination is the novelty, put the observation for why this combination at the head of the method, and state the effect larger than the sum of the parts (adding only one part does not help or hurts) with ablation numbers.

### 4.2 Equations and figures
Weave equations and figures into the flow of the body, writing on the premise that a figure is seen before the body is read.
- Write an equation as part of a sentence. Define the dependent variable before the equation and the other variables right after it, and state why the equation is needed.
- Refer to figures by number, place them close to their first mention, and check that part names and counts match between the body and the figure.
- Match a figure's complexity to the level of the body's explanation, and move more complex figures to the appendix.
- Write captions as sentences, not "symbol: description" lists. Start with a title phrase that distinguishes the figure from the others, and write it so that what it shows and what can be learned is readable without the body. Readers look at figures and captions before the body.

### 4.3 Tables
A table is where the reader sees at a glance which row is our method and whether comparisons were made under the same conditions. The rules below are independent of each other; the citation rule applies to every comparison table, so it is placed separately at the end.
- Do not attach input conditions or training status to the model name; mark them with checkmark columns. Mark only what is on and leave what is off blank.
- Bold the best value in each column.
- Main-text tables have no difference (Δ) column; paired differences and intervals go in the appendix table and body sentences.
- Do not put two values in one cell separated by a slash.
- Do not report the same result in two tables. Split experiments of different nature (retrained ablations vs. robustness with only test-time input changes) into separate tables.
- Divide per-condition comparisons with left row groups and separator lines, and order rows within a group by improving score so our method is at the bottom.
- Report each baseline with the strongest setting measured. If our method appears to get favorable input or training, give the baseline the same setting.
- Keep only the rows and columns supporting the claims in main-text tables, and move internal variants and auxiliary columns to the full appendix table.

In every comparison table in the body and appendix, attach a citation to each method-name cell. If only some have one, the missing sources stand out, so cite all or none; for the main comparison table, citing is the convention. Our method and simple baselines without a source get no citation. If citations make the table wider, adjust with column spacing.

### 4.4 Citations
Check both that a citation actually supports the claim where it is attached and that its bibliographic data match the original.
- A citation must support the very phrase it is attached to. Do not reuse a citation from a neighboring topic.
- A name attached to a citation must be the name the cited paper uses for itself.
- Add bibliography entries only after checking authors, venue, volume, pages and DOI against the publisher's record; never fill them from memory.
- For API models, state the official system card, model id and time of use, and use the official product name so it is not confused with other models of the same generation.
- When correcting a name, change tables, figures and number-check files at once.

## 5. Honest reporting of evidence
The principle of deciding what is reported on which data and what goes in the paper, so the manuscript's numbers show the evidence honestly. It has two axes: separating where numbers are chosen from where they are reported (§5.1), and dividing what goes into the manuscript from what stays only in internal records (§5.2).

### 5.1 Evaluation splits and ablation reporting
The basic principle is "choose on the validation split, report on the test split". Ablations and design choices use a validation split carved out of the training data; the final comparison uses the official test split. Only if the test split is not used for choosing do the final numbers read as reported results rather than chosen ones.

Decide and report splits in the following order.
1. First survey which split papers in the same field report main results and ablations on, where they say values were chosen, and whether they report repeated seeds and standard deviations. If split practices are mixed within the field, numbers are hard to compare across papers, so state your split clearly in the manuscript.
2. Carve the validation split out of the training data by group (same place, subject or source together) so it does not overlap the test data.
3. State in the paper "design and ablations on the validation split, final comparison on the official test split", and show both split numbers side by side for the full model.
4. The two splits need not give the same numbers; after the model is fixed, check that the direction and order of component effects agree.

- Once this is stated, do not criticise ablation or analysis tables made on the validation split (number of looks, timing stress tests, etc.) for "not being the test split", or propose moving them to the supplement. They remain analysis tables even if they contain comparison rows.
- Report repeated-seed means, standard deviations, paired differences and significance tests for the main table on the test split, and repeated-seed results for ablation rows on the validation split. Stating where values were chosen and the seed variance, which other papers do not report, is itself a basis for trust.

### 5.2 What goes in the paper
The manuscript carries only what is needed to show the adopted method in a fair comparison, and the rest of the process stays in internal records. What is left out must not become a choice made by looking at results, though, so the rules below separate what may be left out from what may not.
- The paper reports only adopted components and their ablations. Rows that did not improve and failed attempts are recorded only in internal documents and not used as analysis tables.
- Keep a method paper a method paper. Use failure analysis only as supporting material that explains the method; do not turn it into a diagnosis, analysis or negative-results paper.
- Do not drop datasets or sample groups after seeing that results are bad. Dropping them creates selection bias.
- Do not split a table into groups where the comparison methods lose and bold within them (for example, grouping as "best among offline judges"). Separating same-condition comparisons into different groups reads as an unfair comparison.
- The definition of metrics and the layout of tables (which metrics in the main text, how defined, in which columns) may be chosen after seeing results. State the definitions in the manuscript and use the same definition for every comparison method.

Main-text comparisons are between models trained on the same data. Comparisons with models trained on larger or different data go in a separate generalization table, and that table shows the effect of attaching our module to other models rather than our full system. Check that the comparison layout does not read to readers as "we lost", and present a small model approaching a large one as a strength.

Separate what the manuscript states from internal records. When an analysis or presentation was decided and when it was computed (including new analyses after the test split was opened) is kept only in the registration document (SDD); do not attach tags such as "post-result analysis" or "additional analysis after test" in the manuscript. A new analysis after the test, using saved predictions and runs, is not cherry-picking, so do not block it — what is blocked is picking only the good values among independent seeds, scenes or runs, and changing scenes, seeds, thresholds or splits after seeing results (00 principle 5).

Split "we did not do X" sentences into two.
- **Limitation**: a deliberately chosen scope or a weakness confirmed by experiment. Write it in the limitations section as is.
- **Preparation gap**: something that could have been done but has not been yet (e.g., running fewer repeats for the comparison methods only). Do not leave it in the manuscript as "not measured"; fill it with an experiment before freezing, or redefine the scope and record that decision.

Name the type of contribution precisely. A structural change that remains at inference is an architectural contribution; a module or loss attached only during training is a training-method contribution. If the inference network is the same, do not write "new architecture". Present a training-method contribution with the strength "improves at no inference cost". Either way, prove a contribution with an ablation row that differs only in that component, with the same architecture and the same data. Components that did not meet the adoption criteria are not listed as contributions.

## 6. Writing process
How to write a manuscript in the stages of preparation, first draft, revision and finishing (Alley, ch. 10). Each stage works on units of a different size, so follow the order below without postponing what an earlier stage should decide or pulling a later stage's polishing forward.
1. Preparation: first make an outline mixed with sentence fragments that includes the scope, limitations and an announcement of the structure, and agree on it with the researcher. Put the audience, purpose and claims from §1 and the order from §2 into this outline.
2. First draft: write through to the end without breaking the flow. Do not stop to polish wording.
3. Revision: fix large blocks (the order of sections and paragraphs) first and sentences later. Hold a separate pass that looks only for ambiguity, and reread with time between passes or in a changed format (the built PDF, reading aloud). Do not defend against criticism; judge whether to accept it (06 §1).
4. Finishing: correct errors only, not improvements. Do not shake up the structure again at this stage.

- If the abstract summarizes the results, write it last, drawing on the key sentences of the finished body.
- When several people or workers write together, gather ideas at the outline stage, and one lead author (the leader) is responsible for continuity of style (05 §1.4).

## 7. Checking against the venue
How to check a finished manuscript against the target venue's author guidelines and review criteria. The criteria that guide the writing are §1–§6; this section is the final check. Mock review (06 §1) comes after this check. The core of the check is recording, for each review axis, whether the manuscript has a place that supports it, and how each expected attack point was handled.

Start the check in the following order.
1. Compare a few papers in the same field published in the target venue or journal to check conventions for the number of modules, datasets and experimental conditions, and align the manuscript's composition.
2. Summarize the target venue's author guidelines and reviewer guidelines (the evaluation axes and score definitions of the review form) together with the date they were read, and for each axis check that there is a place in the manuscript that supports it.

| Review axis | Where the manuscript supports it |
| --- | --- |
| Novelty | The gap sentence at the end of related work, the "why this combination" observation and ablation numbers at the head of the method |
| Significance | The problem and challenges in the introduction, Figure 1 |
| Quality | Fair comparison conditions, paired intervals, honest reporting of failures and limitations |
| Clarity | One or two sentences of background for readers outside the field, abbreviations spelled out at first use, figures and tables that stand alone |

Make a list of expected attack points and handle each in one of three ways: the evidence exists but is not visible enough in the body → bring that evidence up into the body; a deliberately chosen scope → write it in the limitations section; an experiment is needed → send it to the design document and register it before results. Keep the handling result and where it was applied in the manuscript in the same document.
- Tag each proofreading comment with the name of a review axis (overclaiming, clarity, novelty etc.), so it is visible which axis the sentence weakens.
- For the title and contribution sentences, write side by side for each candidate what it promises and whether the manuscript supports that promise, and let the researcher choose.
- What the guidelines fix in form (position and content of the AI-use disclosure, supplementary references, anonymity, rebuttal rules) is written in the guidelines' own wording, and items whose violation leads to rejection go into the submission-requirements table (06 §2).
- Use an experiment-reporting checklist to confirm that splits, hyperparameter search ranges, number of runs and error bars, execution environment and code version, and the leakage checklist (03 §10) all appear in the manuscript or supplement (Pineau et al., JMLR 2021).
