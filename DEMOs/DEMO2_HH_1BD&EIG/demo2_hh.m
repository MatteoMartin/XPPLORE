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

Func_VisualizeEig(M,AR.BD1_i0,'VAR',{'i0','EigR','v'})

xlim([0 200]),    xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylim([-1.5 1.5]), ylabel('$\Re(\lambda)$','interpreter','latex')
zlim([-90 30]),   zlabel('$V$ [mV]','interpreter','latex')

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

Func_VisualizeEig(M,AR.BD1_i0,'VAR',{'i0','EigR','v'},'BRIND',{1,2,3,4})

xlim([0 200]),    xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylim([-1.5 1.5]), ylabel('$\Re(\lambda)$','interpreter','latex')
zlim([-90 30]),   zlabel('$V$ [mV]','interpreter','latex')

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD (Cylinder - Branch subset)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig2(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 201])
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5])
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5])

view(110,15)

% Optional: Apply figure style with options specified above
Func_FigStyle(fig,'OPTIONs',opts)

%%

% EIGENVALUEs - Visualize eigenvalues with 1P-BD. (Imaginary)

opts = Func_DOF('ClippingStyle','3dbox');

fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'VAR',{'i0','EigI','v'})

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

%% FIGURE 8 (NOT IN THE PAPER)

% OPTIONs
opts = Func_DOF('width',12,'ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r600');

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()

Func_VisualizeDiagram(M,AR.BD1_i0,'VAR',{'i0','T'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','T'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$T$ [ms]','interpreter','latex')

xticks([0 50 100 150 200])
xticklabels({'0','50','100','150','200'})

%yticks([0 10 20 30])
%yticklabels({'0','10','20','30'})

xlim([0 200])
ylim([0 30])

% (B)
nexttile()

Func_VisualizeDiagram(M,AR.BD1_i0,'VAR',{'i0','L2'})
Func_VisualizeLabPoints(M,AR.BD1_i0,'VAR',{'i0','L2'})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylabel('$L_2$ [\ ]','interpreter','latex')

xticks([0 50 100 150 200])
xticklabels({'0','50','100','150','200'})

%yticks([40 50 60 70])
%yticklabels({'40','50','60','70'})

xlim([0 200])
ylim([40 70])

Func_FigStyle(fig,'OPTIONs',opts)

%% FIGURE 9 - (NEW)

% BOUNDARIEs
B.I  = [0    200];
B.Re = [-1.5 1.5];
B.Im = [-1.5 1.5];

% OPTIONs
opts = Func_DOF('width',12,'ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r600');

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

% (A)
nexttile()

text(B.I(1)-(B.I(2)-B.I(1))*0.25,B.Re(1)-(B.Re(2)-B.Re(1))*0.77,B.Im(2)-(B.Im(2) - B.Im(1))*0.2,'(A)','interpreter','latex')

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,3,4})

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 201])   , xticks([0 100 200]), xticklabels({'0','100','200'})
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5]), yticks([-1 0 1]), yticklabels({'-1','0','1'})
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5]), zticks([-1 0 1]), zticklabels({'-1','0','1'})

view(110,15)

% (B)
nexttile()

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,3,4})

text(B.I(1)-(B.I(2)-B.I(1))*0.15,B.Re(2)+(B.Re(2)-B.Re(1))*0.35,B.Im(2)+(B.Im(2) - B.Im(1))*0.07,'(B)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 201])   , xticks([0 100 200]), xticklabels({'0','100','200'})
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5]), yticks([-1 0 1]), yticklabels({'-1','0','1'})
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5]), zticks([-1 0 1]), zticklabels({'-1','0','1'})

view(-45,15)

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_EIG3D','OPTIONs',opts)

%%

% BOUNDARIEs
B.I  = [0    200];
B.Re = [-1.5 1.5];
B.Im = [-1.5 1.5];

% OPTIONs
opts = Func_DOF('width',12,'ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r400');

% VISUALIZATION
fig = figure();

% (B)
nexttile()

Func_VisualizeEig(M,AR.BD1_i0,'BRIND',{1,2,3,4})

text(B.I(1)-(B.I(2)-B.I(1))*0.15,B.Re(2)+(B.Re(2)-B.Re(1))*0.45,B.Im(2)+(B.Im(2) - B.Im(1))*0.07,'(B)','interpreter','latex')

xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex'), xlim([0 201])   , xticks([0 50 100 150 200]), xticklabels({'0','50','100','150','200'})
ylabel('$\Re(\lambda)$','interpreter','latex')       , ylim([-1.5 1.5]), yticks([-1 0 1])          , yticklabels({'-1','0','1'})
zlabel('$\Im(\lambda)$','interpreter','latex')       , zlim([-1.5 1.5]), zticks([-1 0 1])          , zticklabels({'-1','0','1'})

view(10,25)

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_EIG3D')

%% FIGURE 9 - (OLD)

% OPTIONs
opts = Func_DOF('ClippingStyle','3dbox','format','-dpdf','extension','.pdf','resolution','-r400');

% VISUALIZATION
fig = figure();

Func_VisualizeEig(M,AR.BD1_i0,'VAR',{'i0','EigR','v'})

xlim([0 200]),    xlabel('$I_0$ [$\mu$A/cm$^2$]','interpreter','latex')
ylim([-1.5 1.5]), ylabel('$\Re(\lambda)$','interpreter','latex')
zlim([-90 30]),   zlabel('$V$ [mV]','interpreter','latex')

view([30,30])

Func_FigStyle(fig,'OPTIONs',opts)
% Func_FigExport(fig,'demo2_IJBC_EIG3D')