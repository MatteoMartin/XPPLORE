function SET = Func_ParseSettings(f,P)
%
%   SET = Func_ParseSettings(f,P)
%
%   This function parses the settings/header of the .auto file. 
%
%       NPTS    :   Number of points
%       NUM     :   Numerics
%       UZ      :   User-defined points
%       IP      :   Index of the hot/free parameters
%
%   @param f    :   File identifier.
%
%   @output SET :   .auto settings structure.    
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

% PARAMETERs

[l,nl] = Func_ReadLine(f);

nP = l(1);
IP = zeros(nP,1);
for il = 2:1:nl-1, IP(il-1) = l(il)+1; end


% USER-DEFINED
nUZ = l(end);
F   = fieldnames(P);
UZ  = {};
for iUZ = 1:1:9
    l = Func_ReadLine(f);
    if iUZ <= nUZ
        if l(2) == 10, UZ.(['UZ',num2str(iUZ)]).T = l(1)          ;
        else,          UZ.(['UZ',num2str(iUZ)]).(F{l(2)+1}) = l(1);
        end
    end
end


% NUMERICs

l = Func_ReadLine(f);
NUM.NTST = l(1);
NUM.NMAX = l(2);
NUM.NPR  = l(3);

l = Func_ReadLine(f);
NUM.DS    = l(1);
NUM.DSMIN = l(2);
NUM.DSMAX = l(3);

l = Func_ReadLine(f);
NUM.ParMAX  = l(1);
NUM.ParMIN  = l(2);
NUM.NormMAX = l(3);
NUM.NormMIN = l(4);

l = Func_ReadLine(f);
NUM.IAD  = l(1);
NUM.MXBF = l(2);
NUM.IID  = l(3);
NUM.ITMX = l(4);
NUM.ITNW = l(5);
NUM.NWTN = l(6);
NUM.IADS = l(7);

% VISUALIZATION SETTINGs
l = Func_ReadLine(f);
NUM.xmin = l(1);
NUM.ymin = l(2);
NUM.xmax = l(3);
NUM.ymax = l(4);


% NUMBER OF POINTs
l = Func_ReadLine(f);
NPTS = l;

% OUTPUT
SET.NPTS = NPTS;
SET.NUM  = NUM;
SET.UZ   = UZ;
SET.IP   = IP;

% FUNCTIONs

    function [l,nl] = Func_ReadLine(f)
        l  = fgetl(f);
        l  = split(l,' ');
        l  = l(~cellfun('isempty',l));
        l  = cellfun(@str2double,l);
        nl = length(l);
    end


end