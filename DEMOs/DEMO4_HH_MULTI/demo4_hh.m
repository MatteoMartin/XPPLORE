% 
% Chapter 4.3 Bifurcation Diagram
%         - 4.3.3 Multi BDs
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

% VISUALIZATION - Visualize a 1P- and a 2P-BD in the same 3D plot.
%                 Visualize multiple 1P-BDs and a 2P-BD in the same 3D plot.
fig = figure();

Func_VisualizeDiagram(M,AR.BD2_i0_gk ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD1_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD3_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD1_i0  ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD3_i0  ,'VAR',{'i0','gk','v'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 180])
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex'), ylim([0  60])
zlabel('$V$ [mV]','interpreter','latex'),   zlim([-80 40])

view(45,10)

Func_FigStyle(fig)

%% FIGURE 11

% BOUNDARIEs
B.i0 = [0  180];
B.gK = [0   60];
B.V  = [-80 40];

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','compact','Padding','compact')

% (A)
nexttile()

Func_VisualizeDiagram(M,AR.BD2_i0_gk ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD1_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD1_i0  ,'VAR',{'i0','gk','v'})

text(B.i0(1)-(B.i0(2)-B.i0(1))*0.28,B.gK(1)-(B.gK(2)-B.gK(1))*0.28,B.V(2),'(A)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim(B.i0), xticks([0 90 180])
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex')    , ylim(B.gK), yticks([0 30 60])
zlabel('$V$ [mV]','interpreter','latex')             , zlim(B.V )

view(45,10)

% (B)
nexttile()

Func_VisualizeDiagram(M,AR.BD2_i0_gk ,'VAR',{'i0','gk','v'})
Func_VisualizeDiagram(M,AR.BD1_i0    ,'VAR',{'i0','gk','v'})
Func_VisualizeLabPoints(M,AR.BD1_i0  ,'VAR',{'i0','gk','v'})

text(B.i0(2)+(B.i0(2)-B.i0(1))*0.28,B.gK(1)-(B.gK(2)-B.gK(1))*0.28,B.V(2),'(B)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim(B.i0), xticks([0 90 180])
ylabel('$g_K$ [mS/cm$^2$]','interpreter','latex')    , ylim(B.gK), yticks([0 30 60])
zlabel('$V$ [mV]','interpreter','latex')             , zlim(B.V )

view(135,10)

Func_FigStyle(fig,'OPTIONs',opts)
%Func_FigExport(fig,'demo4_IJBC_MULTI')