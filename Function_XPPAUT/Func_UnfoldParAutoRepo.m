function [M,AR] = Func_UnfoldParAutoRepo(M,AR,BD,K,p,np)
%
%   [M,AR] = Func_UnfoldParAutoRepo(M,AR,BD,K,p,np)
%
%   This function helps the user to add new parameters in the bifurcation
%   diagram structure starting from the one used to solve the bifurcation
%   problem.
%
%   @param M    :   Model structure
%   @param AR   :   AutoRepo structure
%   @param BD   :   Name of the BD (list of character)
%   @param K    :   Function handle
%   @param p    :   Parameter in BD used as auxiliary bifurcation parameter
%   @param np   :   Cell array with the names of new parameters
%
%   @output M   :   Updated model structure
%   @output AR  :   Updated AutoRepo structure
%
%   CONSTRAINT: K must be a function handle giving a row vector as output
%   CONSTRAINT: dim(K) = dim(np)
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 06/02/2026

    nNP = length(np);

    % BIFURCATION DIAGRAM - Creation of new parameter vector
    fBR = fieldnames(AR.(BD).BR);
    for iBR = 1:1:AR.(BD).BR.nBR
        vNP = K(AR.(BD).BR.(fBR{iBR}).(p));
        for iNP = 1:1:nNP
            if size(vNP,1) ~= 1 || size(vNP,2) ~= 1
                AR.(BD).BR.(fBR{iBR}).(np{iNP}) = vNP(:,iNP);
            end
        end
    end

    % LABEL POINTs - Creation of new parameter vector
    fPT = fieldnames(AR.(BD).LABPTs);
    for iPT = 1:1:AR.(BD).LABPTs.nPT
        vNP = K(AR.(BD).LABPTs.(fPT{iPT}).(p));
        for iNP = 1:1:nNP
            AR.(BD).LABPTs.(fPT{iPT}).(np{iNP}) = vNP(:,iNP);
        end
    end

    % PARAMETERs - New cell array
    fP = fieldnames(M.P);
    for iNP = 1:1:nNP, fP{M.P.nP + iNP} = np{iNP}; end
    fP{length(fP)+1} = 'nP';

    % PARAMETERs - List of values
    nP  = cell(size(fP));
    nfP = length(fP);
    for ifP = 1:1:(nfP-1)
        if ifP < (M.P.nP+1)
            nP{ifP} = M.P.(fP{ifP});
        else
            v = K(M.P.(p));
            nP{ifP} = v(:,ifP-M.P.nP);
        end
    end
    nP{end} = length(nP)-1;
    P = cell2struct(nP,fP);

    % MODEL - Update
    M.P = P;

end