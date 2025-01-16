function S = Func_ReadData(M,f)
% 
%   S = Func_ReadData(M,f)
%
%   Function to read the data in f.
%
%   @param  M :   Model structure.
%   @param  f :   File path.
%
%   @output S :   Simulation structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 11/22/2024

F  = fieldnames(M.V);
nF = length(F);
X  = load(f);

for iF = 1:1:nF, S.(F{iF}) = X(:,iF); end

end