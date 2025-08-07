# Calcium Imaging Event Detection - Demo Dataset

This demo dataset accompanies the **Calcium Imaging Events Based Analysis - Lite 1.14.7** toolbox. It provides a complete example workflow, from raw data input to event detection and export, using MATLAB-based GUI tools.

---

## 1. System Requirements

### Software & Dependencies
- **MATLAB** version **2019a or later**
- Required MATLAB Toolboxes:
  - **Signal Processing Toolbox**
  - **Image Processing Toolbox**
  - **Data Acquisition Toolbox**
  - **Curve Fitting Toolbox**
  - **Statistics and Machine Learning Toolbox**
- **Calcium Imaging Events Based Analysis - Lite 1.14.7**

### Hardware
- Standard desktop or laptop computer
- 32 GB RAM or higher recommended for faster processing

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
3. This step take only few seconds.
---

## 3. Demo

### Input Data
Each mouse (2 MCH mice included in the demo) has **21 recording sessions**. Each session contains:
- Sleep hypnogram (scored from EEG/EMG, 1=wake, 2= NREM, 4= REM)
- Normalized calcium imaging signal (ΔF/F)
- EMG signal

### Running the Demo-Dataset1
1. Open `CalciumImaging_GUI.mlapp` in MATLAB.
2. Use default settings, but **update the input filename and output save path**.
3. Click "Start event detection" (MATLAB App Designer required).
4. Choose the dataset in Dataset1 folder: MCH 
5. Event detection start with a progress bar.

4. Use default settings, but **update the input filename and output save path**.
5. Start event detection.

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
   

3. **Perform Additional Analyses**
   - Additional analysis functions are listed and described within `Sessions_Analysis_v2.m`.
   - All the analysis are based on "Events_Rate" in this study. 
   - But other options are possible by define: Opts.ClusteringVariable
   
Dataset for all the mouse strains included in this study can be provided upon request, 
please contact:  antoine.adamantidis@unibe.ch 
  
