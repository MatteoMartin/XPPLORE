% 
% Chapter 3.5 Slow Manifolds
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

% CLEAR ENVIROMENT
clear all; close all; clc;

% IMPORT PACKAGE - Change to YOUR XPPLORE path
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%% SECTION 3.2 - MODEL, SIMULATION & NULLCLINEs

% MODEL - Read the content of an .ode file.
M1 = Func_ReadModel('FHN_Sr.ode');

%% SECTION 3.3 - BIFURCATION DIAGRAM

% AUTORePO - Read the content of an .auto file.
AR_Sr = Func_ReadAutoRepo(M1,'FHN_Sr.auto');

%% SECTION 3.5 - SLOW MANIFOLDs

% TRAJECTORIEs - Extract the periodic orbits.
TRJ = Func_GetTRJ(M1,AR_Sr.BD1_sI);

% SLOW MANIFOLD - Reconstruct the slow manifold
Sr  = Func_SlowManifold(TRJ,{'v','h','s'});

% SLOW MANIFOLD - Reconstruct the slow manifold
SrP = Func_SlowManifoldProjection(TRJ,{'v','h','s'});

%%

% VISUALIZATION - (hI-lo)
fig = figure();
Func_VisualizeDiagram(M1,AR_Sr.BD1_sI,'VAR',{'sI','v'});

xlabel('$s(0)$ [\ ]','interpreter','latex')
ylabel('$v$ [\ ]','interpreter','latex')

Func_FigStyle(fig)

%%

% OPTIONs
opts = Func_DOF('ClippingStyle','3dbox');

% VISUALIZATION - (3D Surface)
fig = figure();

hold on
surface(Sr.h,Sr.v,Sr.s,'FaceColor','b','EdgeColor','none','FaceAlpha',0.2)
hold off

xlim([0.45   0.72]); xlabel('$h$ [\ ]','interpreter','latex')
ylim([-0.7  -0.20]); ylabel('$v$ [\ ]','interpreter','latex')
zlim([0.01   0.50]); zlabel('$s$ [\ ]','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)

%%

% VISUALIZATION - (Projection)
fig = figure();

hold on
plot(SrP.h,SrP.v,'Color','b','LineWidth',1.2)
hold off

xlim([0.4 0.65]), xlabel('$h$ [\ ]','interpreter','latex') 
                  xticks([0.4 0.45 0.5 0.55 0.6 0.65])
                  xticklabels({'0.4','0.45','0.5','0.55','0.6','0.65'})
ylim([-1.2 -0.2]), ylabel('$v$ [\ ]','interpreter','latex')
                   yticks([-1.2 -1.0 -0.8 -0.6 -0.4 -0.2])
                   yticklabels({'-1.2','-1.0','-0.8','-0.6','-0.4','-0.2'})

Func_FigStyle(fig)

%% FIGURE 8

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
hold off

xlim([0.55   0.72]); xlabel('$h$ [\ ]','interpreter','latex')
ylim([-0.7  -0.20]); ylabel('$v$ [\ ]','interpreter','latex')
zlim([0.01   0.50]); zlabel('$s$ [\ ]','interpreter','latex')

view(50,15)

% (B)
nexttile()
hold on
plot(SrP.h,SrP.v,'Color','b','LineWidth',1.2)
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
