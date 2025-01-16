function F7 = Func_ParseF7(f,V,IP)
%
%   F7 = Func_ParseF7(f,V,IP)
%
%   This function parses the fort.7-style file in the .auto file.
%   The structure of a fort.7-style file is the following:
%
%       PT  : Point information.
%       E   : Eigenvalues of the point.
%       T   : Period of the solution.
%       L2  : L2 norm of the solution.
%       FP  : Free parameters.
%       SET : Settings used by AUTO to compute the current point.
%       
%
%   @param f    :   File identifier.
%   @param V    :   Cell array of dynamical variables.
%   @param IP   :   Index of the hot/free parameter.
%
%   @output F7  :   fort.7-style structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

% HEADER

SET.TYPCAL = 0;     % TYPE OF CALCULATION
SET.BR     = 0;     % BRANCH
SET.PT     = 0;     % INDEX IN THE CURRENT BRANCH (Start from 1)
SET.BIF    = 0;     % TYPE OF BIFURCATION
SET.LAB    = 0;     % LABEL
SET.INDEX  = 0;     % INDEX IN THE WHOLE BIFURCATION DIAGRAM
SET.NFPAR  = 0;     % NUMBER OF FREE PARAMETER FOLLOWED
SET.ICP1   = 0;     % INDEX OF THE FIRST FREE PARAMETER
SET.ICP2   = 0;     % INDEX OF THE SECOND FREE PARAMETER
SET.ICP3   = 0;     % INDEX OF THE THIRD FREE PARAMETER
SET.ICP4   = 0;     % INDEX OF THE FOURTH FREE PARAMETER
SET.FLAG2  = 0;     % FLAG 2

[l,nl] = Func_ReadLine(f);
F      = fieldnames(SET);

for il = 1:1:nl, SET.(F{il}) = l(il); end

% FREE PARAMETERs

l = Func_ReadLine(f);

nPMax = 8;
nP    = length(IP);

for iFP = 1:1:nPMax
    if iFP <= nP
        fFP = sprintf('Par%i',iFP);
        FP.(fFP) = l(iFP);
    end
end

L2 = l(9);
T  = l(10);

% VARIABLEs

nV = length(V);

E.EigR = zeros(nV,1);
E.EigI = zeros(nV,1);

for iV = 1:1:nV
    l = Func_ReadLine(f);
    PT.(sprintf('%si',V{iV})) = l(1);
    PT.(sprintf('%sU',V{iV})) = l(2);
    PT.(sprintf('%sL',V{iV})) = l(3);
    PT.(sprintf('%sA',V{iV})) = l(4);

    E.EigR(iV) = l(5);
    E.EigI(iV) = l(6);
end


% STRUCTURE

F7.PT  = PT;
F7.E   = E;
F7.T   = T;
F7.L2  = L2;
F7.SET = SET;
F7.FP  = FP;


% FUNCTIONs

    function [l,nl] = Func_ReadLine(f)
        l  = fgetl(f);
        l  = split(l,' ');
        l  = l(~cellfun('isempty',l));
        l  = cellfun(@str2double,l);
        nl = length(l);
    end

end