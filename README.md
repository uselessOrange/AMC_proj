# Refrigeration Digital Twin for System Identification and Predictive Maintenance

This repository contains the MATLAB code, live scripts, data, and figures used to develop and evaluate a gray-box digital twin of refrigeration systems.

The project focuses on identifying physically meaningful parameters from measured operating data:
- thermal resistance `R`
- thermal capacity `C`
- heat-removal / evaporation coefficient `G`

The model is used for:
- system identification
- anomaly detection through operating-cycle analysis
- parameter-shift analysis under induced disturbances
- real-time temperature simulation with compressor hysteresis logic

The work is documented in the accompanying publication `bridging-gray-box-modeling-and-machine-learning.pdf`.

## Project Summary

The digital twin models cabinet temperature dynamics using a thermodynamic gray-box formulation based on a thermal-electrical analogy. Ambient temperature and compressor state are used as inputs, and the model parameters are fitted against measured cabinet temperature data.

The workflow implemented in this repository combines:
- data cleaning and preprocessing
- compressor cycle detection
- statistical feature extraction for anomaly filtering
- parameter estimation with MATLAB optimization tools
- validation across multiple stationary operating segments
- closed-loop simulation with embedded compressor hysteresis control

The main research result is that the framework can detect physically meaningful changes in refrigeration system behavior, especially changes in thermal resistance under disturbance conditions such as periodic door openings.

## Associated Publication

Robert Pedzik, Mikolaj Suchon, Tomasz Barszcz,
"Bridging gray-box modeling and machine learning: A digital twin approach to refrigeration system identification and predictive maintenance,"
Measurement: Digitalization, 2025.

Local copy: `bridging-gray-box-modeling-and-machine-learning.pdf`

## Repository Structure

`Data/`
Experimental datasets and exported measurement files used for modeling and validation.

`DataAnalysisAndProcessing/`
MATLAB scripts and live scripts for data cleaning, filtering, cycle detection, feature extraction, and exploratory analysis.

`DataProcessing for training/`
Training-oriented preprocessing experiments and extracted intermediate data.

`Figures/`
Result plots, exported MATLAB figures, and publication-ready graphics.

`Modeling/`
Core model-development work, including earlier modeling experiments and state-space formulations.

`Optimization/`
Optimization experiments and supporting code, including genetic algorithm and local-search tests.

`ParameterIdentification/`
Parameter-identification experiments, result datasets, and scripts related to identifying `R`, `C`, and `G` under different operating conditions.

`RealTimeModeling/`
Closed-loop and real-time simulation work, including compressor logic, hysteresis behavior, and Simulink assets.

`RelevantPapers/`
Reference papers used during the development of the methodology.

## Typical Workflow

1. Prepare and inspect raw measurement data in `Data/`.
2. Clean and segment the signals in `DataAnalysisAndProcessing/`.
3. Detect anomalies and isolate stationary operating chunks.
4. Estimate model parameters in `ParameterIdentification/` and `Optimization/`.
5. Compare parameter sets across normal and disturbed operation.
6. Validate time-domain behavior in `RealTimeModeling/`.

## Main Methods Used

- Gray-box thermal modeling
- State-space representation of cabinet temperature dynamics
- Genetic algorithm-based parameter estimation
- Feature-based anomaly detection on compressor cycles
- Cross-chunk validation of fitted parameter sets
- Closed-loop simulation with hysteresis compressor control

## Software Requirements

This project is built primarily in MATLAB and uses MATLAB Live Scripts (`.mlx`) throughout the workflow.

Recommended environment:
- MATLAB
- Global Optimization Toolbox
- Simulink

Some scripts may depend on toolbox availability and on local MATLAB paths being set consistently with the repository layout.

## Notes

- The repository reflects research workflow code and experiments, not a packaged MATLAB toolbox.
- Several scripts are exploratory and correspond to intermediate experiments performed during model development.
- The publication provides the best high-level description of the methodology and results.

## Citation

If you use this repository in academic work, cite the associated paper in `bridging-gray-box-modeling-and-machine-learning.pdf`.
