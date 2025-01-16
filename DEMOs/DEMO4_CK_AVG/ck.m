% EXAMPLE - CK - Averaging
% Last update - 01/14/2024

% ENVIRONMENT
clear all; close all; clc;

% XPPLAB
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

% OPTIONs
opts = Func_DOF('width',20);

% MODEL
M = Func_ReadModel('ck.ode');

% AUTORePO
AR = Func_ReadAutoRepo(M,'ck.auto');

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

xlim([-0.5   1]), xlabel('$c$ [\ ]','interpreter','latex')
ylim([-80  -10]), ylabel('$V$ [\ ]','interpreter','latex')

Func_SaveFigure(fig)

%%

% TRAJECTORIEs
TRJ = Func_GetTRJ(M,AR.BD1_c);

% AVERAGING
[c1,J1,BZ1] = Func_Averaging(M,TRJ,0.18);
[c2,J2,BZ2] = Func_Averaging(M,TRJ,0.25);

%%

% VISUALIZATION
fig = figure();

tiledlayout(2,2,'TileSpacing','tight','Padding','compact')

nexttile(1)
Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

xlim([-0.5 1]), xticks([-0.4 0 0.4 0.8]), xticklabels({})
ylim([-80  0]), ylabel('$V$ [\ ]','interpreter','latex')
                yticks([-70 -40 -10]), yticklabels({'-70','-40','-10'})
                title('$k_{PMCA} = 0.18$','interpreter','latex')

nexttile(3)

plot(c1,J1,'Color','b','LineWidth',1.2)
yline(0,'LineStyle',':','Color','k')

xlim([-0.5    1]), xticks([-0.4 0 0.4 0.8]), xticklabels({'-0.4','0','0.4','0.8'})
                   xlabel('$c$ [\ ]','interpreter','latex')
ylim([-0.2  0.2]), ylabel('$\bar{J}$ [\ ]','interpreter','latex')
                   yticks([-0.1 0 0.1]), yticklabels({'-0.1','0','0.1'})

nexttile(2)
Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

xlim([-0.5 1]), xticks([-0.4 0 0.4 0.8]), xticklabels({})
ylim([-80  0]), yticks([-70 -40 -10]), yticklabels({})
                title('$k_{PMCA} = 0.25$','interpreter','latex')

nexttile(4)

plot(c2,J2,'Color','b','LineWidth',1.2)
yline(0,'LineStyle',':','Color','k')

xlim([-0.5    1]), xticks([-0.4 0 0.4 0.8]), xticklabels({'-0.4','0','0.4','0.8'})
                   xlabel('$c$ [\ ]','interpreter','latex')
ylim([-0.2  0.2]), yticks([-0.1 0 0.1]), yticklabels({})

Func_FigStyle(fig)

%%

% VISUALIZATION
fig = figure();

tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact')

nexttile()
Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

hold on
plot(AR.BD1_c.LABPTs.(BZ1).c,AR.BD1_c.LABPTs.(BZ1).vU,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',5)
plot(AR.BD1_c.LABPTs.(BZ1).c,AR.BD1_c.LABPTs.(BZ1).vL,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',5)
hold off

xline(AR.BD1_c.LABPTs.(BZ1).c,'LineStyle',':','Color','k','LineWidth',0.8)

xlim([-0.5   1]), xlabel('$c$ [\ ]','interpreter','latex')
ylim([-80  -10]), ylabel('$V$ [\ ]','interpreter','latex')
                  title('$k_{PMCA} = 0.18$','interpreter','latex')

nexttile()
Func_VisualizeDiagram(M,AR.BD1_c)
Func_VisualizeLabPoints(M,AR.BD1_c)

hold on
plot(AR.BD1_c.LABPTs.(BZ2).c,AR.BD1_c.LABPTs.(BZ2).vU,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',5)
plot(AR.BD1_c.LABPTs.(BZ2).c,AR.BD1_c.LABPTs.(BZ2).vL,'Color','m','Marker','o','MarkerFaceColor','m','MarkerSize',5)
hold off

xline(AR.BD1_c.LABPTs.(BZ2).c,'LineStyle',':','Color','k','LineWidth',0.8)

xlim([-0.5   1]), xlabel('$c$ [\ ]','interpreter','latex')
ylim([-80  -10]), ylabel('$V$ [\ ]','interpreter','latex')
                  title('$k_{PMCA} = 0.25$','interpreter','latex')

Func_FigStyle(fig,'OPTIONs',opts)