% 
% Chapter 4.3 Bifurcation Diagrams
%         - 4.3.1 1-Parameter BD & Eigenvalues
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

%% SECTION 4.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M = Func_ReadModel('hh.ode');

%% SECTION 4.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR = Func_ReadAutoRepo(M,'hh.auto');
AR % Display content

%%

% BD & LABPTs - Visualization
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_i0)
Func_VisualizeLabPoints(M,AR.BD1_i0)

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0  200])
ylabel('$V$ [mV]','interpreter','latex')             , ylim([-80 40])

Func_FigStyle(fig)

%%

% BD & LABPTs - Visualize 1P-BD with changed axes
fig = figure();
Func_VisualizeDiagram(M,AR.BD1_i0,'VAR',{'i0','m'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','m'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0  200])
ylabel('$m$ [\ ]','interpreter','latex')             , ylim([0 1])

Func_FigStyle(fig)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD (Real)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig(M,AR.BD1_i0)

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [mV]','interpreter','latex')

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD (Cylinder)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig2(M,AR.BD1_i0)

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 200])
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5])
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5])

view(110,15)

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD. (Branch subset)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [mV]','interpreter','latex')

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD (Cylinder - Branch subset)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig2(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 200])
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5])
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5])

view(110,15)

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD. (Imaginary)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'TYPE','Im')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$\Im(\lambda)$','interpreter','latex')
zlabel('$V$ [mV]','interpreter','latex')

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% GET EIGENVALUEs - Retrieving eigenvalues for further use.

[EIGBR, EIGLAB] = Func_GetEig(AR.BD1_i0);

EIGBR{2}(5,:,1) % Display eigenvals. of points along bif. branch
EIGLAB(3,:,2)   % Display eigenvals. of labeled points

%% FIGURE 8

% BOUNDARIEs
B.I = [0  200];
B.V = [-80 40];
B.h = [0    1];

% OPTIONs
opts = Func_DOF('width',12);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()

Func_VisualizeDiagram(M,AR.BD1_i0);
Func_VisualizeLabPoints(M,AR.BD1_i0);

text(B.I(1)-(B.I(2)-B.I(1))*0.25,B.V(2),'(A)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'),
ylabel('$V$ [mV]','interpreter','latex')  , 

xticks([0 50 100 150 200])
xticklabels({'0','50','100','150','200'})

xlim([0  200])
ylim([-80 40])

% (B)
nexttile()

Func_VisualizeDiagram(M,AR.BD1_i0,'VAR',{'i0','m'});
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','m'});

text(B.I(1)-(B.I(2)-B.I(1))*0.15,B.h(2),'(B)','interpreter','latex')

set(gca,'YAxisLocation','right')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex') 
ylabel('$m$ [\ ]','interpreter','latex')

xticks([0 50 100 150 200])
xticklabels({'0','50','100','150','200'})

xlim([0 200])
ylim([0   1])

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_1PBD')

%% Figure 9 - (NEW)

% BOUNDARIEs
B.I  = [0    200];
B.Re = [-1.5 1.5];
B.Im = [-1.5 1.5];

% OPTIONs
opts = Func_DOF('width',12,'ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r400');

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()

text(B.I(1)-(B.I(2)-B.I(1))*0.25,B.Re(1)-(B.Re(2)-B.Re(1))*0.87,B.Im(2)-(B.Im(2) - B.Im(1))*0.2,'(A)','interpreter','latex')

Func_VisualizeEig2(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 200])
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5])
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5])

view(110,15)

% (B)
nexttile()

Func_VisualizeEig2(M,AR.BD1_i0,'BRIND',{1,2,3,4})

text(B.I(1)-(B.I(2)-B.I(1))*0.15,B.Re(2)+(B.Re(2)-B.Re(1))*0.45,B.Im(2)+(B.Im(2) - B.Im(1))*0.07,'(B)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 200])
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5])
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5])

view(-45,15)

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_EIG3D')

%% Figure 9 - (OLD)

% OPTIONs
opts = Func_DOF('ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r400');

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0)

xlabel('$i_0$ [\ ]','interpreter','latex')
ylabel('$\Re(\lambda)$','interpreter','latex')
zlabel('$V$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_EIG3D')