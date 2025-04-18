% 
% Chapter 4.5 Reconstructing Manifolds
%         - 4.5.2 Slow Manifolds
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
M_Sr = Func_ReadModel('FHN_Sr.ode');
M_Sa = Func_ReadModel('FHN_Sa.ode');

%% from SECTION 4.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR_Sr = Func_ReadAutoRepo(M_Sr,'FHN_Sr.auto');
AR_Sa = Func_ReadAutoRepo(M_Sa,'FHN_Sa.auto');

%% from SECTION 4.4 - AVERAGING

% TRAJECTORIEs - Extract the periodic orbits.
TRJ_Sr = Func_GetTRJ(M_Sr,AR_Sr.BD1_sI);
TRJ_Sa = Func_GetTRJ(M_Sa,AR_Sa.BD1_sI);

%% SECTION 4.5 - SLOW MANIFOLD

% SLOW MANIFOLD - Reconstruct the slow manifold.
Sr  = Func_Manifold(TRJ_Sr,{'v','h','s'});
Sa  = Func_Manifold(TRJ_Sa,{'v','h','s'});
SrP = Func_SlowManifoldProjection(TRJ_Sr,{'v','h','s'});
SaP = Func_SlowManifoldProjection(TRJ_Sa,{'v','h','s'});

%%

% VISUALIZATION - (hI-lo)
fig = figure();
Func_VisualizeDiagram(M_Sr,AR_Sr.BD1_sI,'VAR',{'sI','v'});

xlabel('$s(0)$ [\ ]','interpreter','latex')
ylabel('$v$ [\ ]','interpreter','latex')

Func_FigStyle(fig)

%%

% OPTIONs
opts = Func_DOF('ClippingStyle','3dbox');

% VISUALIZATION - (3D Surface) Visualize the slow manifold.
fig = figure();

hold on
surface(Sr.h,Sr.v,Sr.s,'FaceColor','b','EdgeColor','none','FaceAlpha',0.2)
surface(Sa.h,Sa.v,Sa.s,'FaceColor','r','EdgeColor','none','FaceAlpha',0.2)
hold off

xlim([0.45   0.72]); xlabel('$h$ [\ ]','interpreter','latex')
ylim([-0.7  -0.20]); ylabel('$v$ [\ ]','interpreter','latex')
zlim([0.01   0.50]); zlabel('$s$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION - (Projection) Visualize the slow manifold.
fig = figure();

hold on
plot(SrP.h,SrP.v,'Color','b','LineWidth',1.2)
plot(SaP.h,SaP.v,'Color','r','LineWidth',1.2)
hold off

xlim([0.4 0.65]), xlabel('$h$ [\ ]','interpreter','latex') 
                  xticks([0.4 0.45 0.5 0.55 0.6 0.65])
                  xticklabels({'0.4','0.45','0.5','0.55','0.6','0.65'})
ylim([-1.2 -0.2]), ylabel('$v$ [\ ]','interpreter','latex')
                   yticks([-1.2 -1.0 -0.8 -0.6 -0.4 -0.2])
                   yticklabels({'-1.2','-1.0','-0.8','-0.6','-0.4','-0.2'})

Func_FigStyle(fig)

%% FIGURE 14

% OPTIONs
opts = Func_DOF('ClippingStyle','3dbox','width',12,'height',6);

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','compact','Padding','compact')

% (A)
nexttile()
hold on
surface(Sr.h,Sr.v,Sr.s,'FaceColor','b','EdgeColor','none','FaceAlpha',0.2)
plot3(SrP.h,SrP.v,SrP.s,'Color','b','LineWidth',1.2)
surface(Sa.h,Sa.v,Sa.s,'FaceColor','r','EdgeColor','none','FaceAlpha',0.2)
plot3(SaP.h,SaP.v,SaP.s,'Color','r','LineWidth',1.2)
hold off

xlim([0.55   0.72]); xlabel('$h$ [\ ]','interpreter','latex')
ylim([-0.7  -0.20]); ylabel('$v$ [\ ]','interpreter','latex')
zlim([0.01   0.50]); zlabel('$s$ [\ ]','interpreter','latex')

view(50,15)

% (B)
nexttile()
hold on
plot(SrP.h,SrP.v,'Color','b','LineWidth',1.2)
plot(SaP.h,SaP.v,'Color','r','LineWidth',1.2)
hold off

text(0.38,-0.2,'(A)','Interpreter','Latex')
text(0.52,-0.2,'(B)','Interpreter','Latex')

xlim([0.55 0.65]), xlabel('$h$ [\ ]','interpreter','latex') 
                  xticks([0.55 0.60 0.65])
                  xticklabels({'0.55','0.60','0.65'})
ylim([-0.8 -0.2]), ylabel('$v$ [\ ]','interpreter','latex')
                   yticks([-0.8 -0.6 -0.4 -0.2])
                   yticklabels({'-0.8','-0.6','-0.4','-0.2'})

Func_FigStyle(fig,'OPTIONs',opts)
%Func_FigExport(fig,'demo7_IJBC_SM')
