% Calculate the state changes of all neurons and plot the distribution
% Get the size of the matrix
[numCells, numSessions] = size(CellTags_EvolutionMatrix_Ordered);

% Initialize a matrix to hold the state change counts for each cell
stateChangeCounts_allcell = zeros(1, numCells);

% Iterate over each cell
for cellIdx = 1:numCells
    % Get the state sequence for the current cell
    stateSequence = CellTags_EvolutionMatrix_Ordered(cellIdx, :);
    
    % Count the number of state changes
    % We compare each state to the previous state (hence we start from the second element)
    % and sum up all the changes (where the state is not equal to the previous state)
    stateChangeCounts_allcell(cellIdx) = sum(diff(stateSequence) ~= 0);
end

% Create a histogram of the state change counts
figure; % Opens a new figure window
histogram(stateChangeCounts_allcell);
title('Transition Times Distribution');
xlabel('Number of State Changes');
ylabel('Number of Cells');

%% seperate each cluster according the first session, 
% calsulate the state change times in each cluster also average time in
% each cluster

% Assuming CellTags_EvolutionMatrix_Ordered is your matrix with rows as cells and columns as sessions

% Get the initial states for all cells
initialStates = CellTags_EvolutionMatrix_Ordered(:, 1);

% Find unique initial states
uniqueStates = unique(initialStates);

% Initialize variables to hold results
stateChangeCountsByCluster = cell(length(uniqueStates), 1);
meanStateChangeCounts = zeros(length(uniqueStates), 1);
semStateChangeCounts = zeros(length(uniqueStates), 1);

% Process each cluster
for stateIdx = 1:length(uniqueStates)
    % Extract cells with the same initial state
    cellsInCluster = CellTags_EvolutionMatrix_Ordered(initialStates == uniqueStates(stateIdx), :);
   
    % Calculate state changes for each cell in the cluster
    stateChangeCounts = sum(diff(cellsInCluster, 1, 2) ~= 0, 2);
   
    % Store the state change counts for the cluster
    stateChangeCountsByCluster{stateIdx} = stateChangeCounts;
   
    % Calculate and store the mean and SEM for the cluster
    meanStateChangeCounts(stateIdx) = mean(stateChangeCounts);
    semStateChangeCounts(stateIdx) = std(stateChangeCounts) / sqrt(length(stateChangeCounts));
end

% Define state labels
stateLabels = {'Inactive', 'Wake', 'NREM', 'REM'};
stateNumberToLabelMap = containers.Map([0, 5, 6, 7], stateLabels);

% Prepare state labels for plotting
stateLabelsForPlot = values(stateNumberToLabelMap, num2cell(uniqueStates));

% Plot histograms for state change counts in each cluster
figure;
for stateIdx = 1:length(uniqueStates)
    subplot(length(uniqueStates), 1, stateIdx);
    histogram(stateChangeCountsByCluster{stateIdx});
    title(['State Changes Distribution for ', stateNumberToLabelMap(uniqueStates(stateIdx))]);
    xlabel('Number of State Changes');
    ylabel('Frequency');
end

% Plot mean and SEM of average state change counts by initial state
figure;
bar(meanStateChangeCounts);
hold on;
errorbar(1:length(meanStateChangeCounts), meanStateChangeCounts, semStateChangeCounts, '.');
hold off;

set(gca, 'xtick', 1:length(uniqueStates), 'xticklabel', stateLabelsForPlot);

title('Mean and SEM of State Change Counts by Initial State');
xlabel('Initial State');
ylabel('Mean Number of State Changes');

legend('Mean State Change Count', 'SEM', 'Location', 'best');