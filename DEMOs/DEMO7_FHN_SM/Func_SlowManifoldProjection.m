function S = Func_SlowManifoldProjection(TRJ,VAR)

    nS   = TRJ.nTRJ;
    nVAR = length(VAR);
    for iVAR = 1:1:nVAR, S.(VAR{iVAR}) = zeros(nS,1); end

    for iS = 1:1:nS
        Si = sprintf('TRJ%i',iS);
        for iVAR = 1:1:nVAR
            S.(VAR{iVAR})(iS) = TRJ.(Si).PO.(VAR{iVAR})(end); 
        end
    end

end