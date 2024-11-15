clc;
clear;
close all;

%================================================================%
metadata = jsondecode(fileread('metadata.cart.2024-10-27.json'));
clinical = jsondecode(fileread('clinical.cart.2024-10-27.json'));

% Process each file entry in the metadata
for i = 1:length(metadata)
    labels(i).file_id = metadata{i, 1}.file_id;
    labels(i).case_id = metadata{i, 1}.associated_entities.case_id;
end

m = 0;

% Check for the 'ajcc_pathologic_stage' in the clinical data
for i = 1:length(clinical)
    disp(i)
    if isfield(clinical(i), 'diagnoses') && isfield(clinical(i).diagnoses, 'ajcc_pathologic_stage')
        for j = 1:length(labels)
            if strcmp(clinical(i).case_id, labels(j).case_id)
                labels(j).stage_label = clinical(i).diagnoses.ajcc_pathologic_stage;
                labels(j).subtype_label = clinical(i).diagnoses.primary_diagnosis;
                m = m + 1;
                disp(m)
            end
        end
    end
end

l = [];

% Assign numerical labels based on 'ajcc_pathologic_stage'
for i = 1:length(labels)
    disp(labels(i).stage_label)
    if strcmp(labels(i).stage_label, 'Stage I') || strcmp(labels(i).stage_label, 'Stage IA') || strcmp(labels(i).stage_label, 'Stage IB')
        l = [l; 1];
    elseif strcmp(labels(i).stage_label, 'Stage II') || strcmp(labels(i).stage_label, 'Stage IIA') || strcmp(labels(i).stage_label, 'Stage IIB')
        l = [l; 2];
    elseif strcmp(labels(i).stage_label, 'Stage III') || strcmp(labels(i).stage_label, 'Stage IIIA') || strcmp(labels(i).stage_label, 'Stage IIIB')
        l = [l; 3];
    elseif strcmp(labels(i).stage_label, 'Stage IV') || strcmp(labels(i).stage_label, 'Stage IVA') || strcmp(labels(i).stage_label, 'Stage IVB')
        l = [l; 4];
    else
        l = [l; 0];
    end
end

% Extract the subtype labels and filter out empty values
subtype_labels = {labels.subtype_label};
subtype_labels = subtype_labels(~cellfun('isempty', subtype_labels)); % Remove empty cells

% Find the unique values
subtypes = unique(subtype_labels, 'stable');

% Display each unique subtype
for i = 1:length(subtypes)
    disp(subtypes{i})
end

% Array containing Adenocarcinoma subtypes
adeno = ['Mucinous adenocarcinoma', 'Papillary adenocarcinoma, NOS', 'Adenocarcinoma, NOS', 'Bronchiolo-alveolar carcinoma, non-mucinous'...
     'Adenocarcinoma with mixed subtypes', 'Acinar cell carcinoma', 'Micropapillary carcinoma, NOS', 'Solid carcinoma, NOS', 'Signet ring cell carcinoma'...
     'Clear cell adenocarcinoma, NOS', 'Bronchiolo-alveolar adenocarcinoma, NOS','Bronchio-alveolar carcinoma, mucinous']

% Array containing Squamous Cell Carcinoma subtypes
squamous = ['Squamous cell carcinoma, NOS', 'Basaloid squamous cell carcinoma', 'Squamous cell carcinoma, keratinizing, NOS', 'Papillary squamous cell carcinoma' ]

% Large Cell Carcinoma
large_cell = []

% Array containing non-small cell lung cancer types
% nsclc = []

% Array containing mesothelimoa lung cancer types
mesothelimoa = ['Epithelioid mesothelioma, malignant']

sclc = ['Squamous cell carcinoma, small cell, nonkeratinizing']

% Assign numerical labels for top level subtypes based on 'primary_diagnosis'
% 0 == healthy, 1 == small cell, 2 == non-small cell, 3 == Mesothelioma
k = []
for i = 1:length(labels)
    if ismember(labels(i).subtype_label, adeno)
        k = [k; 1];
    elseif ismember(labels(i).subtype_label, squamous)
        k = [k; 2];
    elseif ismember(labels(i).subtype_label, large_cell)
        k = [k; 3]
    elseif ismember(labels(i).subtype_label, mesothelimoa)
        k = [k; 4];
    elseif ismember(labels(i).subtype_label, sclc)
        k = [k; 5];
    else
        k = [k; 0]
    end
end

B = categorical(k)

summary(B)

% Append subtype lables to stage lables
l = [l, k]


%================================================%
TrainDir = '.\gdc_download_20241027_141734.510622'; % Change this path as needed
TrainList = dir(TrainDir);
TrainList = TrainList(3:end); % Skip first two entries ('.' and '..')

s = [];
m = 1;

% Read Train File & Test File
TrainData = [];
TrainLabel = cell(1, 0);

for i = 1:length(TrainList)
    subTrainList = dir([TrainDir '\' TrainList(i).name '\*.txt']); % Change file filter here if needed
    for j = 1:length(subTrainList)
        s{m}.data = readtable([TrainDir '\' TrainList(i).name '\' subTrainList(j).name]);
        if size(s{m}.data, 1) ~= 1881
            disp('Ali')
            continue
        end
        s{m}.file_id = TrainList(i).name;
        m = m + 1;
    end
end

data = [];
for i = 1:length(s)
    data = [data table2array(s{i}.data(:, 3))];
end


labelNames = {'stage', 'subtype'}
T = data.';
T = [T l];

name = table2cell(s{1}.data(:, 1));
name = [name; labelNames'];

T1 = array2table(T, 'VariableNames', name);

writetable(T1, 'miRNA_stage_subtype.csv');
