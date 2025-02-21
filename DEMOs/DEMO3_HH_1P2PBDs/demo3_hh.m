% 
% Chapter 3.3 Bifurcation Diagram
%         - 3.3.2 1- & 2-Parameter BDs
% 
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 02/21/2025

%% SECTION 3.1 - PREPARATION

% ENVIRONMENT
clear all; close all; clc;

% IMPORT
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%% SECTION 3.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('hh.ode');

%% SECTION 3.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR = Func_ReadAutoRepo(M,'hh.auto');

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)
Func_VisualizeDiagram(M,AR.BD1_i0  ,'VAR',{'i0','gk'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','gk'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig)

%%

% BOUNDARIEs
B.I  = [0  180];
B.gK = [0   60];

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,"TileSpacing",'compact','Padding','compact')

% (A)
nexttile();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)

text(B.I(1)-(B.I(2)-B.I(1))*0.23,B.gK(2),'(A)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex')

xlim([0 180])
ylim([0 60])

% (B)
nexttile();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)
Func_VisualizeDiagram(M,AR.BD1_i0  ,'VAR',{'i0','gk'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','gk'})

text(B.I(1)-(B.I(2)-B.I(1))*0.15,B.gK(2),'(B)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex')

set(gca,'YAxisLocation','right')

xlim([0 180])
ylim([0 60])

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo3_DSWEB_2PBD')
