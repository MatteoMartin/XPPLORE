function [EIG, EIGLAB] = Func_GetEig(BD,varargin)
%
%   Func_GetEig(BD,[SORTED])
%
%   Function to retrieve all eigenvalues of a specified BD.
% 
%
%   @param BD   :   Bifurcation Diagram structure
% 
%   @optional SORTED :   Sort Eigenvalues (Re,Im indep.) at each BD point
%
%   @output EIG :   EIG: MATRIX of Eigenvalues of branch points
%                    EIG{branch}(pt_num, i, 1(Re) or 2(Im))
%                    pt_num: in 1...num. points in branch
%                    i: in 1...dim. model
%                   EIGLAB: Matrix of Eigenvalues for labeled points
%                    EIGLAB(point_index, i) where i in 1...dim. model
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/15/2025

defaultSORTED = false;

parser = inputParser;
addRequired(parser ,'BD'        ,@isstruct)
addParameter(parser, 'SORTED', defaultSORTED, @islogical);
parse(parser,BD,varargin{:});

srt = parser.Results.SORTED;

% Extract Eigenvalues of points on each branch
if isfield(BD, 'BR')
    FBR = fieldnames(BD.BR);
    EIG = {};

    for iBR = 1:BD.BR.nBR
        BR_name = FBR{iBR};
        B = BD.BR.(BR_name);

        if srt
            EIG{iBR} = cat(3, sort(B.EigR,2), sort(B.EigI,2));
        else
            EIG{iBR} = cat(3, B.EigR, B.EigI);
        end
    end
end

% Extract Eigenvalues of labeled points
if isfield(BD, 'LABPTs')
    PTs = BD.LABPTs;
    FPT = fieldnames(PTs);
    first = PTs.(FPT{1});
    sz = size(first.EigR,2);
    EIGLAB = zeros(PTs.nPT-1,sz+1,2);

    for iPT = 1:BD.LABPTs.nPT
        PT = PTs.(FPT{iPT});
        if srt
            [srtR,inds] = sort(PT.EigR,2);
            EIGLAB(iPT,:,1) = [PT.BR, srtR];
            EIGLAB(iPT,:,2) = [PT.BR, PT.EigI(inds)];
        else
            EIGLAB(iPT,:,1) = [PT.BR, PT.EigR];
            EIGLAB(iPT,:,2) = [PT.BR, PT.EigI];
        end
    end
end
