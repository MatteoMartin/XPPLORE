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

%%

% AUTOREPO
AR = Func_ReadAutoRepo(M,'hh.auto');

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_i0)
Func_VisualizeLabPoints(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0  180])
ylabel('$V$ [\ ]','interpreter','latex')  , ylim([-80 40])

Func_FigStyle(fig)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_i0,'VAR',{'i0','m'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','m'})

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$m$ [\ ]','interpreter','latex')  , ylim([0 1])

Func_FigStyle(fig)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [\ ]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig)