# 🧬 Lung Cancer Classification Using Biomarkers (miRNA)

> **Group**: 33 | **Project Number**: 8  
> **Faculty Advisor**: Dr. Waseem Asghar (📧 wasghar@fau.edu)  
> **Sponsors**: Dr. Ali Ibrahim (📧 aibrahim2014@fau.edu), Dr. Hanqi Zhuang (📧 zhuang@fau.edu)  

---

## 📜 Project Description
This project focuses on classifying **lung cancer stages and subtypes** using **miRNA expression data** and **machine learning models**. Our goal is to **differentiate between cancerous and non-cancerous tissues**, identify **subtypes**, and improve classification accuracy.

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
- **4** → Mesothelioma  

---

## 🛠️ **Feature Selection Methods**
To improve model performance, we applied **multiple feature selection techniques** to reduce the miRNA dataset's dimensionality.

### ✅ **Feature Selection Methods Implemented**
| **Method** | **Description** |
|------------|------------------------------------------------|
| **Fold-Change** | Identifies differentially expressed miRNAs. |
| **Chi-Squared** | Ranks miRNAs based on statistical association with labels. |
| **Information Gain** | Measures how much information miRNAs contribute to classification. |
| **LASSO (L1 Regularization)** | Selects important features by penalizing irrelevant ones. |
| **Recursive Feature Elimination (RFE)** | Iteratively removes the least important features. |
| **Neighborhood Components Analysis (NCA)** | Learns a transformation that improves classification. |
| **Transformer-Based Feature Selection** | Uses attention mechanisms for feature ranking. |
| **Random Forest Feature Importance** | Uses tree-based ranking of features. |

### **Feature Selection Results**
- **Final feature selection combines top miRNAs from multiple methods.**
- These features are used to train **SVM and Random Forest models**.

---

## 🖥️ **Machine Learning Workflow**
We train **multiple classification models** for **stage and subtype prediction**:

| **Model** | **Purpose** |
|-----------|--------------------------|
| **SVM (Fold-Change Only)** | Baseline using only Fold-Change features. |
| **SVM (All Features)** | Uses all feature selection methods for improved accuracy. |
| **Random Forest** | Uses tree-based feature importance. |

### 📊 **Evaluation Metrics**
Each model is evaluated using:
- **Accuracy** ✅
- **Precision, Recall, F1-Score** ✅
- **Confusion Matrices** ✅
- **ROC-AUC for binary classification (Diagnosis: Cancer vs. Healthy)** ✅

---

## 🔬 **Model Training & Experimentation**
### **Training Data**
- **miRNA expression levels** are extracted from `.quantification.txt` files.
- Dataset contains **1881 miRNA features** per sample.
- Labels include **stage (0-4) and subtype (0-4)**.

### **Training Process**
- **Train-test split (80-20%)** with **stratified sampling**.
- **Feature scaling & normalization** applied after split.
- **Hyperparameter tuning** using **GridSearchCV**.

### **Current Results**
| **Model** | **Stage Accuracy** | **Subtype Accuracy** |
|-----------|------------------|------------------|
| **SVM (Fold-Change Only)** | **53.00%** | **94.47%** |
| **SVM (All Features)** | **98.16%** | **98.16%** |
| **Random Forest** | 🚧 **Pending Testing** 🚧 |

---

## 🚀 **Future Development**
### **1️⃣ GUI Development**
- A **user-friendly interface** for **clinicians** to visualize **miRNA expression and model predictions**.

### **2️⃣ Deep Learning**
- Implement **Neural Networks (CNNs, Autoencoders)** to enhance classification accuracy.

### **3️⃣ Final Validation**
- **Validate the system using external datasets**.
- Compare performance with **existing diagnostic tools**.

---

## ⚙️ **How to Run**
### **Setup**
1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/lung-cancer-classification.git
   cd lung-cancer-classification

2. **Create a virtual environment** (optional, but recommended):
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows use `.venv\Scripts\activate`
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

### **Run Feature Selection**
```bash
python feature_selection/fold_change.ipynb
python feature_selection/chi_squared.ipynb
python feature_selection/information_gain.ipynb
python feature_selection/lasso.ipynb
python feature_selection/recursive_feature_elimination.ipynb
python feature_selection/neighborhood_components_analysis.ipynb
```

### **Train & Evaluate SVM Models**
```bash
jupyter notebook classification/svm_classifier.ipynb
```

### **Train & Evaluate Random Forest**
```bash
jupyter notebook classification/random_forest_classifier.ipynb
```

---

## 📄 Repository Structure
```
.
├── feature_selection/
│   ├── fold_change.ipynb
│   ├── chi_squared.ipynb
│   ├── information_gain.ipynb
│   ├── lasso.ipynb
│   ├── recursive_feature_elimination.ipynb
│   ├── neighborhood_components_analysis.ipynb
│   ├── transformer_feature_selection.ipynb
│   ├── compare_features.ipynb
│   └── config.py
│
├── classification/
│   ├── svm_classifier.ipynb
│   ├── svm_classifier_fold_change.ipynb
│   ├── random_forest_classifier.ipynb
│
├── processed_data/
│   ├── miRNA_stage_subtype.csv
│
├── results/
│   ├── fold_change_results.csv
│   ├── chi_squared_features.csv
│   ├── information_gain_results.csv
│   ├── lasso_results.csv
│
├── requirements.txt
├── README.md
```
