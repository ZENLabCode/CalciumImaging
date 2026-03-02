    % Count the number of cells that remain stable (unchanged state) 
    % through all previous time points.
    %0= Inactive£¬5= Awake, 6= NREM, 7= REM 
    % Input : CellTags_EvolutionMatrix_Ordered can be generate in the `Sessions_Analysis_v2.m`
    
    
    % Get the dimensions of the input matrix
    [num_cells,num_times] = size(CellTags_EvolutionMatrix_Ordered);
    
    % Initialize the output matrix to zeros
    Count_stablecell = zeros(4, num_times);
    
    % Matrix to track if a cell has changed its cluster at any time point
    has_changed = zeros(1, num_cells);
    
    % Iterate through each time point
    for t = 1:num_times
        % Iterate through each cell
        for c = 1:num_cells
            cluster = CellTags_EvolutionMatrix_Ordered(c, t);
            
            % Update the has_changed status for the cell if it changed its cluster
            if t > 1 && CellTags_EvolutionMatrix_Ordered(c, t) ~= CellTags_EvolutionMatrix_Ordered(c,t-1)
                has_changed(c) = 1;
            end
            
            % If the cell has not changed its cluster till now, 
            % count it for the current cluster at the current time point
            %0= Inactive£¬5= Awake, 6= NREM, 7= REM 
            if ~has_changed(c)
                switch cluster
                    case 0
                        Count_stablecell(1, t) = Count_stablecell(1, t) + 1;
                    case 5
                        Count_stablecell(2, t) = Count_stablecell(2, t) + 1;
                    case 6
                        Count_stablecell(3, t) = Count_stablecell(3, t) + 1;
                    case 7
                        Count_stablecell(4, t) = Count_stablecell(4, t) + 1;
                end
            end
        end
    end

%% Plot the figures
% Plotting
figure;

% Plot for each cluster
plot(Count_stablecell(1, :), 'k-', 'LineWidth', 2); % Inactive (Black)
hold on;
plot(Count_stablecell(2, :), 'b-', 'LineWidth', 2); % Awake (Blue)
plot(Count_stablecell(3, :), 'g-', 'LineWidth', 2); % NREM (Green)
plot(Count_stablecell(4, :), 'y-', 'LineWidth', 2); % REM (Yellow)

% Legends and labels
legend('Inactive', 'Awake', 'NREM', 'REM');
xlabel('Time Points');
ylabel('Number of Cells');
title('Number of Cells in Each Cluster Across Time Points');
grid on;
hold off;
% When you run this code in MATLAB, it will display a line plot showing the number of cells in each cluster across the time points. Each line will be colored according to the cluster it represents.



%% Count total cell
% count total cell across time
    % Count the number of cells in each cluster for each session (time point).

    % Get the number of time points
    num_times = size(CellTags_EvolutionMatrix, 2);
    
    % Initialize the output matrix
    output_matrix = zeros(4, num_times);
    
    % Define cluster labels
    clusters = [0, 5, 6, 7];
    
    % Count cells for each cluster at each time point
    for t = 1:num_times
        for c = 1:4
            Total_cell_each_cluster_matrix(c, t) = sum(CellTags_EvolutionMatrix(:, t) == clusters(c));
        end
    end



% Plotting
figure;

% Plot for each cluster
plot(Total_cell_each_cluster_matrix(1, :), 'k-', 'LineWidth', 2); % Inactive (Black)
hold on;
plot(Total_cell_each_cluster_matrix(2, :), 'b-', 'LineWidth', 2); % Awake (Blue)
plot(Total_cell_each_cluster_matrix(3, :), 'g-', 'LineWidth', 2); % NREM (Green)
plot(Total_cell_each_cluster_matrix(4, :), 'y-', 'LineWidth', 2); % REM (Yellow)

% Legends, labels, and title
legend('Inactive', 'Awake', 'NREM', 'REM');
xlabel('Time Points');
ylabel('Total Number of Cells');
title('Total Number of Cells in Each Cluster Across Time Points');
grid on;
hold off;
