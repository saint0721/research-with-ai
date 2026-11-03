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
| Judgment | 3 Questions and judgment rules | Questions per axis and falsification conditions, pre-registration document |
| Prior work | 4 Surveying prior work | Coverage table, saturation/gap map, reading-depth marks |
| Contribution | 5 Gaps and novelty | Novelty judgment per module, claim sentence, target, fallback if it fails |

## 1. Narrowing the topic
How to narrow an idea into a research topic. The point is not to get many ideas from the AI but to filter the ideas received against criteria.

- Asking the AI "what is missing from my design against the target standard" works better than "give me ideas". Vague requests tend to produce plausible proposals that repeat existing work.
- Filter topic candidates by three criteria.
  - Can the experiment be done with the data and compute available?
  - Does it make a paper in the target field? If it drifts into the language of the application field, the methodological contribution weakens.
  - Does it keep improving as data, compute and model size grow, rather than only with the label ratio?
- Large measures that change the whole character of the study are not mixed into the current study; they are postponed to the next study or decided by the researcher.
- For proposals that look new, first check whether they already exist in your own or your lab's earlier work. The AI tends to propose the same idea as new without knowing earlier work.
- When two or more studies are entangled, postpone thinking about how they connect and write the boundary into the project instructions. Without a boundary, the agent mixes the two studies in its proposals.
- If what to measure is unclear, design the situation first before repeating measurements. The order is design the situation → generate it directly → check by eye → scale up. Repeating measurements without a situation piles up failures without revealing the cause.
- Put task difficulty not at the two extremes (cases anyone gets right, cases nobody can get right for lack of information) but in the middle band where judgments diverge. At the extremes, differences between methods do not show.
- Reverse-analyze good papers for how the idea was obtained rather than for the results. Reconstruct it in the order weak link of the latest method → standard model from a neighboring field → prediction of where the gain is largest → ablation that rules out other explanations, keep it as a `step / what was done / trace left in the paper` table, and apply the same process to your own problem.
- Get the AI's explanation first and defer the decision. Align understanding with "I understood that ~. So does that mean ~?" before deciding.

## 2. Deriving a method from the problem
A 7-step procedure for deriving a method (module) from a measured failure. Organized from the research-methodology literature ([Hamming, "You and Your Research"](https://www.cs.virginia.edu/~robins/YouAndYourResearch.html), [Heilmeier Catechism](https://www.darpa.mil/about/heilmeier-catechism), [Black, "Novelty in Science"](https://perceiving-systems.blog/en/news/novelty-in-science), [Lipton·Steinhardt, "Troubling Trends in ML Scholarship"](https://arxiv.org/abs/1807.03341), [J.-B. Huang's research tips](https://github.com/jbhuang0604/awesome-tips), [RegNet](https://arxiv.org/abs/2003.13678), [Simple Baselines](https://arxiv.org/abs/1804.06208)) and the common shape of major papers.

### 2.1 Seven steps
| Step | What the AI does | Check question | Output | Source |
| --- | --- | --- | --- | --- |
| ① Choose the problem | For each candidate problem, summarize the current solution, its limits, and whether there is a means of attack (available data, compute, observations) | Is it important, and is there a means of attacking it now? How is it solved today and what are the limits? | One-sentence problem definition | Hamming, Heilmeier Q1–Q2 |
| ② Find where it fails | Run the strongest current method (baseline) directly, measure where it is wrong, and sort the errors by type | Where and how much does the strongest baseline fail? | Failure measurement table | J.-B. Huang ("stress-test the state of the art to find where it fails") |
| ③ Name the cause | Summarize the failure as one named cause and write down the assumption it breaks | Which assumption breaks and causes the failure? Does changing the problem slightly solve it? | One-sentence cause hypothesis | J.-B. Huang (relaxing and adding assumptions), Hamming (changing the problem slightly) |
| ④ Minimal intervention | Propose 2–3 interventions targeting only that cause and recommend the simplest | Does a simpler method give the same effect? | Numbered intervention candidates | Black (simplicity is not lack of novelty), Simple Baselines |
| ⑤ Success test | Before results, write interim and final judgment criteria and falsification conditions in a pre-registration document | What result means success, and what result means it is wrong? | Pre-registration document | Heilmeier Q8 (mid-term and final exams) |
| ⑥ Separate the source of gains | Plan one ablation row per claim, a control matched in compute and tuning, and a measurement of the mechanism | Did the gain come from the intervention or from compute and tuning? | Ablation plan, in-training measurement items | Lipton·Steinhardt (criticism of not identifying sources of gains) |
| ⑦ Explore the design space (optional) | After the intervention shows an effect, vary a few key values to see whether the design works over a wide range | Where is this method in the design space; does it work only at one point? | Control-variable sweep results | RegNet (looking at design spaces) |
- ①–④ are used when proposing candidates in the design conversation (03 Ch. 1), ⑤⑥ in the design document and experiment preparation (03 1.7, Ch. 5, Ch. 8), and ⑦ when choosing the next row after judgment (03 Ch. 9).
- Do ⑦ only after the intervention beats the baseline. Exploring the design space of an intervention without effect only costs.
- When the conditions change or the direction is reset from scratch, settle ① problem choice (the research question sentence) again with the researcher first. Use ② failure measurement to test the premises of the chosen question; do not let measurement results choose the question instead. Even for a request like "let's re-measure the problem", first present question candidates and their grounds, get confirmation, then measure.

### 2.2 Common shape of good papers
Decomposing several representative papers in the same field with a `observation shown first / cause and module / ablation` frame shows the following shape repeatedly.

- The failure of a strong baseline is shown first, in Figure 1 or Table 1.
- The causes are narrowed to one or two.
- One module per cause and one ablation row per module, with one control-variable sweep that tests the mechanism, plus a control showing the gain does not come merely from more compute.
- The recurring weakness is claiming a hypothesized mechanism without measuring it, which is the first point reviewers attack. So plan a device that measures the mechanism directly at the design stage.

## 3. Questions and judgment rules
Rules to prevent moving criteria after seeing results. The AI naturally proposes changing criteria to fit results, so the key is to fix the rules in a document first.

- Split the question into 2–4 axes and write for each axis what result would show it is wrong (falsification condition).
- Fix data splits, thresholds, prompts and evaluation targets before seeing results. Do not change a verdict once obtained (including FAIL); a re-measurement with a larger sample is split into a new plan and approved.
- When a hypothesis is rejected, do not change the analysis to defend the claim; change the question honestly.
- If the sample per condition is small (roughly under 30), lower the claim scope to "case report" before results.
- During development, adopt a change if it improves over the previous step with one seed, and do multi-seed repeats after the model is fixed. Requiring multiple seeds at every step slows development and leads to changing direction on every small result.
- Pre-measurement without training is not used to choose candidates. It is used only to stop, after the design is fixed, when a premise turns out to be absent.
- Keep a judgment metric once fixed. Each change of metric definition breaks comparison with earlier results. Classes or metrics that swing strongly with chance are removed from judgment and kept as guards that only check for drops.
- Keep the sentence a human approved verbatim in the decision table. It becomes the reference when the grounds and scope of a decision are disputed later.

## 4. Surveying prior work
How to widen the scope of prior work, how to check and record what was read, and how to state the differences.

### 4.1 Widening the scope
- **Coverage table**: split the idea into 3–5 elements and mark covered, partial or absent in a `paper × element` table. Looking at prior work per element allows judgments such as "absent as a whole, but every part exists".
- **Saturation/gap map**: group methods of the last 3–4 years into mechanism families and mark each family saturated, sparse or no prior work. Rank gap candidates also by how well they fit your own measurements. A phenomenon that no one treats as a problem, once confirmed by measurement, is the strongest gap candidate.
- **Limits stated by prior work**: collect what recent papers themselves state as limitations, and pick those still open in your setting.
- **Target-venue comparison**: read papers in the same field from the target venue in full and organize them in the same frame `problem / method / network / data / comparisons / reported margin / experiment setup`. This reveals the experiment setup and comparison practice the venue expects (e.g. whether seed repeats and spread are reported).
- **Source of large gains**: check what methods with large gains gained from, and whether that means is within your study's constraints. If large gains come mostly from means outside the constraints, write that down and leave the decision to the researcher.
- **Threatening papers**: collect papers with results unfavorable to your idea separately, and plan experiments that test them head-on.
- **Practice survey**: "how do other papers do it" is run as a separate survey checked against full texts, and used as grounds for experiment design decisions.

### 4.2 Checking and recording
- Match every paper's title, first author, year and venue on the original page. Bibliographies made by AI can be plausibly wrong.
- Mark the reading depth for each item (full text, abstract, search summary, title), and keep a list of items to re-check in full text before writing the manuscript. For items whose full text could not be accessed (e.g. bot blocking), note that fact and the reading depth in the table.
- Judge the closest prior work used for pre-emption and novelty judgments only after reading the full text (method section and experimental setup). Put "for the closest prior work, open the full text, read the method section and record which sections you read" into research-agent instructions; mark judgments made at abstract level as provisional and re-judge after reading the full text. Record what was read in the full text (sections read, mechanism, relevant numbers, what it means for our candidate) per paper in the prior-work document, and have agents write that document too.
- Before using a prior method's mechanism as grounds, check in the public code that it actually works that way. A schedule or device described in a paper sometimes does not actually work because of how the code processes it, and judgments that trusted only the description must be corrected.
- When comparing code or equations, use the original repository and the paper's equations, not a copy modified by someone else. Judging "matches" against a modified copy can make the ported technique fail entirely in training.
- Do the broad first-pass survey with a low-cost model, and re-check key references by DOI and original text.
- Put a sentence forbidding personal information (email etc.) into survey agent instructions. Some search APIs take contact details as request arguments, and an agent may insert an email address.

### 4.3 Stating the differences
- If prior work already uses the same ingredient, move the difference from "whether it is used" to "how it is used".
- Document prior work that will not be claimed as novelty in a separate list. Use it as is in the related-work section and in review responses.

## 5. Gaps and novelty
How to decide what to claim as the contribution, where to aim, and how to prepare for failure. The criterion is "does it explain and reduce a measured failure" rather than "is it absent from prior work".

### 5.1 Judging novelty
- Before proposing a new direction, check the log, decision records and rejection list for directions already closed. When citing the grounds for a closure, also note the conditions under which the result was measured. The AI tends to re-propose closed directions under new names.
- Judge each module as "new mechanism / new combination of known parts / not claimable", and write the single most defensible claim sentence together with the control experiments that claim needs. If every part has prior work, claim not the novelty of parts but a combination such as "using the same principle consistently in several places against one measured failure". Update the judgment after reading unverified full texts.
- Build the contribution on a failure confirmed by measurement, not on a technique. Making a specific technique the topic turns it into a technique-comparison paper. When the AI drifts toward a specific technique, bring it back to the axis of the design.
- Keep growing the methodological contribution regardless of venue level. Do not stop at narrow novelty plus experiments.
- Include in the experiment design a measurement of whether the claimed mechanism actually occurs.
- Re-judge each contribution after some time, against the full text, as keep, soften wording or withdraw. It is normal for claims to shrink and harden through review; reducing the claim to a simple method and an honest benchmark is rewarded with reproducible results.

### 5.2 Choosing the target
- First measure where errors actually concentrate, then choose the target. A target chosen by intuition often has errors concentrated in it but no signal to fix them, so check both concentration and signal.
- Choose the target by the "recoverable share" rather than the absolute amount of error. The error that shrinks when labels increase is the share a method can recover; error that does not shrink with more labels is likely a limit of the input information.
- Split wrong cases into "right under other conditions (hard)" and "wrong under every condition (unknown)". Many hard cases point to better use of what is there; many unknown cases point to growing the information or representation.

### 5.3 Comparison and fallback
- Match resources (number of labels, compute budget) with the baseline, but not each method's own devices. Document how they were matched and what was checked.
- Write down in advance what will be submitted if the new method fails. With a fallback fixed, the pressure to move criteria after a failure decreases.
