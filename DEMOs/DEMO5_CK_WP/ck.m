% EXAMPLE - CK - Write Points
% Last update - 01/14/2024

% ENVIRONMENT
clear all; close all; clc;

% XPPLAB
addpath(genpath('../../Function_Visualization'))
addpath(genpath('../../Function_XPPAUT'))

%%

% MODEL
M = Func_ReadModel('hh.ode');

%%

% AUTORePO
AR = Func_ReadAutoRepo(M,'hh.auto');

%%

% WRITE POINTs
Func_WritePoints(M,AR.BD1_i0,'BD.dat')