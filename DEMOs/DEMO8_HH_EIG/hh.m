
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

opts = Func_DOF('ClippingStyle','3dbox');

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$i_0$ [\ ]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [\ ]','interpreter','latex')
Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,4})

xlabel('$i_0$ [\ ]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'TYPE','Im')

xlabel('$i_0$ [\ ]','interpreter','latex')
ylabel('$\Im(\lambda)$','interpreter','latex')
zlabel('$V$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)

%% 

[EIG, EIGLAB] = Func_GetEig(AR.BD1_i0);

EIG{2}(5,:,1)

EIGLAB(3,:,2)