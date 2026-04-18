You: 

we are running an ISC anlysis and we are discussing what nuances regressors we should include before running the ISC. What is considered to be the best standard and what would you recommentd?

ChatGPT: 

Great question—and one where practices vary quite a bit across labs, especially depending on whether the ISC is meant to capture *maximal shared signal* vs *specific shared signal after controlling for confounds*. I’ll try to give you both the **current “standard” baseline** and then **recommendations tailored to your type of naturalistic/empathy work**.

---

# 1) What is the “standard” preprocessing before ISC?

Across most ISC papers (e.g., Uri Hasson; Janice Chen; Christopher Baldassano), there is a fairly consistent minimal pipeline:

### Core preprocessing (almost always done)

-   Motion correction
    
-   Slice timing correction (optional but common)
    
-   Spatial normalization (MNI or surface-based)
    
-   Spatial smoothing (moderate; e.g., 4–8 mm FWHM)
    
-   High-pass filtering (e.g., >0.008–0.01 Hz)
    

---

### Nuisance regression (typical baseline)

Most groups include:

-   **Motion parameters** (6 or 24)
    
-   **CSF + white matter signals**
    
-   **Linear / quadratic drift**
    
-   Sometimes **framewise displacement censoring (“scrubbing”)**
    

👉 This is probably the closest thing to a “default ISC standard.”

---

# 2) The key conceptual tension (important for your work)

ISC is *not* GLM.

So the question is always:

> Are you removing nuisance variance that is **shared across subjects** (bad for ISC), or noise that is **idiosyncratic** (good to remove)?

This leads to two competing philosophies:

---

### (A) Conservative ISC (minimal regression)

-   Remove only **clearly non-neural noise**
    
-   Preserve as much shared signal as possible
    

Used when:

-   You want **maximal sensitivity to shared experience**
    
-   You later model variance (e.g., psychopathy, ωE)
    

---

### (B) Aggressive denoising (GLM-like)

-   Regress many nuisance signals (motion, physio, global signal, etc.)
    
-   Cleaner but risks removing **stimulus-locked shared variance**
    

Used when:

-   You want **spatial specificity**
    
-   Or comparing subtle effects across groups
    

---

# 3) What I would recommend for your case (naturalistic + individual differences)

Given your goals (ISC + psychopathy / empathy / ωE prediction), I would strongly recommend a **two-stage strategy**:

---

## Stage 1 — “Clean but not destructive” preprocessing

### Definitely include:

-   Motion parameters (preferably **24-parameter model**)
    
-   WM + CSF signals (CompCor-style preferred)
    
-   Polynomial drift (linear + quadratic)
    
-   High-pass filter (~0.01 Hz)
    

### Strongly consider:

-   **Motion censoring** (FD > 0.3–0.5 mm)
    
-   **Temporal derivatives of motion**
    

---

## Stage 2 — Think carefully about these controversial regressors

### 1\. Global signal regression (GSR)

-   ❌ **I would NOT include by default**
    
-   Reason:
    
    -   Removes shared variance → artificially lowers ISC
        
    -   Can distort correlation structure
        

👉 Exception: run it as a **robustness analysis**

---

### 2\. Physiological regressors (heart rate, respiration)

-   ✔️ Include **if available**
    
-   Especially important in your setup (strong autonomic responses to pain)
    

But:

-   Prefer **RETROICOR / RVT-type regressors**
    
-   Avoid overfitting (don’t include too many)
    

---

### 3\. ICA-based denoising (e.g., ICA-AROMA)

-   ✔️ Good compromise
    
-   Removes motion-related components without destroying shared signal too much
    

👉 Often better than aggressive regression

---

### 4\. Task-locked nuisance regressors (very important nuance)

This is where things get interesting for your paradigm:

You *could* regress out:

-   Visual features (luminance, motion energy)
    
-   Auditory envelope
    
-   Face presence
    
-   Pain expression intensity
    

But:

👉 **This fundamentally changes the interpretation of ISC**

-   Without regression → ISC reflects *everything shared*
    
-   With regression → ISC reflects *shared variance beyond those features*
    

---

# 4) What I would recommend specifically for your project

Given your goals (linking brain responses to psychopathy / empathy):

---

## Primary analysis (main paper)

Run ISC with:

-   Motion + WM/CSF + drift
    
-   NO GSR
    
-   Minimal feature regression
    

👉 Interpretation:  
“Where do people show shared responses to the movie?”

---

## Secondary analyses (critical for reviewers)

### A. Feature-controlled ISC

Regress out:

-   Low-level visual features
    
-   Possibly face/pain regressors
    

👉 Interpretation:  
“Shared signal beyond perceptual input”

---

### B. Individual-differences ISC

Relate ISC (or ISFC) to:

-   Psychopathy
    
-   ωE
    
-   Interview-derived dimensions
    

---

### C. Time-resolved ISC (your earlier idea)

-   Sliding window ISC or inter-subject GLM
    
-   Regress trait variables onto timepoints
    

👉 This is where nuisance handling becomes critical:

-   Over-regression = you kill your signal
    
-   Under-regression = confounds drive effects
    

---

# 5) Practical “recommended pipeline” (summary)

If I had to write it in a prereg:

**Nuisance regression includes:**

-   24 motion parameters
    
-   WM + CSF (CompCor, 5 components each)
    
-   Linear + quadratic drift
    
-   High-pass filter (0.01 Hz)
    
-   Scrubbing (FD > 0.5 mm)
    

**Additional steps:**

-   ICA-AROMA denoising (optional but recommended)
    

**Not included in primary analysis:**

-   Global signal regression
    

**Secondary analyses include:**

-   Physiological regressors (if available)
    
-   Feature-based regressors (visual, auditory, pain)
    

---

# 6) One strategic suggestion (important for your grant logic)

Given your emphasis on **multi-level explanation**, you can turn this into a strength:

Frame it explicitly as:

> “We quantify shared neural responses at multiple levels—  
> from raw shared experience to feature-controlled shared representations—  
> to dissociate perceptual alignment from affective alignment.”

This aligns beautifully with your **ISC + RSA + ωE mediation framework**.

---

# 7) One warning (based on experience)

The biggest pitfall in ISC papers:

👉 **Over-cleaning → loss of ISC → null results**

Especially:

-   GSR
    
-   Overly aggressive ICA
    
-   Too many regressors with shared temporal structure
    

---

# Bottom line

-   Use **minimal but principled denoising** for your main ISC
    
-   Treat additional regressors as **modeling choices, not preprocessing defaults**
    
-   Always show **robustness across pipelines**
    

---

If you want, I can help you:

-   turn this into a **methods paragraph (APA style)**
    
-   or design a **multi-pipeline robustness figure** (very convincing for reviewers)

You: 

could you explain what is the CompCor-style preferred?

ChatGPT: 

CompCor is one of those methods that is widely used but often only vaguely described, so it’s worth being precise—especially for ISC, where the *type* of noise removal really matters.

---

# What is CompCor (in simple terms)?

**CompCor (Component-Based Noise Correction)** is a method introduced by Yashar Behzadi (2007) to remove physiological and scanner noise from fMRI data **without explicitly measuring physiology**.

👉 Core idea:  
Instead of regressing out a single “average” signal from noise regions (like CSF), you:

> Extract **multiple principal components** from noise regions  
> → and regress those out from each voxel’s time series

---

# Why this is better than “mean WM/CSF regression”

The old approach:

-   Take the **average signal** in white matter (WM) and CSF
    
-   Regress those out
    

Problem:

-   Noise is **multidimensional**, not one signal
    
-   A single mean time series misses a lot
    

---

CompCor improves this by:

-   Capturing **multiple independent noise sources**
    
-   Adapting to each dataset
    

---

# Two main variants of CompCor

## 1\. aCompCor (anatomical CompCor) — ✅ what you want

-   Define masks for:
    
    -   White matter (WM)
        
    -   CSF
    
-   Extract voxel time series from those masks
    
-   Run PCA
    
-   Keep top **N components** (typically 5–10 per tissue)
    

👉 These components become your nuisance regressors

---

## 2\. tCompCor (temporal CompCor)

-   Select voxels with **highest variance** (anywhere in brain)
    
-   Run PCA on those
    

👉 More aggressive, less anatomically constrained  
👉 Can accidentally remove neural signal

---

✔️ For your work: **aCompCor is preferred**

---

# What does CompCor actually remove?

It captures:

-   Cardiac pulsation effects
    
-   Respiration-related fluctuations
    
-   Scanner drift
    
-   Motion-related residuals (partly)
    

👉 Importantly:  
These signals are often:

-   **not perfectly shared across subjects**
    
-   therefore safe to remove for ISC
    

---

# Why CompCor is particularly good for ISC

This connects directly to your earlier question.

Good nuisance regressors for ISC should:

-   Remove **idiosyncratic noise**
    
-   Preserve **stimulus-locked shared signal**
    

CompCor does exactly that because:

-   WM/CSF signals ≠ stimulus-driven
    
-   PCA components ≠ shared cognitive signal
    

👉 So you clean noise **without killing ISC**

---

# Practical implementation (what “CompCor-style” usually means)

In practice (e.g., in fMRIPrep pipelines), “CompCor-style” typically means:

### Step 1 — Define masks

-   Erode WM and CSF masks (avoid gray matter contamination)
    

### Step 2 — Extract time series

-   From all voxels in those masks
    

### Step 3 — PCA

-   Compute principal components
    

### Step 4 — Select components

Either:

-   Fixed number (e.g., **5 WM + 5 CSF**), OR
    
-   Enough to explain **50% variance**
    

### Step 5 — Regress out

Include components in nuisance regression

---

# What I would recommend for your pipeline

Given your ISC + individual differences work:

### Preferred setup

-   **aCompCor with 5 components from WM + 5 from CSF**
    
-   Combine with:
    
    -   24 motion parameters
        
    -   Drift terms
        
    -   Scrubbing
        

👉 This is a very standard and defensible choice

---

# One subtle but important nuance

CompCor components can sometimes contain:

-   Slow fluctuations
    
-   Residual structured signals
    

So:

👉 Always combine with **high-pass filtering (~0.01 Hz)**

---

# One caution (important)

If you:

-   Include too many components (e.g., 20+)
    

👉 You risk:

-   Removing meaningful signal
    
-   Reducing ISC
    

So:

-   Keep it **moderate (5–10 per tissue)**
    

---

# Intuition in one sentence

> CompCor is like letting the data tell you what the noise looks like, instead of guessing it with a single average signal.

---

# Bottom line

-   Use **aCompCor (WM + CSF PCA components)**
    
-   Prefer ~10 components total
    
-   Combine with motion + drift
    
-   Avoid overfitting
    

---

If you want, I can:

-   Help you write a **methods paragraph tailored to your WP2 design**
    
-   Or suggest how to **compare CompCor vs non-CompCor pipelines** as a robustness check (which reviewers often appreciate)

You: 

you write: "One subtle but important nuance CompCor components can sometimes contain: Slow fluctuations Residual structured signals So: 👉 Always combine with high-pass filtering (~0.01 Hz)" Wouldn't be the best to implement this to first regress out these components and only then apply the HPF?

ChatGPT: 

Yes—your instinct is good, but the crucial refinement is this:

**the safest approach is not “regress first, then high-pass” or “high-pass first, then regress” as two separate steps.**  
The best practice is to make the filtering and nuisance regression **compatible in the same model space**, ideally in a **single regression framework** or, at minimum, to apply the **same filter to both the data and the nuisance regressors**. Sequentially doing one and then the other can reintroduce artifacts. [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC6865661/?utm_source=chatgpt.com)

So the short answer is:

-   **No, I would not recommend “regress CompCor first and then high-pass” as the preferred default.**
    
-   I would recommend either:
    
    1.  **simultaneous nuisance regression + high-pass filtering**, or
        
    2.  using a pipeline like **fMRIPrep’s CompCor**, where the CompCor components are estimated **after high-pass filtering**, and then the matching cosine basis terms are included in the later regression model. [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)
        

## Why “regress first, then HPF” is problematic

Lindquist et al. showed that modular preprocessing steps can interact badly: if you do nuisance regression and temporal filtering in separate steps, one step can put back variance the other had removed, or alter the frequency content in undesirable ways. In particular, **doing regression first and then filtering** can reintroduce nuisance structure, while **doing filtering first and then regression** can also reintroduce frequencies you intended to remove unless the regressors are treated consistently. [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC6865661/?utm_source=chatgpt.com)

That is why the modern recommendation is usually:

> **filter and nuisance-regress together**, or make sure the nuisance regressors live in the same filtered space as the data. [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC6865661/?utm_source=chatgpt.com)

## Where CompCor fits in

The original CompCor paper proposed extracting principal components from noise ROIs and using them as nuisance regressors, but the later practical issue is **how those regressors interact with temporal filtering**. [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC2214855/?utm_source=chatgpt.com)

In **fMRIPrep**, CompCor components are computed **after high-pass filtering** the preprocessed BOLD time series. Because of that, the documentation says that when you use those CompCor regressors downstream, you should also include the corresponding **cosine high-pass regressors** in the design matrix, rather than applying an additional separate high-pass filter later. [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)

So, if you are using fMRIPrep confounds, the logic is:

-   the CompCor PCs were derived from **high-pass-filtered** data,
    
-   therefore your denoising model should include the matching **cosine drift terms**,
    
-   and you should avoid doing a separate incompatible HPF afterward. [fMRIPrep+1](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)
    

## Practical recommendation for your ISC work

For ISC, I would recommend:

### If you use fMRIPrep confounds

Include in one nuisance model:

-   motion regressors,
    
-   aCompCor regressors,
    
-   cosine high-pass regressors,
    
-   censoring regressors if you scrub. [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)
    

Then use the residuals for ISC.

### If you build your own pipeline

Best is:

-   choose your high-pass basis,
    
-   include that basis **in the same regression model** as motion/WM/CSF/CompCor,
    
-   then take residuals. [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC6865661/?utm_source=chatgpt.com)
    

## So was my earlier wording imprecise?

A bit, yes. Saying “always combine with high-pass filtering” was directionally right, but the more precise version is:

> **Do not think of CompCor regression and high-pass filtering as two independent sequential cleanup steps. Treat them jointly.**

That is the safer and more defensible answer.

## Bottom line

For your methods, I would phrase it like this:

> “Nuisance regression included motion and aCompCor regressors together with high-pass drift terms in a single linear model, to avoid artifact reintroduction from sequential filtering and regression.” [PMC+1](https://pmc.ncbi.nlm.nih.gov/articles/PMC6865661/?utm_source=chatgpt.com)

And if you use fMRIPrep specifically:

> “Because CompCor components in fMRIPrep are estimated after high-pass filtering, the corresponding cosine regressors were included in the nuisance model rather than applying a separate incompatible high-pass filter afterward.” [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)

I can also help you turn this into a concise methods paragraph for your ISC pipeline.

![](https://www.google.com/s2/favicons?domain=https://fmriprep.org&sz=32)

![](https://www.google.com/s2/favicons?domain=https://pmc.ncbi.nlm.nih.gov&sz=32)

Sources

You: 

Could you provide us with the optimal fmriprep syntax for an optimized pipeline for ISC with a highpass filter at 180s and 5 compoments per tissue?

ChatGPT: 

Yes, but with one important caveat:

**fMRIPrep itself does not let you set CompCor to “5 components per tissue” or change the CompCor high-pass cutoff to 180 s inside the preprocessing run.** In current documentation, fMRIPrep computes CompCor after a **128 s** DCT high-pass step, and by default it retains however many components are needed to explain **50% of the variance** in each mask. To get a fixed number like **5 WM + 5 CSF**, the practical solution is to run fMRIPrep with `--return-all-components` and then select the first 5 retained WM and first 5 retained CSF aCompCor components downstream in your denoising model. [fMRIPrep+3fMRIPrep+3fMRIPrep+3](https://fmriprep.org/en/stable/_static/SampleReport/sample_report.html?utm_source=chatgpt.com)

So the most defensible setup for ISC is:

1.  **Run fMRIPrep normally**, asking it to save all CompCor components.
    
2.  **Do the actual nuisance regression downstream**, where you include:
    
    -   24 motion terms
        
    -   first 5 WM aCompCor components
        
    -   first 5 CSF aCompCor components
        
    -   **180 s cosine high-pass basis**
        
    -   optional motion outlier regressors from FD/DVARS censoring
        

That also fits fMRIPrep’s recommendation that when you use CompCor, you should include the corresponding cosine drift terms in the design matrix rather than treating filtering as a separate incompatible later step. [fMRIPrep+1](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)

## Recommended fMRIPrep command

Here is a good **fMRIPrep command** for an ISC-oriented pipeline using Docker:

```
Bash

fmriprep-docker /path/to/bids /path/to/derivatives participant \\  
  \--participant-label sub-01 sub-02 sub-03 \\  
  \--fs-license-file /path/to/license.txt \\  
  \--output-spaces MNI152NLin2009cAsym:res-2 \\  
  \--return-all-components \\  
  \--fd-spike-threshold 0.5 \\  
  \--dvars-spike-threshold 1.5 \\  
  \--notrack \\  
  \-w /path/to/work
```

What this gives you:

-   standard fMRIPrep preprocessing outputs in MNI space, using the usual BIDS-App syntax, [fMRIPrep+1](https://fmriprep.org/en/stable/usage.html?utm_source=chatgpt.com)
    
-   **all** CompCor components saved to the confounds TSV instead of only the minimum needed to explain 50% variance, [fMRIPrep+1](https://fmriprep.org/en/20.1.0/usage.html?utm_source=chatgpt.com)
    
-   spike regressors for high-motion frames in `motion_outlier_XX` columns using the thresholds you specify. [fMRIPrep+1](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)
    

## What to do downstream

After fMRIPrep, build your ISC denoising model from the confounds file:

-   `trans_x trans_y trans_z rot_x rot_y rot_z`
    
-   their derivatives/quadratics if you want a 24P model
    
-   5 `a_comp_cor_*` from **WM**
    
-   5 `a_comp_cor_*` from **CSF**
    
-   `motion_outlier_*`
    
-   your own **180 s high-pass cosine basis**
    

The key point is that the **180 s filter belongs in the downstream nuisance model**, not as an fMRIPrep argument, because fMRIPrep’s internal CompCor estimation uses its own 128 s high-pass step and that cutoff is not exposed here as a user-facing option in the official docs. [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/stable/_static/SampleReport/sample_report.html?utm_source=chatgpt.com)

## Practical note on selecting the 5 components per tissue

fMRIPrep writes metadata for each CompCor column indicating which mask it came from, such as **WM**, **CSF**, or combined masks, so you can programmatically select the first 5 WM and first 5 CSF components from the accompanying JSON metadata rather than guessing from column names alone. [fMRIPrep+1](https://fmriprep.org/en/1.5.2/outputs.html?utm_source=chatgpt.com)

## Bottom line

Use fMRIPrep like this:

```
Bash

fmriprep-docker /path/to/bids /path/to/derivatives participant \\  
  \--fs-license-file /path/to/license.txt \\  
  \--output-spaces MNI152NLin2009cAsym:res-2 \\  
  \--return-all-components \\  
  \--fd-spike-threshold 0.5 \\  
  \--dvars-spike-threshold 1.5 \\  
  \--notrack \\  
  \-w /path/to/work
```

Then do the ISC denoising **afterward** with:

-   24 motion terms
    
-   5 WM aCompCor
    
-   5 CSF aCompCor
    
-   180 s cosine HPF
    
-   censoring regressors
    

That is the cleanest way to get exactly the pipeline you want while staying aligned with how fMRIPrep actually computes and exports confounds. [fMRIPrep+2fMRIPrep+2](https://fmriprep.org/en/latest/outputs.html?utm_source=chatgpt.com)

I can also give you a ready-to-run Python or MATLAB snippet that reads the fMRIPrep confounds TSV/JSON and automatically builds the exact nuisance matrix for ISC.

![](https://www.google.com/s2/favicons?domain=https://fmriprep.org&sz=32)

Sources

You: 

is the 180 s cosine hpf returned by fmriprep, or do I need to calculate it in other way? And how can I do that in this case?

ChatGPT: 

You need to calculate it yourself for a 180 s cutoff.

fMRIPrep does return **cosine regressors** in the confounds file, but those are tied to the cutoff fMRIPrep used internally for CompCor estimation, which is **128 s**, not 180 s. fMRIPrep’s docs state that CompCor components are estimated after high-pass filtering with a **discrete cosine filter with 128 s cut-off**, and the cosine basis is included in the confounds output for convenience. [fMRIPrep+1](https://fmriprep.org/en/stable/_static/SampleReport/sample_report.html?utm_source=chatgpt.com)

So for your pipeline:

-   the **fMRIPrep `cosine_*` columns are not the right ones** if you want a **180 s HPF**;
    
-   you should generate a **new DCT/cosine basis for 180 s** and include that in the same nuisance model as motion + your selected aCompCor components. [fMRIPrep+1](https://fmriprep.org/en/stable/_static/SampleReport/sample_report.html?utm_source=chatgpt.com)
    

## What cutoff corresponds to 180 s?

A 180 s high-pass cutoff means you want to remove fluctuations slower than:

$$
f_c = 1/180 \approx 0.00556 \text{ Hz}
$$

You then build the standard SPM-style DCT basis for that cutoff over the duration of each run.

## Practical recommendation

For ISC, I would do this per run:

-   start from the preprocessed BOLD run from fMRIPrep
    
-   read the confounds TSV/JSON
    
-   select:
    
    -   24 motion terms
        
    -   first 5 WM aCompCor
        
    -   first 5 CSF aCompCor
        
    -   motion outlier regressors if used
    
-   **discard the `cosine_*` columns from fMRIPrep**
    
-   generate your own **180 s DCT basis**
    
-   fit one regression model with all of the above
    
-   use the residuals for ISC
    

That keeps the regression/filtering in one consistent model space.

## How to generate the 180 s cosine basis

The easiest way is to compute an SPM-style DCT set from:

-   number of time points `N`
    
-   TR
    
-   cutoff `180`
    

Here is a Python function that does it:

```python
import numpy as np

def dct_highpass_basis(n_scans, tr, cutoff_sec=180.0):
    """
    Create SPM-style DCT high-pass basis.
    
    Parameters
    ----------
    n_scans : int
        Number of volumes in the run
    tr : float
        Repetition time in seconds
    cutoff_sec : float
        High-pass cutoff in seconds
    
    Returns
    -------
    X0 : array, shape (n_scans, n_basis)
        DCT basis matrix (without intercept)
    """
    n = np.arange(n_scans)
    run_length = n_scans * tr

    # SPM-style number of DCT bases
    n_basis = int(np.floor(2 * run_length / cutoff_sec))

    if n_basis < 1:
        return np.empty((n_scans, 0))

    X0 = np.zeros((n_scans, n_basis))
    for k in range(1, n_basis + 1):
        X0[:, k - 1] = np.cos((np.pi / n_scans) * (n + 0.5) * k)

    return X0
```

Example:

```python
TR = 2.0
n_scans = 300
X_dct = dct_highpass_basis(n_scans, TR, cutoff_sec=180)
print(X_dct.shape)
```

If `TR=2` and `N=300`, the run is 600 s long, so this gives:

$$
\lfloor 2 \times 600 / 180 \rfloor = 6
$$

So you would get **6 cosine regressors** for that run.

## How to combine it with your confounds

Conceptually:

```python
# X_motion = 24 motion regressors
# X_compcor = 5 WM + 5 CSF
# X_scrub = motion_outlier_* columns if any
# X_dct = your 180 s cosine basis

X = np.column_stack([X_motion, X_compcor, X_scrub, X_dct])
```

Then regress `X` from each voxel/vertex time series.

## Important nuance

Because fMRIPrep’s aCompCor components were estimated after its own internal **128 s** high-pass step, there is a small mismatch if you later denoise with a **180 s** DCT basis. That mismatch is usually acceptable in practice if your downstream model is internally consistent, but it is worth acknowledging in the methods. The cleanest wording is something like:

> “CompCor regressors were taken from fMRIPrep, while temporal drifts were modeled in the downstream nuisance regression using a 180 s discrete cosine basis.”

## My recommendation

If you want a strong, simple, defensible pipeline, I would use:

-   24 motion terms
    
-   5 WM aCompCor
    
-   5 CSF aCompCor
    
-   scrubbing regressors for high-motion frames
    
-   a custom **180 s DCT basis**
    
-   no GSR in the primary ISC
    

If you want, I can give you a full ready-to-run script that:

1.  reads the fMRIPrep confounds file,
    
2.  automatically extracts the first 5 WM and 5 CSF aCompCor components,
    
3.  builds the 180 s cosine basis, and
    
4.  saves the final nuisance matrix for ISC.
    

![](https://www.google.com/s2/favicons?domain=https://fmriprep.org&sz=32)

Sources