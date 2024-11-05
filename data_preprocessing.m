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

% Continuing the labeling. From the clinical_data we'll the following info
% from clinical → clinical(1).diagnoses.ajcc_pathologic_stage → 'Stage IIA'

m = 0;

% Check for the 'ajcc_pathologic_stage' in the clinical data
for i = 1:length(clinical)
    disp(i)
    if isfield(clinical(i), 'diagnoses') && isfield(clinical(i).diagnoses, 'ajcc_pathologic_stage')
        for j = 1:length(labels)
            if strcmp(clinical(i).case_id, labels(j).case_id)
                labels(j).label = clinical(i).diagnoses.ajcc_pathologic_stage;
                m = m + 1;
                disp(m)
            end
        end
    end
end

%creating label 'l'
l = [];

% Assign numerical labels based on 'ajcc_pathologic_stage'
for i = 1:length(labels)
    disp(labels(i).label)
    if strcmp(labels(i).label, 'Stage I') || strcmp(labels(i).label, 'Stage IA') || strcmp(labels(i).label, 'Stage IB')
        l = [l; 1];
    elseif strcmp(labels(i).label, 'Stage II') || strcmp(labels(i).label, 'Stage IIA') || strcmp(labels(i).label, 'Stage IIB')
        l = [l; 2];
    elseif strcmp(labels(i).label, 'Stage III') || strcmp(labels(i).label, 'Stage IIIA') || strcmp(labels(i).label, 'Stage IIIB')
        l = [l; 3];
    elseif strcmp(labels(i).label, 'Stage IV') || strcmp(labels(i).label, 'Stage IVA') || strcmp(labels(i).label, 'Stage IVB')
        l = [l; 4];
    else
        l = [l; 0];
    end
end

%================================================%
TrainDir = '.\Train'; % Change this path as needed
TrainList = dir(TrainDir);
TrainList = TrainList(3:end); % Skip first two entries ('.' and '..')

s = [];
m = 1;
% Read Train File & Test File
TrainData = [];
TrainLabel = cell(1, 0);

for i = 1:length(TrainList)
    % Updated file filter to match .quantific files
    subTrainList = dir([TrainDir '\' TrainList(i).name '\*.mirnas.quantific']); 
    
    for j = 1:length(subTrainList)
        % Read the quantific file with explicit file type and delimiter
        s{m}.data = readtable([TrainDir '\' TrainList(i).name '\' subTrainList(j).name], ...
            'FileType', 'text', ...
            'Delimiter', '\t');  % Assuming tab-delimited
        
        if size(s{m}.data, 1) ~= 1881
            disp('Ali')
        end
        
        s{m}.file_id = TrainList(i).name;
        m = m + 1;
    end
end


data = [];
for i = 1:length(s)
    data = [data table2array(s{i}.data(:, 3))];
end


T = data';
T = [T l];

name = table2cell(s{1}.data(:, 1));
name = [name', 'Label'];

T1 = array2table(T, 'VariableNames', name);
writetable(T1, 'Lung.csv');
