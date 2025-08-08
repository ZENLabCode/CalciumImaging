# Calcium Imaging Event Detection - Demo Dataset

This demo dataset accompanies the **Calcium Imaging Events Based Analysis - Lite 1.14.7** toolbox. It provides a complete example workflow, from raw data input to event detection and export, using MATLAB-based GUI tools.

---

## 1. System Requirements

### Software & Dependencies
- **MATLAB** version **2019b or later**
- Required MATLAB Toolboxes:
  - **Signal Processing Toolbox**
  - **Image Processing Toolbox**
  - **Data Acquisition Toolbox**
  - **Curve Fitting Toolbox**
  - **Statistics and Machine Learning Toolbox**
- **Calcium Imaging Events Based Analysis - Lite 1.14.7**

### Hardware
- Standard desktop or laptop computer
- 64 GB RAM or higher recommended for faster processing

### Tested Environments
- Windows 10, 64GB RAM, MATLAB 2019b
---

## 2. Installation Guide

### Steps
1. Download and extract the code file from GitHub.
2. Open MATLAB and navigate to the directory containing:
   - `CalciumImaging_GUI.mlapp`
   or directly open `CalciumImaging_GUI.mlapp` from the 
   `Calcium Imaging Events Based Analysis - Lite 1.14.7` folder
3. This step takes only a few seconds.
---

## 3. Demo

### Input Data
Each mouse (2 MCH mice included in the demo) has **21 recording sessions**. Each session contains:
- Sleep hypnogram (scored from EEG/EMG, 1=wake, 2= NREM, 4= REM)
- Normalized calcium imaging signal (ΔF/F)
- EMG signal

### Running the Demo-Dataset1
1. Open `CalciumImaging_GUI.mlapp` in MATLAB.
2. Select the FileName for the output file, and the Folder you want to save the file in.
3. Use default settings,
-Optional: some data might have extra empty, blank images, in case you want to remove these, select the Cut Zeros option. Similarly adjust other options if needed.

3. Click "Start event detection" (MATLAB App Designer required).
4. Choose the dataset in the Dataset1 folder: MCH 
5. Event detection starts, a progress bar will appear and progress will also be reported in Matlab's Command Window.
- At the end of the analysis, make sure the file was saved.


### Runtime
- **30 minutes to 1 hour** for the demo-Dataset1 (depends on computer specs)


### Expected Output
- `.mat` file containing:*CalciumTraces_Clean_AllSessions* 
                         *Event_AllSessions*
                         *Hypnogram_AllSessions*
                         *HypnoState*
                         *Mouse_Names*
                         *MouseCellsRecorded*
                         *Opts*

- Data is structured for compatibility with downstream scripts 
---
### Running the extra analysis
- Now run the second part of the analysis to prepare the plots.
- Some plots can be run via the GUI (Analysis 1, Analysis 2)
- Other plots must be run via a more specific script "Session_Analysis_v2".
Before opening the script, first close the GUI and use the "clear" command in MATLAB.

1. **Load the Output File**
   - Open MATLAB.
   - Load the output file from the path you set:
   - This `.mat` file contains calcium event information detected across different sleep states of 2 MCH mouse.

2. **Analyze the Output**
   - Navigate to the following script:
     ```
     Calcium Imaging Events Based Analysis - Lite 1.14.7/
     └── Functions/
         └── New Analysis/
             └── Sessions_Analysis_v2.m
     ```
   - Open and run `Sessions_Analysis_v2.m` in MATLAB to begin analyzing the event data.

The script has a semi-automatic execution, and is intended to be mostly run section by section, depending on what analysis is needed. The first 2 sections, however (Options and Inizialization) must always be run.

The analysis and plots found in this script are: 
Events Clustering, Clustering Changes, single-cell State Selectivity Analysis, State Selectivity flow plot ("Clustering flow evolution"), Average calcium traces across state transitions, Events Rates averages and changes, Correlation-based graph analysis.
Each analysis should be automatically producing and saving the relative plots that constitute the figures used in the paper.
   
 - All the analysis are based on "Events_Rate" in this study, but other options are possible by defining: Opts.ClusteringVariable.
   
The dataset for all the mouse strains included in this study can be provided upon request. 
Please contact:  antoine.adamantidis@unibe.ch 
  

