function H = Func_ParseF8Header(f)
%
%   F8 = Func_ParseF8(f)
%
%   This function parses the fort.8-style header in the .auto file.
%   It returns an integer if the EOF is reached.
%   The structure of the header is the following:
%
%       IBR   :  Index of the branch
%       NTOT  :  Index of the point
%       ITP   :  Type of the point
%       LAB   :  Label of the point
%       NFPR  :  Number of free parameters used in the computation
%       ISW   :  ISW in the computation
%       NTPL  :  Number of points for the solution in the interval [0,1]
%       NAR   :  Number of values written per point
%       NROW  :  Number of lines printed before the next dataset
%       NTST  :  Number of time intervals used in the discretization
%       NCOL  :  Number of collocation point used
%       NPARX :  Dimension of the array par
%
%   @param f    :   File identifier.
%
%   @output H   :   fort.8-style header.
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

H.IBR   = 0;    % Index of the branch
H.NTOT  = 0;    % Index of the point
H.ITP   = 0;    % Type of the point
H.LAB   = 0;    % Label of the point
H.NFPR  = 0;    % Number of free parameters used in the computation
H.ISW   = 0;    % ISW in the computation
H.NTPL  = 0;    % Number of points for the solution in the interval [0,1]
H.NAR   = 0;    % Number of values written per point
H.NROW  = 0;    % Number of lines printed before the next dataset
H.NTST  = 0;    % Number of time intervals used in the discretization
H.NCOL  = 0;    % Number of collocation point used
H.NPARX = 0;    % Dimension of the array par

F      = fieldnames(H);
[l,nl] = Func_ReadLine(f);

if  l  == 0    , H = -1;    return; end     % End of File
for il = 1:1:nl, H.(F{il}) = l(il); end     % Header

% FUNCTIONs

    function [l,nl] = Func_ReadLine(f)
        l  = fgetl(f);
        l  = split(l,' ');
        l  = l(~cellfun('isempty',l));
        l  = cellfun(@str2double,l);
        nl = length(l);
    end

end