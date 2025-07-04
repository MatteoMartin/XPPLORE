# **XPPLORE: Import, visualize, and analyze XPPAUT data in MATLAB**

This repository accompanies our [formal writeup](https://arxiv.org/abs/2507.02709v1) (on ArXiv at the moment) that will be available on ArXiv and will be submitted for publication.

---

Have you ever wished for a magic wand to handle continuation calculations from **XPPAUT** with ease?  
🔎 **XPPLORE** is here to revolutionize the way students, professors, and researchers work with bifurcation diagrams (BDs). Say goodbye to tedious processes and hello to streamlined workflows!

---

## 💡 **The problem we're solving**

As Ph.D. students, we’ve faced the relentless challenge of producing **high-quality bifurcation diagrams** for:
- Academic publications
- Oral presentations
- Course assignments
- Personal notes

We knew there had to be a better way. So, we rolled up our sleeves and created **XPPLORE**—a toolbox to simplify and supercharge your work.

### **Why start with MATLAB?**

MATLAB is a fantastic launchpad for innovation, and we’re working to expand XPPLORE to Python next. Stay tuned!

---

## 🚀 **Why XPPLORE? It's as Easy as 1-2-3!**

### Files needed (Hodgkin-Huxley, for example):
- `HH.ode` — Your model file
- `HH.auto` — Your bifurcation data, saved from XPPAUT
- `HH.m` — The MATLAB script that makes the XPPLORE-ation possible 

### MATLAB script (example):

```matlab
1. M   = Func_ReadModel('HH.ode');
2. AR  = Func_ReadDiagram(M,'HH.auto');
3. fig = figure();
4. Func_VisualizeDiagram(M,AR.BD1_IApp);
5. Func_VisualizeBifurcation(M,AR.BD1_IApp);
6. Func_SaveFigure(fig,opts,'FigureName');
```

In just **six lines of code**, you can generate stunning, publication-ready visuals!  
**Don’t just take our word for it—download XPPLORE and see for yourself!**

---

## 📝 **Delve deeper with our demos**

### Ready-to-Run Examples:
- **DEMO1_ML_MDL**: Learn about the basics regarding the model's structure, simulations and nullclines
- **DEMO2_HH_1BD&EIG**: Visualize your first one-parameter bifurcation diagram (1P-BD) and inspect its eigenvalues
- **DEMO3_HH_1P2PBDs**: Expand 1P- and 2P-BD visualization capabilities (change visualized axes, variables, etc.)
- **DEMO4_HH_MULTI**: Upgrade BD visualizations by merging multiple diagrams (one- and two-parameter)
- **DEMO5_CK_AVG**: Leverage continuation data to retrospectively apply averaging theory & incorporate results into figures
- **DEMO6_CK_LCM**: Utilize continuation data to visualize manifolds of limit cycles
- **DEMO7_FHN_SM**: Reconstruct slow manifolds as surfaces in your MATLAB plots

### What you’ll learn:
- Import XPPLORE with two lines of code
- Read models, nullclines and simulations with XPPLORE
- Explore bifurcation diagrams (one- & two- parameter)
- Create fun, professional visualizations
- Apply averaging theory during post-processing
- Create surfaces with calculated trajectories 

---

## 🛠️ **The XPPLORE toolkit**

### **Core tools**
- **`Func_ReadAutoRepo`**: Reading `.auto` continuation files, using `ParsingAUTO` functions
- **`Func_ReadData`**: Extract data from `.dat` simulation files
- **`Func_ReadModel`** Parse `.ode` files, using `ParsingODE` functions
- **`Func_ReadNullclines`**: Reading `.dat` files storing nullcline information

### **Visualization tools**
- **`Func_VisualizeDiagram()`**: Showcase diagram branches with style
- **`Func_VisualizeEig()`**: Display eigenvalues to understand bifurcation diagrams from another angle
- **`Func_VisualizeLabPoints()`**: Highlight key labelled points
- **`Func_VisualizeNullclines()`**: Investigate nullclines and overlay simulated systems

### **Styling and exporting**
- **`Func_DOBD()`**: Customizeable/Default options to visualize bifurcation diagrams
- **`Func_DOF()`**: Customizeable/Default options for (non-BD) figures
- **`Func_FigExport()`**: Export figures with ease
- **`Func_FigStyle()`**: Apply style to figures for export

### **Additional capabilities**
- **`Func_GetEig`**: Extract eigenvalues from continuation information for user-friendly format
- **`Func_GetTRJ`**: Extract periodic orbit (PO) trajectories from continuation information for user-friendly format
- **`Func_WritePoints`**: Creates `.dat` file which can be used in XPP. Imitates XPP's WritePts function

---

## 👥 **Meet the team behind XPPLORE**

### **Matteo Martin** (†)
**Affiliation**: University of Padova, Department of Information Engineering  

### **Anna K. Thomas** (†)
**Affiliation**: University of Pittsburgh, Department of Mathematics

#### *(†) Equal contributors to this project.*

---

#### **📅 Last Updated:** June 19, 2025
