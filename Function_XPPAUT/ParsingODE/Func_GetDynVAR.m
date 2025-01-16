function DV = Func_GetDynVAR(V,TV)
%
%   [DV,TV] = Func_GetDynVAR(V,TV)
%
%   This function retrieve a cell array with dynamical variables only.
%   
%   @param V    :   Cell array of variables.
%   @param TV   :   Cell array of variables' type.
%
%   @output DV  :   Cell array of dynamical variables.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kshita (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

iDV = 1;
nV  = length(V);

for iV = 1:1:nV
    if strcmp(V{iV},'t') , continue; end
    if strcmp(TV{iV},'C'), DV{iDV} = V{iV}; iDV = iDV + 1; end
end

end