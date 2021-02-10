%LIT_bin2mat.m 
%   This MATLAB script is used to extract binary data from the LIT-Dataset
%   RAW_Data files and construct MATLAB arrays from this data for further
%   processing. MATLAB arrays are saved in .mat files.
%Author: Bruna Molinari, Douglas Renaux
%Documentation:
%   read the LIT_Dataset - MATLAB user guide (pdf file)

% Clear the workspace and command window
clc
clear
close all

% 1 - Select a subset:
% Type = char array
% Options =
%                    º 'Natural'
%                    º 'Synthetic'
%                    º 'Sim_Ideal'
%                    º 'Sim_Induct'
%                    º 'Sim_Induct_Harmo'
%                    º 'Sim_Induct_Harmo_SNR_10'
%                    º 'Sim_Induct_Harmo_SNR_30'
%                    º 'Sim_Induct_Harmo_SNR_60'
%
subset = 'Sim_Ideal';

% 2 - Build list of loads for this subset
loads_set = ChoiceOfLoads(subset);

% 3 - Reference directory and search path

r_dir = fileparts(mfilename('fullpath'));

cd(r_dir)
cd('..')

addpath(genpath(pwd))


% 4 - Number of loads to change the files
L = length(loads_set);
file_offset_in_loadset = 0;
current_numLoads = "1";

% 5- Loop for all loads in load set
for n = 1:L
    
    % Determines the amount of strokes (angle variation) in each
    % acquisition.
    [n_t, numLoads] = NumberOfTraces(subset, loads_set(n,:));
    if ~ strcmp(current_numLoads,numLoads)
        current_numLoads = numLoads;
        file_offset_in_loadset = 0;
    end
    
    for trace = n_t
        % Create one .mat for each database file
        CreateStructLIT(subset, loads_set(n,:), trace, file_offset_in_loadset);
    end
    file_offset_in_loadset = file_offset_in_loadset + length(n_t);
end