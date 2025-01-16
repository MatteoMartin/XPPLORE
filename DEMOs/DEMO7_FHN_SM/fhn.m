% EXAMPLE - FHN - Repelling Slow Manifold
% Last update - 01/14/2024


% ENVIRONMENT
clear all; close all; clc;

% XPPLORE
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%%

% OPTIONs
opts = Func_DOF(); opts.ClippingStyle = '3dbox';

%%

% MODEL
M1 = Func_ReadModel('FHN_Sr.ode');

% AUTORePO
AR_Sr = Func_ReadAutoRepo(M1,'FHN_Sr.auto');

%%

% TRAJECTORIEs - Extraction
TRJ = Func_GetTRJ(M1,AR_Sr.BD1_sI);

% SLOW MANIFOLD - Surface
Sr  = Func_SlowManifold(TRJ,{'v','h','s'});

% SLOW MANIFOLD - Projection
SrP = Func_SlowManifoldProjection(TRJ,{'v','h','s'});

%%

% VISUALIZATION - (hI-lo)
fig = figure();
Func_VisualizeDiagram(M1,AR_Sr.BD1_sI,'VAR',{'sI','v'});

xlabel('$s(0)$ [\ ]','interpreter','latex')
ylabel('$v$ [\ ]','interpreter','latex')

Func_FigStyle(fig)

%% 

% VISUALIZATION - (L2)
fig = figure();
Func_VisualizeDiagram(M1,AR_Sr.BD1_sI,'VAR',{'sI','L2'});

xlabel('$s(0)$ [\ ]','interpreter','latex')
ylabel('$\mathcal{L}_2$ [\ ]','interpreter','latex')

Func_FigStyle(fig)

%%

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