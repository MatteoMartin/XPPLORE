% EXAMPLE - HH - MODEL & AUTORePO structure
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

Func_VisualizeDiagram(M,AR.BD1_i0)
Func_VisualizeLabPoints(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex'), xlim([0  200])
ylabel('$V$ [\ ]','interpreter','latex')  , ylim([-80 40])

Func_FigStyle(fig)