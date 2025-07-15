# Ecosystem 

This repository contains files and scripts used in a qualitative research project, including:

- 🗂️ Mock dataset
- ⚙️ API prompts for language model-assisted analysis  
- 📊 R scripts for generating **alluvial diagrams** and **TF-IDF visualizations**

---

## 📁 Repository Structure

```
├── API_Prompts/
│   ├── Coherence, 4 subthemes.txt
│   ├── Cognitive, 4 subthemes.txt
│   ├── Collective, 4 subthemes.txt
│   └── Reflexive, 4 subthemes.txt
├── Data/
│   └── Mock_Dataset.xlsx
├── R.Scripts/
│   ├── Alluvial_plots.R
│   ├── TF-IDF.R
│   └── saturation_table.R
├── README.md
```

---

## 💡 Project Description

This project uses mixed methods to explore stakeholders' perspectives on the implementation of population-wide risk-based screening which includes: 
- Thematic coding of interview transcripts using Nvivo 13 (2020 R1, release 1.7.2 (4855))
- TF-IDF keyword extraction from verbatim transcripts to identify frequent words unique each stakeholder group
- Alluvial diagrams to show overall tone and emotional variance of stakeholders

---

## 🧾 Mock Dataset Column Guide

| Column Name        | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| `Text Content`     | The raw qualitative data (e.g., quotes or excerpts from interviews).        |
| `ID`               | Unique identifier for each data entry or respondent.                        |
| `Codes`            | Specific qualitative codes applied to the text content.                     |
| `Overarching Codes`| Broader theme or category under which individual codes fall.                |
| `Role`             | Stakeholder role and specialty (e.g., Breast Cancer Surgeon, General Practitioner)                  |
| `Clinical`         | Binary indicator (TRUE/FALSE) if the stakeholder is involved in clinical work.   |
| `Patient`          | Binary indicator (TRUE/FALSE) if the stakeholder is involved in patient-facing work.    |
| `Research`         | Binary indicator (TRUE/FALSE) if the stakeholder is involved in research and development work.       |
| `Policy`           | Binary indicator (TRUE/FALSE) if the stakeholder is involved in policy work.        |
| `Medtech`          | Binary indicator (TRUE/FALSE) if the stakeholder is involved in medical technology and innovation work.                  |
| `Quadrant`         | Classification tag (e.g., Coherence, Cognitive, Collective, Reflexive) indicating the 4 domains of the Normalisation Process Theory Framework. |
| `Profession`       | Stakeholder profession (e.g., clinician, patient, policymaker).        |
| `Sentiment`        | Subjective tone (e.g., Positive, Neutral, Negative).             |

---

## 🧠 Tools & Libraries Used

All quantitative analyses were conducted using **R**. TF-IDF scores were calculated using `tidytext::bind_tf_idf`, which helped identify terms unique to different stakeholder groups. Alluvial plots were generated with `ggalluvial:: geom_alluvium` to visualize the flow and distribution of themes across roles or categories.

---

## ⚠️ Disclaimer
The code in this repository is intended to demonstrate logic and structure only. It may not produce accurate or meaningful results if run, as it uses a dummy dataset for illustration purposes.
