function isP = Func_IsParsableF8(H,V)
%
%   isP = Func_IsParsableF8(H,V)
%
%   This function process the header of fort.8-style file and it returns:
%       true  -> If H is a header readable of a special solution.
%       false -> If H is not an header or if H is an header
%                of a non-readable special solution.
%
%   @param H    :   Tentative header
%   @param V    :   Variables
%
%   @output isP :   Boolean representing the parsability of the dataset.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

nRP  = 6;
nV   = length(V);
pITP = [4,5,6,7,8,9,59,69,79,89];

isP = false;
if isstruct(H) && any(pITP == abs(H.ITP))

    if H.NROW == (ceil((nV+1)/7) + nRP)
        isP = false;
        return
    end

    if H.ITP == -4 && H.NTPL == 1
        isP = false;
        return
    end
    
    if H.ITP == 9 && H.NTST == 0 && H.NCOL == 0
        isP = false;
        return
    end

    isP = true;
end

end

