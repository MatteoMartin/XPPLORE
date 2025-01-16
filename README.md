# 🧪 **XPPLORE: The Toolbox for Bifurcation Diagrams**

Have you ever wished for a magic wand to handle continuation calculations from **XPPAUT** with ease?  
Well, your wish has come true! **XPPLORE** is here to revolutionize the way students, professors, and researchers work with bifurcation diagrams. Say goodbye to tedious processes and hello to streamlined workflows!

---

## 💡 **The Problem We Solve**

As PhD students, we’ve faced the relentless challenge of producing **high-quality bifurcation diagrams** for:
- 📚 Academic publications
- 🎤 Oral presentations
- 📑 Assignments
- ✏️ Personal notes

We knew there had to be a better way. So, we rolled up our sleeves and created **XPPLORE**—a toolbox to simplify and supercharge your work.

### **Why Start with MATLAB?**

MATLAB is a fantastic launchpad for innovation! But don’t worry, we’re planning to expand XPPLORE to other programming languages. Stay tuned!

---

## 🚀 **Why XPPLORE? It's as Easy as 1-2-3!**

### Folder content:
- `HH.ode` — Your model file
- `HH.auto` — Your bifurcation data
- `HH.m` — The script that makes the magic happen

### MATLAB script:

```matlab
1. M   = Func_ReadModel('HH.ode');
2. AR  = Func_ReadDiagram(M,'HH.auto');
3. fig = figure();
4. Func_VisualizeDiagram(M,AR.BD1_IApp);
5. Func_VisualizeBifurcation(M,AR.BD1_IApp);
6. Func_SaveFigure(fig,opts,'FigureName');
```

In just **six lines of code**, you’ll generate stunning, publication-ready visuals!  
**Don’t just take our word for it—download XPPLORE and see for yourself!**

---

## 📝 **Delve deeper with some examples**

### Ready-to-Run Examples:
- **DEMO1_HH_MDL**: Learn about the basics regarding the model's structure and visualize your first BD!
- **DEMO2_HH_BD**: Two BDs saved in the same .auto file? The proof of the pudding is in the eating!
- **DEMO3_HH_BD**: Movement of bifurcations, two parameter bifurcation diagrams and much more!
- **DEMO4_CK_AVG**: Off-line one-dimensional averaging analysis!
- **DEMO5_CK_WP**: The old, but nice and always useful AUTO's WritePoints function!
- **DEMO6_FHN_NC**: Do you need nullclines? In this demo, you can learn the tools to load and visualize them!
- **DEMO7_FHN_SM**: Learn how to visualize slow manifold reconstruction calculations computed with XPPAUT.

### What You’ll Learn:
- Effortlessly import XPPLORE (temporary solution)
- Read models with XPPLORE
- Explore bifurcation diagrams
- Create stunning visualizations
- Apply off-line averaging theory
- Create surfaces with the calculated trajectories 

---

## 🛠️ **Your XPPLORE Toolkit**

### **Core Tools**
- **`ParsingAUTO`**: Parse `.auto` files effortlessly.
- **`ParsingODE`**: Parse `.ode` files.
- **`Func_ReadData`**: Extract insights from `.dat` simulation files.
- **`Func_ReadAutoRepo`**: Reading `.auto` continuation files.

### **Visualization Tools**
- **`Func_VisualizeDiagram()`**: Showcase diagram branches with style.
- - **`Func_VisualizeLabPoints()`**: Highlight key labelled points.

### **Styling and Exporting**
- **`Func_DOF()`**: Customize figures to your liking.
- **`Func_DOBD()`**: Costumize bifurcation diagrams as you like!
- **`Func_FigStyle()`**: Apply style to figures.
- **`Func_FigExport()`**: Export figures with ease.

---

## 👥 **Meet the Team Behind XPPLAB**

### **Martin Matteo** (†)
**Affiliation**: University of Padova, Department of Information Engineering  

### **Thomas Anna Kishida** (†)
**Affiliation**: University of Pittsburgh, Department of Mathematics

#### *(†) Equal contributors to this project.*

---

### **📅 Last Updated:** January 14, 2024
