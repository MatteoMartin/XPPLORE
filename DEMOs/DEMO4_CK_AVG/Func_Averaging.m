function [c,J,BZ] = Func_Averaging(M,TRJ,kpmca)

% FUNCTIONs
mI   = @(V)       0.5*(1+tanh((V-M.P.vm)/M.P.sm));
ICa  = @(V)       M.P.gca*mI(V).*(V-M.P.vca);
Jmem = @(c,V,K) -(M.P.alpha*ICa(V) + K*c);

% INITIALIZATION
J = zeros(TRJ.nTRJ,1);
c = zeros(TRJ.nTRJ,1);
F = fieldnames(TRJ);

% AVERAGING
for iTRJ = 1:1:TRJ.nTRJ
    t = TRJ.(F{iTRJ}).PO.t;
    V = TRJ.(F{iTRJ}).PO.v;

    T       = TRJ.(F{iTRJ}).P.T;
    c(iTRJ) = TRJ.(F{iTRJ}).P.c;
    J(iTRJ) = (1/T)*trapz(t*T,Jmem(c(iTRJ),V,kpmca));
end

% EXTRACTION
[~,IZ] = min(abs(J));
BZ = TRJ.(F{IZ}).PTi;

end