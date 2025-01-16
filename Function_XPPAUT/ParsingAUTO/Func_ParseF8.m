function F8 = Func_ParseF8(f,SET,V,HP)
%
%   F8 = Func_ParseF8(f,SET,V,HP)
%
%   This function parses the fort.8-style dataset in the .auto file.
%   The parsable solutions are those temporal series associated with 
%   1P bifurcations or 1P used-defined points.
%   The structure of a fort.8-style file is the following:
%
%       TRJ  : Temporal series.
%       FP   : Free Parameters.
%       DFP  : Arclength derivative to compute the solution.
%       DTRJ : Arclength derivative of the trajectory.
%       SET  : Settings used by AUTO to compute the current point.
%
%   @param f    :   File identifier.
%   @param SET  :   Settings retrieved from header of the point.
%   @param V    :   Cell array of variables.
%   @param P    :   Cell array of parameters.
%   @param HP   :   Hot parameters.
%
%   @output F8  :   fort.8-style structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/09/2025


% SOLUTION

nV = length(V);

TRJ.t = zeros(SET.NTPL,1);
for iV = 1:1:nV
    TRJ.(V{iV}) = zeros(SET.NTPL,1); 
end

for iL = 1:1:SET.NTPL
    nl = 0;
    is = 1;
    l  = zeros(SET.NAR,1);
    while nl ~= SET.NAR
        [tl,ntl] = Func_ReadLine(f);
        l(is:is+ntl-1) = tl;
        is  = is + ntl;
        nl  = nl + ntl;
    end

    TRJ.t(iL) = l(1);
    for iV = 1:1:nV
        TRJ.(V{iV})(iL) = l(iV+1); 
    end
end


% FREE PARAMETERs

[l,nl] = Func_ReadLine(f);
l = l + 1;

if length(l) ~= SET.NFPR, exit('ERROR! - Inconsistent number of parameters!'), end

for il = 1:1:nl
    if l(il) ~= 11, DFP.(['D',HP.(sprintf('Par%i',il))]) = 0;
    else,           DFP.DT = 0                              ;
    end
end


% DERIVATIVE PARAMETERs

[l,nl] = Func_ReadLine(f);

F = fieldnames(DFP);
for il = 1:1:nl, DFP.(F{il}) = l(il); end
    

% DERIVATIVE SOLUTIONs

for iV = 1:1:nV
    DTRJ.(V{iV}) = zeros(SET.NTPL,1);
end

for iL = 1:1:SET.NTPL
    nl = 0;
    is = 1;
    l  = zeros(SET.NAR-1,1);
    while nl ~= SET.NAR-1
        [tl,ntl] = Func_ReadLine(f);
        l(is:is+ntl-1) = tl;
        is  = is + ntl;
        nl  = nl + ntl;
    end

    for iV = 1:1:nV
        DTRJ.(V{iV})(iL) = l(iV);
    end
end


% PARAMETER

nl = 0;
is = 1;
l  = zeros(SET.NPARX-1,1);
while nl ~= SET.NPARX
    [tl,ntl] = Func_ReadLine(f);
    l(is:is+ntl-1) = tl;
    is  = is + ntl;
    nl  = nl + ntl;
end

nP = length(fieldnames(HP));
for iP = 1:1:nP, FP.(HP.(sprintf('Par%i',iP))) = l(iP); end
FP.T = l(11);


% STRUCTURE

F8.TRJ  = TRJ;
F8.FP   = FP;
F8.DFP  = DFP;
F8.DTRJ = DTRJ;
F8.SET  = SET;

    % FUNCTIONs
    function [l,nl] = Func_ReadLine(f)
        l  = fgetl(f);
        l  = split(l,' ');
        l  = l(~cellfun('isempty',l));
        l  = cellfun(@str2double,l);
        nl = length(l);
    end



end