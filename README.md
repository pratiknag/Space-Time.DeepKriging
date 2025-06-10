# Space-Time.DeepKriging  

This repository contains supplementary code for the paper:  
[*Spatio-temporal DeepKriging for Interpolation and Probabilistic Forecasting*](https://doi.org/10.1016/j.spasta.2023.100773).  

## Overview  

This work introduces **Space-Time.DeepKriging**, a deep neural network (DNN) model designed for **spatio-temporal process interpolation and probabilistic forecasting**. The repository provides code implementations for reproducing key results presented in the paper.  

## Citation  

If you use this code, please cite the following paper:  

**Nag, P., et al. (2023).**  
*Spatio-temporal DeepKriging for Interpolation and Probabilistic Forecasting*.  
Spatial Statistics, 100773.  
[https://doi.org/10.1016/j.spasta.2023.100773](https://doi.org/10.1016/j.spasta.2023.100773)  

---

## Repository Contents  

- **`GpGp_example.R`**: This script reproduces the simulation comparisons with the `GpGp` package, as shown in the paper.  
- **Jupyter Notebooks**: Two interactive notebooks that implement **Space-Time.DeepKriging** for various datasets, demonstrating **interpolation** and **forecasting**.  

---

## Getting Started  

1. Clone the repository:  
   ```bash
   git clone https://github.com/your-repo/Space-Time.DeepKriging.git
   cd Space-Time.DeepKriging
---
## 🔗 PyTorch Implementations

We also provide standalone PyTorch repositories for key spatio-temporal modeling components used in this project:

- 📌 **Spatio-temporal DeepKriging (STDK) for Interpolation**  
  Reproducible and modular implementation of ST DeepKriging interpolation.  
  🔗 [Spatio-temporalDeepKriging-Pytorch](https://github.com/pratiknag/Spatio-temporalDeepKriging-Pytorch.git)

- 🔁 **ConvLSTM for Forecasting**  
  A clean, reusable PyTorch implementation of ConvLSTM for spatio-temporal forecasting tasks.  
  🔗 [pytorch-convlstm](https://github.com/pratiknag/pytorch-convlstm.git)

These repositories are designed for reusability and clarity, making it easier to incorporate or benchmark these models in your own research.

