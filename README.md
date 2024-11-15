# 🫁 Lung Cancer Classification Project

> **Group**: 33 | **Project Number**: 8  
> **Faculty Advisor**: Dr. Waseem Asghar (📧 wasghar@fau.edu)  
> **Sponsors**: Dr. Hanqi Zhuang (📧 zhuang@fau.edu), Ali Ibrahim (📧 aibrahim2014@fau.edu)  

## 📜 Project Description
This project focuses on classifying lung cancer stages using **miRNA** expression data and **clinical metadata** from patients. Lung cancer stages are mapped based on `ajcc_pathologic_stage`, with labels assigned as follows:
- **0**: Healthy/Non-cancerous
- **1**: Cancer Stage I (IA, IB)
- **2**: Cancer Stage II (IIA, IIB)
- **3**: Cancer Stage III (IIIA, IIIB)
- **4**: Cancer Stage IV (IVA, IVB)

The project involves two main parts:
1. **MATLAB to Python Conversion**: Converting existing MATLAB code into a Python-based workflow.
2. **Further Analysis and Modeling in Python**: Future steps to refine and expand analysis, machine learning modeling, and evaluation.

---

## 🖥️ MATLAB to Python Conversion 🖥️
### Purpose
Our initial MATLAB script (`main.m`) was converted to Python to make the analysis and modeling more flexible. Here’s what the script does and how it’s been adapted to Python.

### Conversion Workflow
1. **Load JSON Files** 📂: 
   - Reads the `metadata.cart.json` and `clinical.cart.json` files.
   
2. **Extract Case IDs and File IDs** 🔍:
   - Extracts `case_id` and `file_id` pairs from the metadata file for label tracking.

3. **Match Case IDs with Clinical Data** 🔗:
   - Matches each `case_id` with the clinical data to retrieve `ajcc_pathologic_stage` for lung cancer staging.

4. **Map Clinical Stages to Numerical Labels** 🔢:
   - Maps the extracted stages into numerical labels (0 for healthy, 1-4 for stages I-IV) to prepare for machine learning models.

5. **Read miRNA Quantification Files** 🧬:
   - Reads miRNA `.quantific` files for each sample and assembles a feature matrix of expression data.

6. **Save to CSV** 📄:
   - Combines the miRNA expression data and stage labels into `Lung.csv` for downstream processing and analysis.

### 📌 Conversion Highlights:
   - MATLAB indexing starts at **1** while Python indexing starts at **0** (handled during conversion).
   - Final feature matrix is saved as **`Lung.csv`** in Python.

---

## 📓 Ongoing Python Workflow 📓
The **Jupyter Notebook** implementation is where all the new Python-based work will take place. This includes more detailed analysis, advanced data processing, and model development.

### 🎯 Key Python Workflow Steps
1. **Load JSON Data** 📂:
   - Loads `metadata` and `clinical` data using the `json` library.

2. **Extract IDs and Match Clinical Data** 🔗:
   - Extracts `file_id` and `case_id` from `metadata` and matches with `clinical` data to retrieve `ajcc_pathologic_stage`.

3. **Map Stages to Numerical Labels** 🔢:
   - Maps stages to numerical labels with clear logging for any unknown stages (labeled as **0** for non-cancerous cases).

4. **Read miRNA Data Files** 🧬:
   - Iterates through `.quantific` files to build the miRNA feature matrix, ensuring all files have the correct number of rows (1881).

5. **Combine Features and Labels** ➕:
   - Appends the numerical labels to the miRNA data and assigns miRNA IDs as column names. The final feature matrix is saved as **`Lung.csv`**.

---

## 🚀 How to Run

### MATLAB Script
1. Open MATLAB and navigate to the project directory.
2. Run `main.m`.
3. The output will be saved as **`Lung.csv`**.

### Jupyter Notebook
1. Install required libraries:
   ```bash
   pip install pandas numpy
