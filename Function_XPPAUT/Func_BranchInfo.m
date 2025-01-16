function Func_BranchInfo(BD)
%
%   Func_BranchInfo(BD)
%
%   Function used to visualize the properties of each BD's branch. 
%
%   @parameter BD   :   Bifurcation diagram structure.
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 12/13/2024

BR = BD.BR;
fprintf(' BR  |  TYPE  |  #PT\n')

for iBR = 1:1:BR.nBR
    B  = BR.(sprintf('B%i',iBR));
    nP = length(B.IDX);

    if B.TPar ~= 0 && B.TYP == 1, S = 'SN'  ; end
    if B.TPar ~= 0 && B.TYP == 2, S = 'SNPO'; end
    if B.TPar ~= 0 && B.TYP == 3, S = 'HB'  ; end
    if B.TPar ~= 0 && B.TYP == 4, S = 'TR'  ; end
    if B.TPar ~= 0 && B.TYP == 6, S = 'PD'  ; end

    if B.TPar == 0 && B.TYP == 1, S = 'SFP'; end
    if B.TPar == 0 && B.TYP == 2, S = 'UFP'; end
    if B.TPar == 0 && B.TYP == 3, S = 'SLC'; end
    if B.TPar == 0 && B.TYP == 4, S = 'ULC'; end
    if B.TPar == 0 && B.TYP == 8, S = 'BVP'; end
    
    fprintf('%3i  |  %4s  |  %i\n',iBR,S,nP)
end


end