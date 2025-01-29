from pathlib import Path

# Base paths
ROOT_DIR = Path(__file__).parent.parent
PROCESSED_DATA_DIR = ROOT_DIR / "processed_data"
RESULTS_DIR = ROOT_DIR / "results"

# Commonly used data files
MIRNA_DATA_FILE = PROCESSED_DATA_DIR / "miRNA_stage_subtype.csv"
PREPROCESSED_DATA_FILE = PROCESSED_DATA_DIR / "preprocessed_miRNA_data.csv"

# Results subdirectories
FOLD_CHANGE_DIR = RESULTS_DIR / "fold_change"
CHI_SQUARED_DIR = RESULTS_DIR / "chi_squared"
INFORMATION_GAIN_DIR = RESULTS_DIR / "information_gain"
NCA_DIR = RESULTS_DIR / "neighborhood_components_analysis"
RFE_DIR = RESULTS_DIR / "recursive_feature_elimination"