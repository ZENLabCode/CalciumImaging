function [dataArrayEnv, F0Weight] = f_directEnvNorm(filePath, clusterNum, numWorkers);
%[dataArrayEnv, F0Weights] = f_directEnvNorm(filePath, clusterNum,numWorkers);
%
%This function is designed to align the raw calcium traces stored in the
%text file with name 'filePath' to zero using an F0 estimated by fitting a number of Gaussian
%distributions (clusterNum) and normalize them using the envelope
%normalization. For more infos refer to Lukas.
%
%INPUTS (all optional):
% filePath: The path and name to the file where the raw data is stored.
%           Make sure that each column represents a cell and its rows the different
%           time points.
% clusterNum: The number of Guassisans the fluorescence intensities should
%             be clustered into to find F0 (default = 3).
% numWorkers: Number of parallel workers for the estimation of the
%             Gaussians (default = 55).
%
%OUTPUTS: 
%dataArrayEnv: The normalized calcium time series.
%F0Weights: The estimated baseline F0 and the Weight, that is, the
%           percentage of explained data by the distribution.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%---------Convenience-------
addpath(genpath('Z:\Lab_resources\calcium_imaging_toolbox'));

if ~exist('filePath')|| isempty(filePath) %only tifs specified so far, h5 could easily be implemented
    [FileName,PathName] = uigetfile({'*.txt'},'Select the text file for fluorescence normalization');
    filePath = [PathName FileName];
end

if ~exist('clusterNum')|| isempty(clusterNum) 
    clusterNum = 3;
end

if ~exist('numWorkers')|| isempty(numWorkers)
    numWorkers = 5;
end


%%
%---------Loading data and generating sessionStarts
tracesRaw = importdata(filePath, '\t'); %load in the data from text file
% tracesRaw = importdata(filePath, ','); %load in the data from text file
if isa(tracesRaw, 'struct') %check whether the text file still contains the header information and if so...
    tracesRaw = tracesRaw.data; % ... retrieve the data
    tracesRaw = tracesRaw(:,2:end); %and delete the first column (frame numbering)
end
    
sessionStarts = [0 size(tracesRaw,1)];

%% Find the F0 and re-zero the traces with the Gaussian fitting (probably optional)    
    
tracesZeroed = NaN(size(tracesRaw)); %pre-allocation
F0Weight = NaN(2,length(sessionStarts)-1,size(tracesZeroed,2));
% pObject = parpool('Castor',numWorkers); %define the pool of workers

% parfor j=1:size(tracesRaw,2)
for j=1:size(tracesRaw,2)
    subst = tracesRaw(:,j);
    substi = NaN(2,length(sessionStarts)-1);
    for k=1:length(sessionStarts)-1
        [W,M,V,L] = EM_GM(subst(sessionStarts(k)+1:sessionStarts(k+1)),clusterNum);
        [F0,idx] = min(M);
        substi(:,k) = [F0; W(idx)];
        % F0Weight(1:2,k,j) = [F0; W(idx)];
        %     F0Weight(1,k,j) = F0;
        %     F0Weight(2,k,j) = W(idx);
        subst(sessionStarts(k)+1:sessionStarts(k+1)) = subst(sessionStarts(k)+1:sessionStarts(k+1))-F0;
    end
    tracesZeroed(:,j) = subst;
    F0Weight(:,:,j) = substi;
end
% delete(pObject);
%% Do envelope normalizations
dataArrayEnv = NaN(size(tracesZeroed)); % pre-allocate space

Diff = [];
y = [];
env = [];
for i=1:size(tracesZeroed,2) 
  Diff(:,i) = diff(tracesZeroed(:,i));
  y = hilbert(Diff(:,i));
  env(:,i) = abs(y);
   for j=1:length(sessionStarts)-1
   dataArrayEnv(sessionStarts(j)+1:sessionStarts(j+1),i) = tracesZeroed(sessionStarts(j)+1:sessionStarts(j+1),i)/(median(env(sessionStarts(j)+1:sessionStarts(j+1)-1,i)));
   end
  clear y;
%sNorm(:,i) = tracesRaw(:,i)/std(Diff(:,i)); %alternatively normalize to
%the standard deviation of the distribution of Diff.
end
F0Weight = squeeze(F0Weight);

end
