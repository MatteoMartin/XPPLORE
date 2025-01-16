% EXAMPLE - FHN - Nullclines
% Last update - 01/14/2024

% ENVIRONMENT
clear all; close all; clc;

% XPPLORE
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%%

% MODEL
M = Func_ReadModel('fhn.ode');

%%

% DATA
D = Func_ReadData(M,'sim.dat');

% NULLCLINEs
NC = Func_ReadNullclines('nc_y_x.dat');

%%

% VISUALIZATION
fig = figure();

Func_VisualizeNullclines(NC);

hold on
plot(D.y,D.x,'Color','b','LineWidth',1.2)
hold off

xline(0,'Color','k','LineStyle',':','LineWidth',0.8)
yline(0,'Color','k','LineStyle',':','LineWidth',0.8)

xlabel('$x$ [\ ]','interpreter','latex')
ylabel('$y$ [\ ]','interpreter','latex')

Func_FigStyle(fig)

