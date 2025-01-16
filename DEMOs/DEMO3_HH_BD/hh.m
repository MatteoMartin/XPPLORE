% EXAMPLE - HH - AUTORePO structure
% Last update - 01/14/2024

% ENVIRONMENT
clear all; close all; clc;

% IMPORT
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%%

% MODEL
M = Func_ReadModel('hh.ode');

% AUTOREPO
AR = Func_ReadAutoRepo(M,'hh.auto');

%%

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','compact','Padding','compact')

nexttile()
Func_VisualizeDiagram(M,AR.BD1_i0)
Func_VisualizeLabPoints(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0  180])
ylabel('$V$ [\ ]','interpreter','latex')  , ylim([-80 40])

nexttile()
Func_VisualizeDiagram(M,AR.BD2_i0_gk)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig)

%%

opts = Func_DOF('width',20);

%%

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','compact','Padding','compact')

nexttile()
Func_VisualizeDiagram(M,AR.BD1_i0)
Func_VisualizeLabPoints(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0  180])
ylabel('$V$ [\ ]','interpreter','latex')  , ylim([-80 40])

nexttile()
Func_VisualizeDiagram(M,AR.BD2_i0_gk)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)
Func_VisualizeDiagram(M,AR.BD1_i0  ,'VAR',{'i0','gk'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','gk'})

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD1_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD1_i0  ,'VAR',{'i0','gk','v'})

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0  60])
zlabel('$V$ [\ ]','interpreter','latex'),   zlim([-80 40])

view(45,10)

Func_FigStyle(fig)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD1_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD3_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD1_i0  ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD3_i0  ,'VAR',{'i0','gk','v'})

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0  60])
zlabel('$V$ [\ ]','interpreter','latex'),   zlim([-80 40])

view(45,10)

Func_FigStyle(fig)