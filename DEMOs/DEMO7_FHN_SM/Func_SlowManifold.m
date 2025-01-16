function S = Func_SlowManifold(TRJ,VAR)

    nS   = TRJ.nTRJ;
    nVAR = length(VAR);
    for iVAR = 1:1:nVAR
       S.(VAR{iVAR}) = zeros(length(TRJ.TRJ1.PO.t),nS);
    end

    for iT = 1:1:nS
        TR = sprintf('TRJ%i',iT); 
        PO = TRJ.(TR).PO; 
        for iVAR = 1:1:nVAR
            S.(VAR{iVAR})(:,iT) = PO.(VAR{iVAR});
        end
    end

end