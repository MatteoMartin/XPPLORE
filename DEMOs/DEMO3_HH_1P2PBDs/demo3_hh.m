% 
% Chapter 4.3 Bifurcation Diagram
%         - 4.3.2 1- & 2-Parameter BDs
% 
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 04/18/2025

%% from SECTION 4.1 - PREPARATION

% Clear Environment.
clear all; close all; clc;

% Import Package. Change to YOUR XPPLORE PATH!
addpath(genpath('../../../XPPLORE'))

%% from SECTION 4.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('hh.ode');

%% SECTION 4.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR = Func_ReadAutoRepo(M,'hh.auto');

%%

% VISUALIZATION - Visualize a 2P-BD.
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk)
Func_VisualizeDiagram(M,AR.BD1_i0  ,'VAR',{'i0','gk'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','gk'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex'), ylim([0 60])

Func_FigStyle(fig)

%% Figure 10

% BOUNDARIEs
B.I  = [0 200];
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

xlim([0 200])
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

xlim([0 200])
ylim([0 60])

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo3_IJBC_2PBD')
