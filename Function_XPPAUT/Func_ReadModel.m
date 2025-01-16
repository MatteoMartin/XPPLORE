function MDL = Func_ReadModel(f)
%
%   MDL = Func_ReadModel(f)
%
%   Function to extract necessary information from the model.
%
%   @param f    :   .ode file path.
%
%   @output MDL :   Model structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 11/22/2024

    MDL.V = Func_ReadVAR(f);
    MDL.P = Func_ReadPAR(f);
    MDL.S = Func_ReadSettings(f);

end


