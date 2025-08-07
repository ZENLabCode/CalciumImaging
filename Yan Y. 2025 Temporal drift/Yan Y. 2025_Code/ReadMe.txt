Funtions:

f_directEnvNorm: Is used to normalize dFF data that extract from Fiji, normalized dff is used for event detection

Count_stable_cells: Count the number of cells that remain stable (unchanged state) through all previous time points.(Figure2 M-P )
                    %0= Inactive 5= Awake, 6= NREM, 7= REM 
                    % Input : *CellTags_EvolutionMatrix_Ordered* can be generate in the `Sessions_Analysis_v2.m`

Count_state_changs: % Calculate the state changes of all neurons frome the session1 and plot the distribution (Figure2)
                    % Input : *CellTags_EvolutionMatrix_Ordered* can be generate in the `Sessions_Analysis_v2.m`