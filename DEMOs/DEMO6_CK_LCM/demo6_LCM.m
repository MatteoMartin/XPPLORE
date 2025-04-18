% 
% Chapter 4.5 Reconstructing Manifolds
%         - 4.5.1 Surface of limit cycles
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

% MODEL - Read the content of an .ode file. (Fast subsystem)
M = Func_ReadModel('ck.ode');

% MODEL - Read the content of an .ode file. (Full system)
MF = Func_ReadModel('ck_Full.ode');

% SIMULATION - Load
SR = Func_ReadData(MF,'simR.dat');
SL = Func_ReadData(MF,'simL.dat');

%% from SECTION 4.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR = Func_ReadAutoRepo(M,'ck.auto');

%% SECTION 4.5 - LIMIT CYCLE MANIFOLDs

% TRAJECTORIEs - Extract the periodic orbits.
TRJ = Func_GetTRJ(M,AR.BD1_c);

%%

% AVERAGING - Applying averaging.
LC = Func_Manifold(TRJ,{'v','n'},{'c'});

%%

% OPTIONs - Cropping 3DBOX
opts = Func_DOF('ClippingStyle','3dbox');

%%

% VISUALIZATION - Visualization of 1P-BD with averaging results.
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_c,'BRIND',{1,2,3,4,5,6},'VAR',{'c','n','v'})
Func_VisualizeLabPoints(M,AR.BD1_c,'BRIND',{1,2,3,4,5,6},'VAR',{'c','n','v'})

hold on
surf(LC.c,LC.n,LC.v,'FaceColor','g','FaceAlpha',0.3,'EdgeColor','none')
hold off

hold on
plot3(LC.c(:,end),LC.n(:,end),LC.v(:,end),'LineWidth',1.2,'Color','m','LineStyle','-')
hold off

hold on
plot3(SR.c(:,end),SR.n(:,end),SR.v(:,end),'LineWidth',1.2,'Color','b')
hold off

xlim([0.05 0.3]), xlabel('$c$ [mM]','interpreter','latex')
ylim([  0 0.15]), ylabel('$n$ [\ ]','interpreter','latex')
zlim([-80  -10]), zlabel('$V$ [mV]','interpreter','latex')

view(30,10)

Func_FigStyle(fig,'OPTIONs',opts);

%% FIGURE 13

% BOUNDARIEs
B.t = [0     30];
B.V = [-70  -10];
B.c = [0.05 0.3];
B.n = [  0 0.12];

% OPTIONs
opts = Func_DOF('width',12,'ClippingStyle','3dbox');

% VISUALIZATION - Visualization of 1P-BD with averaging results.
fig = figure();

tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

% (A)
nexttile();

Func_VisualizeDiagram(M,AR.BD1_c,'BRIND',{1,2,3,4,5,6},'VAR',{'c','n','v'})
Func_VisualizeLabPoints(M,AR.BD1_c,'BRIND',{1,2,3,4,5,6},'VAR',{'c','n','v'})

hold on
surf(LC.c,LC.n,LC.v,'FaceColor','g','FaceAlpha',0.3,'EdgeColor','none')
hold off

hold on
plot3(LC.c(:,end),LC.n(:,end),LC.v(:,end),'LineWidth',1.2,'Color','m','LineStyle','-')
hold off

hold on
plot3(SR.c,SR.n,SR.v,'LineWidth',1.2,'Color','b')
hold off

text(B.c(1)-(B.c(2)-B.c(1))*0.82,B.n(2)-(B.n(2)-B.n(1))*0.28,B.V(2)*1.2,'(A)','interpreter','latex')

xlim(B.c), xlabel('$c$ [$\mu$M]','interpreter','latex')
ylim(B.n), ylabel('$n$ [\ ]','interpreter','latex')
zlim(B.V), zlabel('$V$ [mV]','interpreter','latex')

view(30,10)

% (B)
nexttile();

hold on
plot(SL.t/1000,SL.v,'LineWidth',1.2,'Color','b')
hold off

text(B.t(1)-(B.t(2)-B.t(1))*0.25,B.V(2),'(B)','interpreter','latex')

xlim(B.t), xlabel('$t$ [s] ','interpreter','latex')
ylim(B.V), ylabel('$V$ [mV]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts);
%Func_FigExport(fig,'demo6_IJCB_LCM');