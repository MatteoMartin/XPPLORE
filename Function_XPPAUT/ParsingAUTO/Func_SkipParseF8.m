function Func_SkipParseF8(f,H)
%
%   Func_SkipParseF8(f,H)
%
%   This function jumps to the next header in the .auto file. 
%
%   @param f    :   File identifier.
%   @param H    :   Current fort.8-style dataset header.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

for iR = 1:1:H.NROW, fgetl(f); end

end