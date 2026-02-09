% 
% Extra 1: Bifurcation problems with auxiliary parameters
% 
% Note: This demo illustrates the function Func_UnfoldParAutoRepo().
%       The aim of this function is to unfold bifurcation problem which are
%       solved for auxiliary parameters. Let assume to consider,
%
%                       x' = f(x|P)         (1)
%
%       with x in R^n and P, the parameter vector, in R^m. We denote each 
%       component of P with pi. Let assume that we want to investigate 
%       the bifurcation structure of (1) by varying p1,...,pk contemporary,
%       with k <= m. In XPPAUT, we can parametrize each pi, with i in
%       {1,...,k}, according with an auxiliary bifurcation parameter (pa).
%       Then, each parameter pi is related with pa through the function Ki,
%
%                   pi = Ki(pa)
%
%       When the bifurcation problem is solved, the .auto file contains
%       information only on pa and not on the values of the parametrized
%       parameters p1,...,pk. For this reason, we developed the function
%       Func_UnfoldParAutoRepo(), which adjust the AutoRepo, and
%       the model structure, to allow the user to keep using the
%       function of XPPLORE to visualize the results of the bifurcation 
%       analyses over axes presenting the unfolded parameters, p1,...,pk.
%       
%
% Case study: To showcase the capability of this function, we consider the
%             three-dimensional model of cortical neuron presented in 
%             Martin & Pedersen [1]. The aim is to compute the bifurcation
%             diagram along the straight line 
%
%                   r = m*w + q.
%
%             We will use the function Func_UnfoldParAutoRepo() to create a
%             new field in all the branches and labelled points of the
%             computed 1P-BD containing the values of r.
% 
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 02/09/2026
%
% [1] Martin M & Pedersen MG, "Modelling and analysis of cAMP-induced 
%     mixed-mode oscillations in cortical neurons: Critical roles of HCN 
%     and M-type potassium channels", PLoS Computational Biology, 2024.

% ENVIRONMENT
clear all; close all; clc;

% FUNCTION - Parameter set A in the .ode file
K = @(x) -0.451326*x + 0.088661;

%%

% MODEL
M = Func_ReadModel('mp.ode');

%%

% AUTOREPO - Reading .auto file
AR = Func_ReadAutoRepo(M,'mp.auto');

%%

% OPTIONs
opts = Func_DOBD();

% OPTIONs - Avoid the visualization of BP occuring over branches of LC
opts.Bif.BC.Marker = 'none';

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_w)
Func_VisualizeLabPoints(M,AR.BD1_w,'OPTIONs',opts)

xlabel('$w$ [\ ]','interpreter','latex')
ylabel('$V$ [mV]','Interpreter','latex')

xlim([0 1])
box on

Func_FigStyle(fig)

%%

% AUTOREPO - UPDATE
[M,AR] = Func_UnfoldParAutoRepo(M,AR,'BD1_w',K,'w',{'r'});

%%

% VISUALIZATION
fig = figure();

Func_VisualizeDiagram(M,AR.BD1_w,'VAR',{'w','r'})
Func_VisualizeLabPoints(M,AR.BD1_w,'VAR',{'w','r'},'OPTIONs',opts)

xlim([0 1]), xlabel('$w$ [\ ]','interpreter','latex')
ylim([0 1]), ylabel('$r$ [\ ]','interpreter','latex')

Func_FigStyle(fig)