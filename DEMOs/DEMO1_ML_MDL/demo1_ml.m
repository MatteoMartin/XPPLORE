% 
% Chapter 4.2: Model, Simulation & Nullclines
% 
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 04/18/2025

%% SECTION 4.1 - PREPARATION

% Clear Environment.
clear all; close all; clc;

% Import Package. Change to YOUR XPPLORE PATH!
addpath(genpath('../../../XPPLORE'))

%% SECTION 4.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('ml.ode');
M % Display content

% SIMULATION - Read the content of a .dat simulation file.
D = Func_ReadData(M,'sim_ml.dat');
D % Display content

% NULLCLINES - Read the content of a .dat nullclines file.
NC = Func_ReadNullclines('nc_n_v.dat');
NC % Display content

%%

% SIMULATION - Visualize a simulation.
fig = figure();
plot(D.t,D.v,'Color','b','LineWidth',1.2)

xlabel('$t$ [ms]','interpreter','latex'), xlim([0 2000])
ylabel('$V$ [mV]','interpreter','latex'), ylim([-80 60])

Func_FigStyle(fig)

%%

% SIMULATION & NULLCLINEs - Visualize the nullclines.
fig = figure();
Func_VisualizeNullclines(NC)

hold on
plot(D.n,D.v,'Color','b','LineWidth',1.2)
hold off

xlabel('$n$ [\ ]','interpreter','latex'), xlim([-0.05 1])
ylabel('$V$ [mV]','interpreter','latex'), ylim([-80 60])

Func_FigStyle(fig)

%%

% SIMULATION & NULLCLINEs - Visualize the nullclines.
fig = figure();
Func_VisualizeNullclines(NC,'VAR',{'v','n'})

hold on
plot(D.v,D.n,'Color','b','LineWidth',1.2)
hold off

xlabel('$V$ [mV]','interpreter','latex'), xlim([-80 60])
ylabel('$n$ [\ ]','interpreter','latex'), ylim([-0.05 1])

Func_FigStyle(fig)

%% FIGURE 7

% BOUNDARIEs
B.t = [0  2000];
B.V = [-80  60];
B.n = [-0.05 1];

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()
plot(D.t,D.v,'Color','b','LineWidth',1.2)

text(B.t(1)-(B.t(2)-B.t(1))*0.25,B.V(2),'(A)','interpreter','latex')

xlabel('$t$ [s]','interpreter','latex'), xlim(B.t)
ylabel('$V$ [mV]','interpreter','latex'), ylim(B.V)

xticks([0 1000 2000])
xticklabels({'0','1','2'})

% (B)
nexttile()
Func_VisualizeNullclines(NC)

hold on
plot(D.n,D.v,'Color','b','LineWidth',1.2)
hold off

text(B.n(1)-(B.n(2)-B.n(1))*0.15,B.V(2),'(B)','interpreter','latex')

xline(0,'LineWidth',0.8,'LineStyle',':')

set(gca,'YAxisLocation','right')

xlabel('$n$ [\ ]','interpreter','latex'), xlim(B.n)
ylabel('$V$ [mV]','interpreter','latex'), ylim(B.V)

xticks([0 0.25 0.50 0.75 1])
xticklabels({'0','0.25','0.50','0.75','1'})

Func_FigStyle(fig,'OPTIONs',opts)
Func_FigExport(fig,'demo1_IJBC_ml')
