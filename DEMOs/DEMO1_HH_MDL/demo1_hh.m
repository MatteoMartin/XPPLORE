% 
% Chapter 3.2: Model, Simulation & Nullclines
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

% Clear Environment.
clear all; close all; clc;

% Import Package. Change to YOUR XPPLORE PATH!
addpath(genpath('../../XPPLORE'))

%% SECTION 3.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('hh.ode');
M % Display content

% SIMULATION - Read the content of a .dat simulation file.
D = Func_ReadData(M,'sim.dat');
D % Display content

% NULLCLINES - Read the content of a .dat nullclines file.
NC = Func_ReadNullclines('nc_h_v.dat');
NC % Display content

%%

% SIMULATION - Visualize a simulation.
fig = figure();
plot(D.t,D.v,'Color','b','LineWidth',1.2)

xlabel('$t$ [ms]','interpreter','latex'), xlim([0 100])
ylabel('$V$ [mV]','interpreter','latex'), ylim([-80 60])

Func_FigStyle(fig)

%%

% SIMULATION & NULLCLINEs - Visualize the nullclines.
fig = figure();
Func_VisualizeNullclines(NC)

hold on
plot(D.h,D.v,'Color','b','LineWidth',1.2)
hold off

xlabel('$h$ [\ ]','interpreter','latex'), xlim([0 1])
ylabel('$V$ [mV]','interpreter','latex'), ylim([-80 60])

Func_FigStyle(fig)

%% FIGURE 2

% BOUNDARIEs
B.t = [0  100];
B.V = [-80 60];
B.h = [-0.05 1];

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()
plot(D.t,D.v,'Color','b','LineWidth',1.2)

text(B.t(1)-(B.t(2)-B.t(1))*0.25,B.V(2),'(A)','interpreter','latex')

xlabel('$t$ [ms]','interpreter','latex'), xlim(B.t)
ylabel('$V$ [mV]','interpreter','latex'), ylim(B.V)

xticks([0 25 50 75 100])
xticklabels({'0','25','50','75','100'})

% (B)
nexttile()
Func_VisualizeNullclines(NC)

hold on
plot(D.h,D.v,'Color','b','LineWidth',1.2)
hold off

text(B.h(1)-(B.h(2)-B.h(1))*0.15,B.V(2),'(B)','interpreter','latex')

xline(0,'LineWidth',0.8,'LineStyle',':')

set(gca,'YAxisLocation','right')

xlabel('$h$ [\ ]','interpreter','latex'), xlim(B.h)
ylabel('$V$ [mV]','interpreter','latex'), ylim(B.V)

xticks([0 0.25 0.50 0.75 1])
xticklabels({'0','0.25','0.50','0.75','1'})

Func_FigStyle(fig,'OPTIONs',opts)
%Func_FigExport(fig,'demo1_DSWEB_hh')
