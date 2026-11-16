# Research with AI — Topic, Question, Prior Work, Gap

| Item | Content |
| --- | --- |
| Purpose | Using only this document, choose a research topic with AI agents, derive a method, set questions and judgment rules, and check prior work and gaps |
| When to read | When choosing a new topic, deriving a method from a measured failure, setting judgment criteria, surveying prior work or judging novelty, choosing the next target |
| Output | One-sentence problem definition, cause hypothesis and intervention candidates, questions per axis with falsification conditions, pre-registration document, prior-work coverage table, novelty judgment per module and claim sentence |
| Structure | Ch. 0 work order, Ch. 1–5 methods |

## 0. Work order
The steps from topic to the contribution to claim, and the output of each step.

| Step | Chapter | Output |
| --- | --- | --- |
| Topic | 1 Narrowing the topic | One-sentence problem definition, list of missing parts |
| Method derivation | 2 Deriving a method from the problem | One cause hypothesis, minimal intervention candidates |
| Judgment | 3 Questions and judgment rules | Questions per axis, falsification conditions and out-of-scope items, task definition, pre-registration document |
| Prior work | 4 Surveying prior work | Coverage table, saturation/gap map, reading-depth marks |
| Contribution | 5 Gaps and novelty | Novelty judgment per module, claim sentence, target, fallback if it fails |

## 1. Narrowing the topic
How to narrow an idea into a research topic. The point is not to get many ideas from the AI but to filter the ideas received against criteria. Asking the AI "what is missing from my design against the target standard" works better than "give me ideas". Vague requests tend to produce plausible proposals that repeat existing work.

Filter topic candidates by three criteria.
- Can the experiment be done with the data and compute available?
- Does it make a paper at the target venue? First set a few fit criteria for the research that venue accepts (e.g. is it a new problem, is there a controlled evaluation, are method and application present together), agree on them with the researcher, and filter by them. If it drifts into the language of the application field, the methodological contribution weakens.
- Does it keep improving as data, compute and model size grow, rather than only with the label ratio?

After filtering, apply the rules below to the remaining candidates.
- Large measures that change the whole character of the study are not mixed into the current study; they are postponed to the next study or decided by the researcher.
- For proposals that look new, first check whether they already exist in your own or your lab's earlier work. The AI tends to propose the same idea as new without knowing earlier work.
- When two or more studies are entangled, postpone thinking about how they connect and write the boundary into the project instructions. Without a boundary, the agent mixes the two studies in its proposals.
- Put task difficulty not at the two extremes (cases anyone gets right, cases nobody can get right for lack of information) but in the middle band where judgments diverge. At the extremes, differences between methods do not show.
- Get the AI's explanation first and defer the decision. Align understanding with "I understood that ~. So does that mean ~?" before deciding.

If what to measure is unclear, design the situation first before repeating measurements. The order is design the situation → generate it directly → check by eye → scale up. Repeating measurements without a situation piles up failures without revealing the cause.

Reverse-analyze good papers for how the idea was obtained rather than for the results. Reconstruct it in the order weak link of the latest method → standard model from a neighboring field → prediction of where the gain is largest → ablation that rules out other explanations, keep it as a `step / what was done / trace left in the paper` table, and apply the same process to your own problem.

## 2. Deriving a method from the problem
A 7-step procedure for deriving a method (module) from a measured failure. Organized from the research-methodology literature ([Hamming, "You and Your Research"](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black, "Novelty in Science"](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton·Steinhardt, "Troubling Trends in ML Scholarship"](https://arxiv.org/abs/1807.03341), [J.-B. Huang's research tips](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208)) and the common shape of major papers. §2.1 covers what to do and produce at each step; §2.2 covers the shape that recurs in representative papers.

### 2.1 Seven steps
The table below gives, for each step, what the AI does, the check question, the output and the source. ①–④ are used when proposing candidates in the design conversation (03 §1), ⑤⑥ in the design document and experiment preparation (03 §1.6, Ch. 5, Ch. 8), and ⑦ when choosing the next row after judgment (03 §9).

| Step | What the AI does | Check question | Output | Source |
| --- | --- | --- | --- | --- |
| ① Choose the problem | For each candidate problem, summarize the current solution, its limits, and whether there is a means of attack (available data, compute, observations) | Is it important, and is there a means of attacking it now? How is it solved today and what are the limits? | One-sentence problem definition | Hamming, Heilmeier Q1–Q2 |
| ② Find where it fails | Run the strongest current method (baseline) directly, measure where it is wrong, and sort the errors by type | Where and how much does the strongest baseline fail? | Failure measurement table | J.-B. Huang ("stress-test the state of the art to find where it fails") |
| ③ Name the cause | Summarize the failure as one named cause and write down the assumption it breaks | Which assumption breaks and causes the failure? Does changing the problem slightly solve it? | One-sentence cause hypothesis | J.-B. Huang (relaxing and adding assumptions), Hamming (changing the problem slightly) |
| ④ Minimal intervention | Propose 2–3 interventions targeting only that cause and recommend the simplest | Does a simpler method give the same effect? | Numbered intervention candidates | Black (simplicity is not lack of novelty), Simple Baselines |
| ⑤ Success test | Before results, write interim and final judgment criteria and falsification conditions in a pre-registration document | What result means success, and what result means it is wrong? | Pre-registration document | Heilmeier Q8 (mid-term and final exams) |
| ⑥ Separate the source of gains | Plan one ablation row per claim, a control matched in compute and tuning, and a measurement of the mechanism | Did the gain come from the intervention or from compute and tuning? | Ablation plan, in-training measurement items | Lipton·Steinhardt (criticism of not identifying sources of gains) |
| ⑦ Explore the design space (optional) | After the intervention shows an effect, vary a few key values to see whether the design works over a wide range | Where is this method in the design space; does it work only at one point? | Control-variable sweep results | RegNet (looking at design spaces) |

Do ⑦ only after the intervention beats the baseline. Exploring the design space of an intervention without effect only costs.

The intervention in ④ does not stop at a rule that accepts or rejects predictions (pixels, samples) by a signal. A rule is judged only by precision and cannot turn a wrong answer into a right one, so the score has a ceiling. Build it in the order signal → correcting device → a theory of why that device corrects errors during training. Do not discard earlier failed approaches (accept/reject rules, other answer sources, etc.); keep them as contrast rows in the ablation. The difference between a failed approach and the new device becomes the analysis of why the correction works.

For the theory of the correcting device, rather than proving something new, restate the assumptions of an existing theory (for example, the correction conditions of self-training) in the terms of your own setting, and measure each assumption against a criterion written before the results. Assumptions that hold fix where the device goes; candidates that rely on an assumption that fails are closed. In the paper, write it not as a theorem but as "theory-grounded design + assumption measurements + mechanism measurements".

When the conditions change or the direction is reset from scratch, settle ① problem choice (the research question sentence) again with the researcher first. Use ② failure measurement to test the premises of the chosen question; do not let measurement results choose the question instead. Even for a request like "let's re-measure the problem", first present question candidates and their grounds, get confirmation, then measure.

### 2.2 Common shape of good papers
Decomposing several representative papers in the same field with a `observation shown first / cause and module / ablation` frame shows the following shape repeatedly.
- The failure of a strong baseline is shown first, in Figure 1 or Table 1.
- The causes are narrowed to one or two.
- One module per cause and one ablation row per module, with one control-variable sweep that tests the mechanism, plus a control showing the gain does not come merely from more compute.

The recurring weakness is claiming a hypothesized mechanism without measuring it, which is the first point reviewers attack. So plan a device that measures the mechanism directly at the design stage.

## 3. Questions and judgment rules
Rules to prevent moving criteria after seeing results. The AI naturally proposes changing criteria to fit results, so the key is to fix the rules in a document first. They are ordered as rules for setting questions, what to fix before results, and what to keep after results.
- Split the question into 2–4 axes and write for each axis what result would show it is wrong (falsification condition).
- In the question document, also write what the question does not cover (out of scope).

When building a new task or benchmark, write the task definition together with the questions: the ground-truth criterion (a criterion that can be judged, such as whether a person can tell the cases apart), the layers of labels (fixed automatically, automatic criteria, human labels), the cases excluded from scope and why, and the judgment of whether existing data can be used as is. If the ground-truth criterion is vague, even when results come out you cannot say what was gotten right.

The rules fixed before results and kept after results are as follows.
- Fix data splits, thresholds, prompts and evaluation targets before seeing results.
- Do not change a verdict once obtained (including FAIL); a re-measurement with a larger sample is split into a new plan and approved.
- If the sample per condition is small (roughly under 30), lower the claim scope to "case report" before results.
- Keep a judgment metric once fixed. Each change of metric definition breaks comparison with earlier results.
- Classes or metrics that swing strongly with chance are removed from judgment and kept as guards that only check for drops.
- When a hypothesis is rejected, do not change the analysis to defend the claim; change the question honestly.
- Keep the sentence a human approved verbatim in the decision table. It becomes the reference when the grounds and scope of a decision are disputed later.
- For the adoption criterion during development and when to run multiple seeds, follow 03 §7.1 and §9.2; for the use of pre-measurements without training, follow 03 §9.4.

## 4. Surveying prior work
How to widen the scope of prior work, how to check and record what was read, and how to state the differences. §4.1 covers what to look for, §4.2 how deeply to check and record what was found, and §4.3 how to state the remaining differences.

### 4.1 Widening the scope
The lines for widening the scope are below; each applies independently of the others.
- **Coverage table**: split the idea into 3–5 elements and mark covered, partial or absent in a `paper × element` table. Looking at prior work per element allows judgments such as "absent as a whole, but every part exists".
- **Saturation/gap map**: group methods of the last 3–4 years into mechanism families and mark each family saturated, sparse or no prior work. Rank gap candidates also by how well they fit your own measurements. A phenomenon that no one treats as a problem, once confirmed by measurement, is the strongest gap candidate.
- **Limits stated by prior work**: collect what recent papers themselves state as limitations, and pick those still open in your setting.
- **Target-venue comparison**: read papers in the same field from the target venue in full and organize them in the same frame `problem / method / network / data / comparisons / reported margin / experiment setup`. This reveals the experiment setup and comparison practice the venue expects (e.g. whether seed repeats and spread are reported).
- **Source of large gains**: check what methods with large gains gained from, and whether that means is within your study's constraints. If large gains come mostly from means outside the constraints, write that down and leave the decision to the researcher.
- **Threatening papers**: collect papers with results unfavorable to your idea separately, and plan experiments that test them head-on. Once the claim is set, write in the survey document in advance a list to search again just before submission (new versions of the threatening papers, acceptance lists of related conferences, open-review sites, new postings of the last few weeks and the search terms for them), and search again by that list before submitting.
- **Practice survey**: "how do other papers do it" is run as a separate survey checked against full texts, and used as grounds for experiment design decisions.
- **Principle and parts survey**: separately from the novelty check ("does it already exist?"), before assembling a method survey "what was built and how, why it works, and where it fails" along three lines: theory (the conditions under which the mechanism holds), a parts map (a `paper × part` table), and failures and limits (failure reports for the same parts). Gather the three on one page and propose assembly candidates.

### 4.2 Checking and recording
Match every paper's title, first author, year and venue on the original page. Bibliographies made by AI can be plausibly wrong. So check not only the bibliography but also the content and code against the original, and record how deeply each was checked.
- Mark the reading depth for each item (full text, abstract, search summary, title), and keep a list of items to re-check in full text before writing the manuscript. For items whose full text could not be accessed (e.g. bot blocking), note that fact and the reading depth in the table.
- Do the broad first-pass survey with a low-cost model, and re-check key references by DOI and original text.
- In the survey document, record the search terms, where you searched and the search date. When searching again later, this separates what is new.
- Put a sentence forbidding personal information into survey agent instructions (05 §5).

Judge the closest prior work used for pre-emption and novelty judgments only after reading the full text (method section and experimental setup). Put "for the closest prior work, open the full text, read the method section and record which sections you read" into research-agent instructions; mark judgments made at abstract level as provisional and re-judge after reading the full text. Record what was read in the full text (sections read, mechanism, relevant numbers, what it means for our candidate) per paper in the prior-work document, and have agents write that document too.

When using or porting prior work as grounds, compare not only the paper's description but also the code.
- Before using a prior method's mechanism as grounds, check in the public code that it actually works that way. A schedule or device described in a paper sometimes does not actually work because of how the code processes it, and judgments that trusted only the description must be corrected.
- When comparing code or equations, use the original repository and the paper's equations, not a copy modified by someone else. Judging "matches" against a modified copy can make the ported technique fail entirely in training.
- When using another study's training settings (epochs, batch, selection criterion) as grounds for comparison, check the units in the code (e.g. what one epoch is a pass over) and convert to a common unit such as total steps or samples seen before stating them. Numbers with the same name can differ several-fold in actual size.

### 4.3 Stating the differences
Rules for where to place the difference when prior work uses the same ingredient or appeared at the same time, and how to state it in the related work.
- If prior work already uses the same ingredient, move the difference from "whether it is used" to "how it is used".
- Document prior work that will not be claimed as novelty in a separate list. Use it as is in the related-work section and in review responses.
- Classify work first made public after a reference date (e.g. some months before submission) separately as concurrent work, and say so in the related work. Do not contest novelty against it by the same standard as earlier prior work.

## 5. Gaps and novelty
How to decide what to claim as the contribution, where to aim, and how to prepare for failure. The criterion is "does it explain and reduce a measured failure" rather than "is it absent from prior work". §5.1 covers judging the contribution, §5.2 choosing the target, and §5.3 comparison and fallback on failure.

### 5.1 Judging novelty
Judge each module as "new mechanism / new combination of known parts / not claimable", and write the single most defensible claim sentence together with the control experiments that claim needs. If every part has prior work, claim not the novelty of parts but a combination such as "using the same principle consistently in several places against one measured failure". Update the judgment after reading unverified full texts.
- First check whether the direction is closed (00 principle 4), and when citing the grounds for a closure, also note the conditions under which the result was measured.
- Build the contribution on a failure confirmed by measurement, not on a technique. Making a specific technique the topic turns it into a technique-comparison paper. When the AI drifts toward a specific technique, bring it back to the axis of the design.
- Keep growing the methodological contribution regardless of venue level. Do not stop at narrow novelty plus experiments.
- Include in the experiment design a measurement of whether the claimed mechanism actually occurs.
- Re-judge each contribution after some time, against the full text, as keep, soften wording or withdraw. It is normal for claims to shrink and harden through review; reducing the claim to a simple method and an honest benchmark is rewarded with reproducible results.

When the researcher chooses assembly-style novelty, build the method as linear research that stacks borrowed parts one row at a time. Each part may come from other studies or other fields (medical imaging, video, point clouds, etc.), and for each part write down which measured problem it was borrowed to target. Novelty rests not on any single part but on the problem → part mapping and the combination. Prior work on a part, or its earlier closure on a different base, is no reason to drop it from the assembly candidates. Record the closure with its conditions in the design document, though, and measure again on the current base.

### 5.2 Choosing the target
Choose the target not where errors are many, but in the share where errors concentrate, a signal to fix them exists, and a method can recover them. The rules below confirm those three conditions by measurement.
- First measure where errors actually concentrate, then choose the target. A target chosen by intuition often has errors concentrated in it but no signal to fix them, so check both concentration and signal.
- Choose the target by the "recoverable share" rather than the absolute amount of error. The error that shrinks when labels increase is the share a method can recover; error that does not shrink with more labels is likely a limit of the input information.
- Split wrong cases into "right under other conditions (hard)" and "wrong under every condition (unknown)". Many hard cases point to better use of what is there; many unknown cases point to growing the information or representation.
- For the problem statement, first reproduce by measurement the problem statements of your own earlier paper and the comparison papers, and develop from what holds.

Before designing a part around a phenomenon attributed to "too few labels", first measure, on a model trained with the same recipe on many labels (all of them if possible), whether the phenomenon disappears and what the error shrank through. If it is the same with many labels, the phenomenon is not a defect of label scarcity, and the part should target what actually changes when labels are many.

Set the target as a property of the data or model (boundaries, object size, context dependence, confident errors, etc.), and use the most-confused class pair only as an example. A module and judgment tuned to one pair mix in shares that cannot be measured, such as label ambiguity, shifting between pairs, and single-seed noise.

Write the research question in the terms of the problems and improvement methods set by the base method's lineage (the base paper and the papers that followed it). Show by measurement the share the lineage leaves, and pick as the target the part of it that can be fixed in principle. A question built on a privately defined error taxonomy is hard for reviewers to place, and its comparison tables drift outside the lineage.

### 5.3 Comparison and fallback
Fix the comparison conditions against the baseline and the fallback on failure before seeing results, and keep them in a document.
- Match resources (number of labels, compute budget) with the baseline, but not each method's own devices. Document how they were matched and what was checked.
- When surveying prior work, also note whether public code and weights exist, and from that make a list of baseline candidates that can be rerun under our protocol. Prior work without code is kept separately as comparisons that only cite numbers.
- Write down in advance what will be submitted if the new method fails. With a fallback fixed, the pressure to move criteria after a failure decreases.
