clc;         % Clear the command window
clear;       % Remove all variables from the workspace
close all;   % Close all open figure windows

%================================================================%
% Load metadata and clinical data from JSON files
% These files contain information about each case, including file IDs
% and clinical diagnoses
metadata = jsondecode(fileread('metadata.cart.2024-10-27.json'));
clinical = jsondecode(fileread('clinical.cart.2024-10-27.json'));

% Extract 'file_id' and 'case_id' from metadata for each entry
% Initialize an array of structs 'labels' to store these identifiers
for i = 1:length(metadata)
    labels(i).file_id = metadata{i, 1}.file_id;                    % Unique identifier for each file
    labels(i).case_id = metadata{i, 1}.associated_entities.case_id; % Corresponding case identifier
end

% Continue processing by associating clinical stage information
% Extract the 'ajcc_pathologic_stage' from the clinical data
% for each case, based on matching 'case_id'
m = 0; % Counter for the number of matched cases

% Loop through clinical data to find matching case IDs in labels
for i = 1:length(clinical)
    disp(i); % Display current index in the command window for tracking progress
    % Check if 'diagnoses' and 'ajcc_pathologic_stage' fields exist in the current clinical entry
    if isfield(clinical(i), 'diagnoses') && isfield(clinical(i).diagnoses, 'ajcc_pathologic_stage')
        % Search for a matching case_id in the labels array
        for j = 1:length(labels)
            if strcmp(clinical(i).case_id, labels(j).case_id)
                % If match is found, add the stage label to 'labels' struct
                labels(j).label = clinical(i).diagnoses.ajcc_pathologic_stage;
                m = m + 1; % Increment the match counter
                disp(m);    % Display the match count
            end
        end
    end
end

% Create a numerical label array 'l' based on the pathological stage
% Each stage (e.g., Stage IIA) is mapped to a specific integer
l = [];

% Assign numerical labels according to the 'ajcc_pathologic_stage' field
for i = 1:length(labels)
    disp(labels(i).label); % Display the current stage label for verification
    if strcmp(labels(i).label, 'Stage I') || strcmp(labels(i).label, 'Stage IA') || strcmp(labels(i).label, 'Stage IB')
        l = [l; 1]; % Stage I variations are labeled as 1
    elseif strcmp(labels(i).label, 'Stage II') || strcmp(labels(i).label, 'Stage IIA') || strcmp(labels(i).label, 'Stage IIB')
        l = [l; 2]; % Stage II variations are labeled as 2
    elseif strcmp(labels(i).label, 'Stage III') || strcmp(labels(i).label, 'Stage IIIA') || strcmp(labels(i).label, 'Stage IIIB')
        l = [l; 3]; % Stage III variations are labeled as 3
    elseif strcmp(labels(i).label, 'Stage IV') || strcmp(labels(i).label, 'Stage IVA') || strcmp(labels(i).label, 'Stage IVB')
        l = [l; 4]; % Stage IV variations are labeled as 4
    else
        l = [l; 0]; % Assign 0 if stage information is unavailable
    end
end

%================================================%
% Define the directory containing the training files
TrainDir = '.\Train'; % Update this path if necessary
TrainList = dir(TrainDir); % List all items in the specified directory
TrainList = TrainList(3:end); % Skip the first two entries ('.' and '..') 

% Initialize storage for file data
s = [];
m = 1; % Counter for indexed data storage
TrainData = [];
TrainLabel = cell(1, 0);

% Loop over each subdirectory in TrainDir
for i = 1:length(TrainList)
    % Find all .mirnas.quantific files in the current subdirectory
    subTrainList = dir([TrainDir '\' TrainList(i).name '\*.mirnas.quantific']);
    
    for j = 1:length(subTrainList)
        % Read the .mirnas.quantific file as a table with tab delimiters
        s{m}.data = readtable([TrainDir '\' TrainList(i).name '\' subTrainList(j).name], ...
            'FileType', 'text', ...
            'Delimiter', '\t');  % Assuming file is tab-delimited
        
        % Check if the data has the expected 1881 rows (one per miRNA)
        if size(s{m}.data, 1) ~= 1881
            disp('Ali'); % Display 'Ali' as a simple alert if row count does not match
        end
        
        % Store the file identifier in the struct array 's'
        s{m}.file_id = TrainList(i).name;
        m = m + 1; % Increment the struct index for the next file
    end
end

% Extract the third column ('reads_per_million_miRNA_mapped') from each file's data
% Combine this column across all files to create a feature matrix
data = [];
for i = 1:length(s)
    % Convert the third column to an array and append to 'data' matrix
    data = [data table2array(s{i}.data(:, 3))];
end

% Transpose the data matrix so each row corresponds to a sample
T = data'; 

% Append the label vector 'l' as the last column in T
T = [T l];

% Create column names for the output CSV file based on miRNA IDs from the first file
name = table2cell(s{1}.data(:, 1)); % Extract miRNA IDs as cell array
name = [name', 'Label']; % Add 'Label' as the last column name

% Convert the matrix T to a table with specified column names
T1 = array2table(T, 'VariableNames', name);

% Write the final table to a CSV file called 'Lung.csv'
writetable(T1, 'Lung.csv');
