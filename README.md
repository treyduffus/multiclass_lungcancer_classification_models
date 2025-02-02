# 🧬Lung Cancer Classification Using Biomarkers (Current: miRNA)

> **Group**: 33 | **Project Number**: 8  
> **Faculty Advisor**: Dr. Waseem Asghar (📧 wasghar@fau.edu)  
> **Sponsors**: Dr. Hanqi Zhuang (📧 zhuang@fau.edu), Ali Ibrahim (📧 aibrahim2014@fau.edu)  

---

## 📜 Project Description
This project focuses on classifying lung cancer stages and subtypes using **miRNA expression data** and **clinical metadata**. The primary goal is to utilize machine learning techniques to distinguish between cancerous and non-cancerous tissues, identify subtypes, and improve classification accuracy. 

### **Cancer Stages**
Lung cancer stages are mapped based on `ajcc_pathologic_stage`, with labels assigned as follows:
- **0**: Healthy/Non-cancerous
- **1**: Cancer Stage I (IA, IB)
- **2**: Cancer Stage II (IIA, IIB)
- **3**: Cancer Stage III (IIIA, IIIB)
- **4**: Cancer Stage IV (IVA, IVB)

### **Cancer Subtypes**
The project also incorporates subtyping of lung cancer into the following categories:
- **Adenocarcinoma**
- **Squamous Cell Carcinoma**
- **Large Cell Carcinoma**
- **Small Cell Lung Cancer**
- **Mesothelioma**

Numerical labels for subtypes are assigned during preprocessing:
- **0**: Healthy
- **1**: Adenocarcinoma
- **2**: Squamous Cell Carcinoma
- **3**: Large Cell Carcinoma
- **4**: Mesothelioma
- **5**: Small Cell Lung Cancer

---

## 🖥️ Data Preprocessing Pipeline 🖥️
### Overview
The pipeline integrates clinical and miRNA data, assigns stage and subtype labels, and prepares the feature matrix for machine learning models. The updated workflow was developed using Python after converting the initial MATLAB scripts.

### Steps
1. **Load Metadata and Clinical Data** 📂  
   - Reads `metadata.cart.json` and `clinical.cart.json` files.

2. **Extract Case IDs and Labels** 🔍  
   - Extracts `case_id` and `file_id` pairs from metadata.  
   - Maps `ajcc_pathologic_stage` and `primary_diagnosis` from clinical data for staging and subtyping.

3. **Assign Labels** 🔢  
   - Maps stages (0-4) and subtypes (0-5) to numerical labels for classification tasks.

4. **Read miRNA Quantification Files** 🧬  
   - Reads `.quantification.txt` files to create a feature matrix of miRNA expression data (1881 features per sample).

5. **Combine Features and Labels** ➕  
   - Merges stage and subtype labels with miRNA expression data. Saves the complete dataset as `Lung.csv`.

---

## 📓 Feature Selection and Analysis 📓
To improve model performance, feature selection techniques are applied to reduce the dimensionality of miRNA data:

### Methods
1. **Fold-Change Analysis**  
   - Calculates the log-fold change between cancerous and non-cancerous samples to identify highly expressed miRNAs.  
   - miRNAs with log-fold change exceeding a threshold are retained.

2. **Chi-Squared Feature Selection**  
   - Evaluates statistical dependency between miRNAs and labels to rank features based on their importance.  

### Results Comparison
- A comparison of top-ranked features from fold-change and chi-squared methods highlights overlapping and unique biomarkers.  
- Final biomarker rankings will guide model development and clinical interpretation.

---

## 🖥️ Machine Learning Workflow 🖥️
### Steps
1. **Data Splitting**  
   - Split the dataset into training and testing sets, ensuring balanced distribution of stages and subtypes.

2. **Model Selection**  
   - Test classifiers like Random Forest, Support Vector Machines (SVM), and Neural Networks for stage and subtype classification.  
   - Explore deep learning models to improve performance.

3. **Evaluation Metrics**  
   - Metrics include accuracy, precision, recall, F1-score, and ROC-AUC for multi-class and binary classifications.

---

## 🖼️ Future Development
1. **GUI Development**  
   - Design a user-friendly interface for clinicians to visualize miRNA expression data, feature selection results, and model predictions.  
   - Focus on simplicity and clinical relevance.  

2. **Deep Learning Integration**  
   - Implement deep learning methods for feature extraction and classification, such as Convolutional Neural Networks (CNNs) or Autoencoders.

3. **Final Validation**  
   - Validate the system using external datasets and compare results with existing diagnostic tools.

---

## 🚀 How to Run

### Python Workflow
1. Install required libraries:
   ```bash
   pip install pandas numpy scikit-learn
