function AR = Func_ReadAutoRepo(M,fBD,varargin)
%
%   AR = Func_ReadAutoRepo(M,fAR)
%
%   This function reads the .auto file exported from XPP that contains 1 
%   and 2P-BDs. It returns a structure with the following fields:
%
%       BR     :   Branches of the bifurcation diagrams
%       LABPTs :   Labelled points
%       SET    :   Settings
%       P      :   Bifurcation parameters
%
%   @param M    :   Model.
%   @param fAR  :   File path.
%
%   @optional BIFURCATIONs : Boolean parameter, if false no LABPTs and no TRJ
%   @optional TRAJECTORIEs : Boolean parameter, if false no TRJ
%
%   @output AR  :   AutoRepo structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/07/2025

% DEFAULT VALUEs

defaultLoadBifurcations        = true;
defaultLoadSpecialTrajectories = true;


% PARSING INPUT

parser = inputParser;
addRequired(parser ,'M'  ,@isstruct)
addRequired(parser ,'fBD',@ischar  )
addParameter(parser,'BIFURCATIONs',defaultLoadBifurcations       ,@islogical)
addParameter(parser,'TRAJECTORIEs',defaultLoadSpecialTrajectories,@islogical)
parse(parser,M,fBD,varargin{:});


% UPACKING INPUT

LoadTrajectories = parser.Results.TRAJECTORIEs;
LoadBifurcations = parser.Results.BIFURCATIONs;


% FILE - OPEN

fBD = fopen(fBD);


% UNPACKING - MODEL's STRUCTURE

V = M.V;
P = M.P;


% VISUALIZATION

fprintf('AR:\n')


% PARISING - SETTINGs

fprintf('    Parsing settings ...');
DV     = Func_DynVAR(V);
SET    = Func_ParseSettings(fBD,P);
AR.SET = SET;
AR.SET = rmfield(AR.SET,'IP');
fprintf('completed!\n')


% PARISING - HOT PARAMETERs

fprintf('    Parsing hot parameters ...');
AR.P = Func_ParseParameters(SET,P);
fprintf('completed!\n')

nPR = length(fieldnames(AR.P));
iBR = 0;
nPT = 0;


% PARSING - BRANCHEs & LABELLED POINTs
cBD = 1;
if LoadBifurcations, fprintf('    Parsing branches & labelled points ...');
else,                fprintf('    Parsing branches ...');
end
for iPT = 1:1:SET.NPTS+1
    F7    = Func_ParseF7(fBD,DV,SET.IP);
    TYP   = Func_GetTYP(F7);
    isNBD = false;

    % NEW - 1P BD
    if not(nPT == 1) && F7.SET.FLAG2 == 0 && (F7.SET.LAB == 1 || F7.SET.PT == 1)
        Par1 = AR.P.(sprintf('Par%i',F7.SET.ICP1+1));

        if nPT == 0 || ...
                F7.SET.LAB == 1 || ...
                    Func_IsContinuationFromUZ(F7.SET.PT,F7.SET.LAB,AR.(fBDC).P{1},Par1)
            fBDC = sprintf('BD%i_%s',cBD,Par1);
            AR.(fBDC).P = {Par1};
    
            cBD   = cBD + 1;
            isNBD = true;
            iBR   = 0;
        end
    end

    % NEW - 2P BD
    if not(nPT == 1) && F7.SET.FLAG2 ~= 0 && (AR.(fBDC).BR.(fBR).TPar == 0 || F7.SET.PT == 1)
        if F7.SET.ICP2 > 9, continue; end

        Par1 = AR.P.(sprintf('Par%i',F7.SET.ICP1+1));
        Par2 = AR.P.(sprintf('Par%i',F7.SET.ICP2+1));

        if AR.(fBDC).BR.(fBR).TPar == 0 || ...
            Func_IsContinuationFromUZ(F7.SET.PT,F7.SET.LAB,AR.(fBDC).P{2},Par2) || ...
            Func_IsContinuationFromUZ(F7.SET.PT,F7.SET.LAB,AR.(fBDC).P{1},Par1)
    
            fBDC = sprintf('BD%i_%s_%s',cBD,Par1,Par2);
            AR.(fBDC).P = {Par1,Par2};
    
            cBD   = cBD + 1;
            isNBD = true;
            iBR   = 0;
        end
    end

    % NEW - BRANCH
    if isNBD || iBR == 0                     ...           % NEW DIAGRAM
       || AR.(fBDC).BR.(fBR).BR ~= F7.SET.BR ...           % NEW BRANCH
       || AR.(fBDC).BR.(fBR).TYP ~= TYP      ...           % NEW TYPE
       || abs(F7.SET.PT) < AR.(fBDC).BR.(fBR).IDXBR(end)   % NEW DIAGRAM

        iBR = iBR + 1;
        fBR = Func_NameBR(F7,TYP,iBR);
        isNBR = true;
    else
        isNBR = false;
    end

    % NEW - LABELLED POINT
    isLABPTs = false;
    if LoadBifurcations && F7.SET.BIF ~= 0
        isLABPTs = true;
        fLABPTs  = Func_NameLABPTs(F7);
        AR.(fBDC).LABPTs.(fLABPTs) = Func_NewLABPTs(F7,AR.P,iBR);
    end

    % BRANCH - CONNECTION EVALUATION
    add2 = 0;
    if isNBR
        F7N = F7;
        if not(isNBD) && isNBR
            if LoadBifurcations && Func_AreBranchesConnectable(TYP,pTYP,AR.(fBDC).LABPTs.(fLABPTs).TYP)
                if not(isLABPTs), F7N = pF7; add2 =  1;
                else         , F7N = F7 ; add2 = -1;
                end
            end
        end
    end

    % BRANCH - NEW/APPEND
    if isNBR
        AR.(fBDC).BR.(fBR) = Func_NewBR(F7N,TYP,AR.P); 
        nPT = 1;
    else
        AR.(fBDC).BR.(fBR) = Func_AppendBR(AR.(fBDC).BR.(fBR),F7,AR.P);
        nPT = nPT + 1;
    end

    % BRANCH - CONNECTION RESOLUTION
    if add2 ~= 0
        if add2 ==  1, AR.(fBDC).BR.(fBR)  = Func_AppendBR(AR.(fBDC).BR.(fBR) ,F7,AR.P); end
        if add2 == -1, AR.(fBDC).BR.(pfBR) = Func_AppendBR(AR.(fBDC).BR.(pfBR),F7,AR.P); end
    end

    % STORING - PREVIOUS BRANCH MAIN INFO
    pfBR = fBR;
    pF7  = F7 ;
    pTYP = TYP;
end
fprintf('completed!\n')


% COUNTING - BRANCHEs & LABELLED POINTs

nBD = fieldnames(AR);
for iBD = 1:1:length(nBD)
    if contains(nBD{iBD},'BD')
        if isfield(AR.(nBD{iBD}),'LABPTs')
            AR.(nBD{iBD}).LABPTs.nPT = length(fieldnames(AR.(nBD{iBD}).LABPTs)); 
        end
    end
end
for iBD = 1:1:length(nBD)
    if contains(nBD{iBD},'BD')
        AR.(nBD{iBD}).BR.nBR = length(fieldnames(AR.(nBD{iBD}).BR));
    end
end

% PARSING - SPECIAL SOLUTIONs

if LoadTrajectories && LoadBifurcations
    fprintf('    Parsing Special Solutions...')
    isEOF = false;
    for iBD = length(nBD):-1:1
        nTRJ = 0;
        if contains(nBD{iBD},'BD')
            while not(isEOF) && not(nTRJ == AR.(nBD{iBD}).LABPTs.nPT)
                H = Func_ParseF8Header(fBD);

                if Func_IsParsableF8(H,DV)
                    F8 = Func_ParseF8(fBD,H,DV,AR.P);
            
                    if Func_IsStorableF8(F8)
                        iLABPTs = Func_SearchLABPTs(AR.(nBD{iBD}).LABPTs,F8.SET.LAB);
                        if isnumeric(iLABPTs) && iLABPTs == -1, Func_SkipParseF8(fBD,H);
                        else, AR.(nBD{iBD}).LABPTs.(iLABPTs).PO = F8.TRJ;    
                        end

                        nTRJ = nTRJ + 1;
                    end
                else
                    if isstruct(H)
                        Func_SkipParseF8(fBD,H);
                        nTRJ = nTRJ + 1;
                    else
                        isEOF = true;
                    end
                end
            end
        end
    end
    fprintf('completed!\n')
    
    for iBD = 1:1:length(nBD)
        if contains(nBD{iBD},'BD') && isfield(AR.(nBD{iBD}),'TRJ')
            AR.(nBD{iBD}).TRJ.nTRJ = length(fieldnames(AR.(nBD{iBD}).TRJ));
        end
    end
end


fclose(fBD);

% SUMMARY
fprintf('\n    Summary:\n')
nBD = fieldnames(AR);
for iBD = 1:1:length(nBD)
    if contains(nBD{iBD},'BD')
        Par = split(nBD{iBD},'_');
        Par = Par(2:end);
        
        if length(Par) == 1
            fprintf('        1P-BD - Name: %s - Main: %s\n',nBD{iBD},Par{1})
        elseif length(Par) == 2
            fprintf('        2P-BD - Name: %s - Main: %s - Secondary: %s\n',nBD{iBD},Par{1},Par{2})
        end
    end
end


    % FUNCTIONs - VARIABLEs & PARAMETERs 
    function DV = Func_DynVAR(V)
        F  = fieldnames(V);
        nF = length(F);
        iV = 1;
        for iF = 1:1:nF
            if strcmp(V.(F{iF}),'D')
                DV{iV} = F{iF};
                iV = iV + 1;
            end
        end
    end

    function HP = Func_ParseParameters(SET,P)
        F = fieldnames(P);
        for i = 1:1:length(SET.IP)
            iP = SET.IP(i);
            f  = sprintf('Par%i',i);

            HP.(f) = F{iP};
        end
    end


    % FUNCTIONs - BRANCHEs
    function B = Func_NewBR(F7,TYP,P)
        B.BR    = F7.SET.BR     ;
        B.TPar  = F7.SET.FLAG2  ;
        B.TYP   = TYP           ;
        B.IDX   = [F7.SET.INDEX];
        B.IDXBR = [F7.SET.PT   ];
        B.L2    = [F7.L2       ];

        if B.TYP ~= 1 && B.TYP ~= 2, B.T = [F7.T]; B.F = 1./[F7.T]; end

        for iP = 1:1:length(fieldnames(P)), B.(P.(sprintf('Par%i',iP))) = [F7.FP.(sprintf('Par%i',iP))]; end        

        FPT  = fieldnames(F7.PT);
        nFPT = length(FPT);
        for iFPT = 1:1:nFPT
            B.(FPT{iFPT}) = [F7.PT.(FPT{iFPT})];
        end

        B.EigR = F7.E.EigR';
        B.EigI = F7.E.EigI';
    end

    function B = Func_AppendBR(B,F7,P)
        B.IDX   = [B.IDX  ; F7.SET.INDEX];
        B.L2    = [B.L2   ; F7.L2       ];
        B.IDXBR = [B.IDXBR; F7.SET.PT   ];

        if B.TYP ~= 1 && B.TYP ~= 2, B.T = [B.T; F7.T]; B.F = [B.F; 1./F7.T]; end
        
        for iP = 1:1:length(fieldnames(P))
            f = P.(sprintf('Par%i',iP));
            B.(f) = [B.(f); F7.FP.(sprintf('Par%i',iP))]; 
        end

        FPT  = fieldnames(F7.PT);
        nFPT = length(FPT);
        for iFPT = 1:1:nFPT
            B.(FPT{iFPT}) = [B.(FPT{iFPT}); F7.PT.(FPT{iFPT})];
        end

        B.EigR = [B.EigR; F7.E.EigR'];
        B.EigI = [B.EigI; F7.E.EigI'];
    end

    function B = Func_NameBR(F7,TYP,iBR)
        if F7.SET.FLAG2 ~= 0
            if TYP == 1, STYP = 'SN'  ; end
            if TYP == 2, STYP = 'SNPO'; end
            if TYP == 3, STYP = 'HB'  ; end
            if TYP == 4, STYP = 'TR'  ; end
            if TYP == 5, STYP = 'BR'  ; end
            if TYP == 6, STYP = 'PD'  ; end
            if TYP == 7, STYP = 'UZ'  ; end
        else
            if TYP == 1, STYP = 'SEQ' ; end
            if TYP == 2, STYP = 'UEQ' ; end
            if TYP == 3, STYP = 'SLC' ; end
            if TYP == 4, STYP = 'ULC' ; end
            if TYP == 8, STYP = 'BVP' ; end
        end
        
        B = sprintf('B%i_%s',iBR,STYP);
    end

    function TYP = Func_GetTYP(F7)
        PT     = F7.SET.PT;
        TYPCAL = F7.SET.TYPCAL;
        if TYPCAL == 9     , TYP = 1*(PT <= 0) + 2*(PT > 0);
        elseif TYPCAL == 10, TYP = 3*(PT <= 0) + 4*(PT > 0);
        else               , TYP = TYPCAL;
        end
    end

    function I = Func_AreBranchesConnectable(TYP,pTYP,LABPTsTYP)
        I = (any([3,4] == pTYP)                 ...
                 &&  any([3,4] ==  TYP)         ...
                 &&  any([5,7,8] == LABPTsTYP)) ...
                 || (any([1,2] == pTYP)         ...
                 &&  any([1,2] ==  TYP)         ...
                 &&  any([2,3] == LABPTsTYP));
    end

    function I = Func_IsContinuationFromUZ(PT,LAB,PrevPar,NewPar)
        I = PT == 1 && LAB == 0 && not(strcmp(PrevPar,NewPar));
    end


    % FUNCTIONs - LABELLED POINTs
    function B = Func_NewLABPTs(F7,P,iBR)

        B.IDX  = F7.SET.INDEX;
        B.TPar = F7.SET.FLAG2;
        B.TYP  = F7.SET.BIF  ;
        B.L2   = F7.L2       ;
        B.LAB  = F7.SET.LAB  ;
        B.BR   = iBR;
        
        B.EigR = F7.E.EigR';
        B.EigI = F7.E.EigI';
        
        if all(B.TYP ~= [1,2,3]), B.T = F7.T; B.F = 1./F7.T; end
        for iP = 1:1:length(fieldnames(P)), B.(P.(sprintf('Par%i',iP))) = [F7.FP.(sprintf('Par%i',iP))]; end
        
        FPT  = fieldnames(F7.PT);
        nFPT = length(FPT);
        for iFPT = 1:1:nFPT
            B.(FPT{iFPT}) = [F7.PT.(FPT{iFPT})];
        end
    end

    function B = Func_NameLABPTs(F7)
        TYPEs = [ -4 ,  1 ,  2 ,  3 ,  4 ,    5 ,  6 ,  7 ,  8 , 9  ];
        NAMEs = {'UZ','BP','SN','HB','UZ','SNPO','BC','PD','TR','EP'};
        B = sprintf('PT%i_%s',F7.SET.LAB,NAMEs{TYPEs == F7.SET.BIF});
        
        if all(not(TYPEs == F7.SET.BIF))
            N  = F7.SET.BIF; 
            N1 = floor(abs(N)/10);
            N2 = mod(abs(N),10);

            if     F7.SET.BIF < 0 && N2 == 9, TYPE = 'MX'; 
            elseif F7.SET.BIF < 0 && N2 == 4, TYPE = 'UZ';
            elseif F7.SET.BIF > 0 && N2 == 9, TYPE = 'EP';
            elseif F7.SET.BIF > 0 && N2 == 4, TYPE = 'RG';
            end
            B = sprintf('PT%i_%s%s',F7.SET.LAB,TYPE,NAMEs{TYPEs == N1});
        end
    end

    function B = Func_SearchLABPTs(LABPTs,LAB)
        B = -1;
        F = fieldnames(LABPTs);
        nF = length(F);
        for iF = 1:1:nF
            if not(strcmp(F{iF},'nPT'))
                if LABPTs.(F{iF}).LAB == LAB
                    B = F{iF};
                    return
                end
            end
        end
    end


    % FUNCTIONs - SPECIAL SOLUTIONs
    function I = Func_IsStorableF8(F8)
        I  = true;
        F  = fieldnames(F8.TRJ);
        nF = length(F);
        for iF = 1:1:nF
            if any(isnan(F8.TRJ.(F{iF})))
                I = false;
                return
            end
        end
    end

    

end