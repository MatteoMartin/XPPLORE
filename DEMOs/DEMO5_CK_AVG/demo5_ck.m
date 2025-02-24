% 
% Chapter 3.4 Averaging
% 
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 02/21/2025

%% from SECTION 3.1 - PREPARATION

% Clear Environment.
clear all; close all; clc;

% Import Package. Change to YOUR XPPLORE PATH!
addpath(genpath('../../../XPPLORE'))

%% from SECTION 3.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('ck.ode');

%% from SECTION 3.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR = Func_ReadAutoRepo(M,'ck.auto');

%% SECTION 3.4 - AVERAGING

% TRAJECTORIEs - Extract the periodic orbits.
TRJ = Func_GetTRJ(M,AR.BD1_c);

%%
% AVERAGING - Applying averaging.
[c,J,BZ] = Func_Averaging(M,TRJ,0.32);

%%
% VISUALIZATION - Visualization of 1P-BD with averaging results.
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

xlim([-0.5   1]), xlabel('$c$ [mM]','interpreter','latex')
ylim([-80  -10]), ylabel('$V$ [mV]','interpreter','latex')

Func_FigStyle(fig);

%%
% WRITE POINTs - Convert and export the .auto in a .dat file
Func_WritePoints(M,AR.BD1_c,'BD.dat')

%% FIGURE 13

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()
Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

hold on
plot(AR.BD1_c.LABPTs.(BZ).c,AR.BD1_c.LABPTs.(BZ).vU,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',3)
plot(AR.BD1_c.LABPTs.(BZ).c,AR.BD1_c.LABPTs.(BZ).vL,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',3)
hold off

text(0.98,-11,'$k_{PMCA}$ = 0.32 ms$^{-1}$','interpreter','latex','HorizontalAlignment','right','VerticalAlignment','top')
text(-0.9,-10,'(A)','interpreter','latex')

xlim([-0.5   1]), xlabel('$c$ [$\mu$M]','interpreter','latex')
ylim([-80  -10]), ylabel('$V$ [mV]','interpreter','latex')

% (B)
nexttile()
plot(c,J,'Color','b','LineWidth',1.2)

hold on
plot(c(islocalmin(abs(J))),J(islocalmin(abs(J))),'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',3)
hold off

yline(0,'Color','k','LineStyle',':','LineWidth',0.8)

text(-0.48,0.25,'(B)','interpreter','latex')

xlim([-0.4 0.2]), xlabel('$c$ [$\mu$M]','interpreter','latex')
ylabel('$\langle \dot{c} \rangle$ [$\mu$M/ms]','interpreter','latex')

set(gca,'YAxisLocation','right')

Func_FigStyle(fig,'OPTIONs',opts)
%Func_FigExport(fig,'demo5_DSWEB_AVG')