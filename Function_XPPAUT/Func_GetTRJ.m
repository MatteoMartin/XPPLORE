function TRJ = Func_GetTRJ(M,BD)
%
%   TRJ = Func_GetTRJ(M,BD)
%
%   Function to create the trajectories structure from the specified
%   bifurcation diagram BD.
%
%   @param  M   :   Model structure.
%   @param  BD  :   Bifurcation diagram structure.
%
%   @output TRJ :   Trajectory structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/08/2024


iTRJ = 1;
F = fieldnames(BD.LABPTs);
for iPT = 1:1:BD.LABPTs.nPT
    Fi = F{iPT};

    if isfield(BD.LABPTs.(Fi),'PO')
        TRJ.(sprintf('TRJ%i',iTRJ)).PTi = Fi;
        TRJ.(sprintf('TRJ%i',iTRJ)).PO  = BD.LABPTs.(Fi).PO;
        FP = fieldnames(M.P);

        for iP = 1:1:M.P.nP
            if isfield(BD.LABPTs.(Fi),FP{iP}), TRJ.(sprintf('TRJ%i',iTRJ)).P.(FP{iP}) = BD.LABPTs.(Fi).(FP{iP}); end
            TRJ.(sprintf('TRJ%i',iTRJ)).P.T = BD.LABPTs.(Fi).T;
        end
        iTRJ = iTRJ + 1;
    end
end

TRJ.nTRJ = length(fieldnames(TRJ));

end