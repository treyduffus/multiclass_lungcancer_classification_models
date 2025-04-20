# 🧬 Lung Cancer Classification Using Biomarkers (miRNA)

> **Group**: 33 | **Project Number**: 8  
> **Faculty Advisor**: Dr. Waseem Asghar (📧 wasghar@fau.edu)  
> **Sponsors**: Dr. Ali Ibrahim (📧 aibrahim2014@fau.edu), Dr. Hanqi Zhuang (📧 zhuang@fau.edu)  

---

## 📜 Project Description
This project focuses on classifying **lung cancer cases (cancer vs. healthy)** using **miRNA expression data** and **machine learning models**. Our goal is to identify **robust, interpretable miRNA biomarkers** for early diagnosis.

### **Cancer Staging and Subtypes (Exploratory)**
While the primary focus is on binary diagnosis, we also explored:
- **Stage**: Pathologic stage (I–IV)  
- **Subtype**: Adenocarcinoma vs. Squamous Cell Carcinoma

### **Cancer Stages**
Lung cancer staging follows `ajcc_pathologic_stage`:
- **0** → Healthy/Non-cancerous  
- **1** → Cancer Stage I (IA, IB)  
- **2** → Cancer Stage II (IIA, IIB)  
- **3** → Cancer Stage III (IIIA, IIIB)  
- **4** → Cancer Stage IV (IVA, IVB)  

### **Cancer Subtypes**
We classify lung cancer into the following categories:
- **0** → Healthy  
- **1** → Adenocarcinoma  
- **2** → Squamous Cell Carcinoma  

These tasks were found to be significantly affected by class imbalance and overlapping biological signals. Therefore, they are included as exploratory findings.

---

## 🛠️ Feature Selection Pipeline
We applied a comprehensive suite of **eight feature selection methods** to reduce dimensionality and identify stable, high-impact biomarkers:

| **Method** | **Purpose** |
|-----------|-------------|
| Fold-Change | Detects differentially expressed miRNAs. |
| Chi-Squared | Assesses statistical dependence on labels. |
| Information Gain | Measures reduction in class uncertainty. |
| LASSO | Applies L1 penalty to remove irrelevant features. |
| Recursive Feature Elimination (RFE) | Eliminates least useful features iteratively. |
| Neighborhood Component Analysis (NCA) | Learns a distance metric to weight features. |
| Random Forest Importance | Uses tree-based impurity reduction for ranking. |
| **VTFS** | Deep learning method using attention weights (Transformer-based). |

## 🧠 Deep Learning Integrations

### VTFS (Variational Transformer Feature Selection)
VTFS was used for **feature selection only** and showed that subsets as small as **1–3 miRNAs** could still yield high performance when used in classifiers like SVM.

### SAINT
SAINT is a transformer-based classifier designed for tabular data. It achieved the **highest F1-score** and **best specificity** among all tested models for binary classification.

---

## 🖥️ Machine Learning Models
We trained and evaluated the following classifiers on various tasks:

| **Model** | **Role** |
|----------|-----------|
| Support Vector Machine (SVM) | Classical kernel-based model. |
| Random Forest (RF) | Tree-based ensemble classifier. |
| SAINT | Deep transformer-based classifier for tabular input. |

Each model was trained on:
- Diagnosis (primary)
- Stage classification (exploratory)
- Subtype prediction (exploratory)

---

## 📊 Evaluation Metrics
All models were evaluated using the following metrics:
- Accuracy
- Sensitivity (Recall)
- Specificity
- F1-Score
- Confusion Matrix

All evaluations were performed **after correcting for label leakage**.

---

## 📈 Results Summary

### ✅ Diagnosis (Cancer vs. Healthy)
| Model | Accuracy | Recall | Specificity | F1-Score |
|-------|----------|--------|-------------|----------|
| SVM   | 99.0%    | 100%   | 0%          | ~0.99    |
| RF    | 99.1%    | 100%   | 0%          | ~0.99    |
| SAINT | 99.5%    | 100%   | 99.0%       | 0.9976   |

### 🚧 Stage Classification (Exploratory)
| Model | Accuracy | Macro Recall |
|-------|----------|---------------|
| SVM   | 52.1%    | Low           |
| RF    | 51.6%    | Slightly Better |
| SAINT | 59.7%    | Moderate      |

### 🔬 Subtype Classification (Exploratory)
| Model | Accuracy | Recall (SqCC) |
|-------|----------|----------------|
| SVM   | 49.1%    | Collapsed      |
| RF    | 53.9%    | Improved       |
| SAINT | 47.0%    | Balanced       |

---

## 🚀 Future Work
- Apply consensus features in external validations.
- Extend with additional data types (e.g., DNA methylation, proteomics).
- Build visual dashboards for model explainability.
- Expand SAINT and VTFS evaluation across other cancer datasets.

---

## ⚙️ How to Run
```bash
# Clone the repo
$ git clone https://github.com/your-repo/lung-cancer-classification.git
$ cd lung-cancer-classification

# Set up environment
$ python -m venv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt

# Run Feature Selection
$ python feature_selection/fold_change.ipynb
$ python feature_selection/chi_squared.ipynb
...

# Train Models
$ jupyter notebook classification/svm_classifier.ipynb
$ jupyter notebook classification/random_forest_classifier.ipynb
$ jupyter notebook classification/saint_classifier.ipynb