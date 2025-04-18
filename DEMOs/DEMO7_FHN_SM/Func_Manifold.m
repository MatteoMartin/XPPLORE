function S = Func_Manifold(TRJ,VAR,PAR)

    if nargin == 2     , nPAR = 0;
    elseif isempty(PAR), nPAR = 0;
    else               , nPAR = length(PAR);
    end

    nS   = TRJ.nTRJ;
    nTS  = length(TRJ.TRJ1.PO.t);
    nVAR = length(VAR);
    
    for iVAR = 1:1:nVAR, S.(VAR{iVAR}) = zeros(nTS,nS); end
    for iPAR = 1:1:nPAR, S.(PAR{iPAR}) = zeros(nTS,nS); end

    for iT = 1:1:nS
        TR = sprintf('TRJ%i',iT); 
        PO = TRJ.(TR).PO; 
        P  = TRJ.(TR).P;
        for iVAR = 1:1:nVAR, S.(VAR{iVAR})(:,iT) = PO.(VAR{iVAR});            end
        for iPAR = 1:1:nPAR, S.(PAR{iPAR})(:,iT) = ones(nTS,1)*P.(PAR{iPAR}); end
    end

end