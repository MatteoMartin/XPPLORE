function Func_WritePoints(M,BD,fWP,varargin)
%
%   Func_WritePoints(M,BD,fWP,varargin)
%
%   Function to produce the same output of the WritePts function of XPPAUT.
%   This creates a .dat file with a BD that can be imported in XPPAUT.
%
%   @param  M   :   Model structure   
%   @param  BD  :   Bifurcation diagram structure
%   @param  fWP :   File where to store the write points output
%
%   @optional VAR : Variable
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/08/2024


% DEFAULT INPUTs

defaultVAR = fieldnames(M.V);

% PARSING INPUT

parser = inputParser;
addRequired(parser ,'M'  ,@isstruct)
addRequired(parser ,'BD' ,@isstruct)
addRequired(parser ,'fWP',@ischar  )
addParameter(parser,'VAR',defaultVAR{2},@iscell)
parse(parser,M,BD,fWP,varargin{:});

% UNPACKING INPUT

VAR = parser.Results.VAR;


% INITIALIZATIONs

if length(BD.P) == 1
    PAR  = BD.P{1};
    VARU = sprintf('%sU',VAR);
    VARL = sprintf('%sL',VAR);
elseif length(BD.P) == 2
    PAR  = BD.P{1};
    VARU = BD.P{2};
    VARL = BD.P{2};
end


% WRITING FILE

f = fopen(fWP,'w');

F = fieldnames(BD.BR);
for iBR = 1:1:BD.BR.nBR
    P  = BD.BR.(F{iBR}).(PAR)  ;
    VU = BD.BR.(F{iBR}).(VARU) ;
    VL = BD.BR.(F{iBR}).(VARL) ;
    T  = BD.BR.(F{iBR}).TYP    ;
    B  = abs(BD.BR.(F{iBR}).BR);
    TP = BD.BR.(F{iBR}).TPar   ;

    for iP = 1:1:length(VU)
        fprintf(f,'%f %f %f %i %i %i\n',P(iP),VU(iP),VL(iP),T,B,TP);
    end
end

fclose(f);

end