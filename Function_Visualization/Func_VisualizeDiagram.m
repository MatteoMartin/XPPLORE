function Func_VisualizeDiagram(M,BD,varargin)
%
%   Func_VisualizeDiagram(M,BD,[VAR,OPTIONs])
%
%   Function to visualize the bifurcation diagram in BD.
%   The variables on the x/y/z axes are in VAR.
%   The colours of the branches are specified in opts.
%
%   @param M    :   Model's structure
%   @param BD   :   Bifurcation Diagram structure
%
%   @optional VAR     :   Axes' variables
%   @optional OPTIONs :   Options structure
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 12/13/2024


% DEFAULT VALUEs

defaultOptions = Func_DOBD();

% DEFAULT VALUEs - VARIABLEs
iFs = 1;
Fs  = fieldnames(M.V); 
while not(strcmp(M.V.(Fs{iFs}),'D')), iFs = iFs + 1; end
if length(BD.P) == 2, defaultVAR = BD.P;
else                , defaultVAR = {BD.P{1},Fs{iFs}};
end

% PARSING INPUT

parser = inputParser;
addRequired(parser ,'M'  ,@isstruct)
addRequired(parser ,'BD' ,@isstruct)
addParameter(parser,'VAR'    ,defaultVAR     ,@iscell)
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
parse(parser,M,BD,varargin{:});

% UNPACKING INPUT

VAR  = parser.Results.VAR;
opts = parser.Results.OPTIONs;

% INPUT

BD = BD.BR;
P  = M.P;
V  = Func_DynVAR(M.V);
nV = length(VAR);

FBR = fieldnames(BD);
for iBR = 1:1:BD.nBR
    
    BR = FBR{iBR};
    T  = BD.(BR).TYP ;
    BT = BD.(BR).TPar;

    if Func_IsVisualizableBranch(BD.(BR),VAR,V,P)
        [XU,XL] = Func_GetAxis(BD.(BR),VAR{1},V,P);
        [YU,YL] = Func_GetAxis(BD.(BR),VAR{2},V,P);
        if length(VAR) == 3, [ZU,ZL] = Func_GetAxis(BD.(BR),VAR{3},V,P);
        else,                ZU = []; ZL = []; 
        end
    
        if BT == 0
            if T == 1 , TYP = 'OrdEq';  C = 'S'; end
            if T == 2 , TYP = 'OrdEq';  C = 'U'; end
            if T == 3 , TYP = 'Cycle';  C = 'S'; end
            if T == 4 , TYP = 'Cycle';  C = 'U'; end
            if T == 8 , TYP = 'BVP'  ;  C = 'P'; end
        else
            TYP = 'Bif';
            if T == 1 , C = 'SN'  ; end
            if T == 2 , C = 'SNPO'; end
            if T == 3 , C = 'HB'  ; end
            if T == 4 , C = 'TR'  ; end
            if T == 6 , C = 'PD'  ; end
            if T == 7 , C = 'UZ'  ; end
        end
    
        C  = opts.BifDiag.(TYP).(C);
        LW = opts.BifDiag.(TYP).LineWidth;
        LS = opts.BifDiag.(TYP).LineStyle;
        M  = opts.BifDiag.(TYP).Marker;
        MS = opts.BifDiag.(TYP).MarkerSize;
    
        Func_VisualizeBranch(XU,YU,ZU,C,LS,LW,M,MS)
        Func_VisualizeBranch(XL,YL,ZL,C,LS,LW,M,MS)
    end

end

    % FUNCTIONs
    function Func_VisualizeBranch(X,Y,Z,C,LS,LW,M,MS)
        if isempty(Z)
            hold on
            plot(X,Y,'Color',C,      ...
                'LineStyle',LS, ...
                'LineWidth',LW, ...
                'Marker',M,     ...
                'MarkerSize',MS)
            hold off
        else
            hold on
            plot3(X,Y,Z,'Color',C,      ...
                'LineStyle',LS, ...
                'LineWidth',LW, ...
                'Marker',M,     ...
                'MarkerSize',MS)
            hold off
        end
    end

    function isV = Func_IsTwoParameter(VAR,P)
        nV = length(VAR);
        nP = 0;
        for iV = 1:1:nV
            if Func_IsParameter(VAR{iV},P)
                nP = nP + 1;
            end
        end

        isV = false;
        if nP == 2, isV = true; end
    end

    function isV = Func_IsVisualizableBranch(B,VAR,V,P)
        isV  = true;
        F    = fieldnames(B);
        nVAR = length(VAR);
        for iV = 1:1:nVAR
            if not(Func_IsSpecialField(VAR{iV}))
                if not(Func_IsVariable(VAR{iV},V))
                    if not(Func_IsParameter(VAR{iV},P))
                        isV = false;
                        break
                    else
                        isV = Func_IsField(VAR{iV},F);
                        if not(isV), break; end
                    end
                end
            else
                isV = Func_IsField(VAR{iV},F);
                if not(isV), break; end
            end
        end
    end

    function isV = Func_IsSpecialField(VC)
        isV = false;
        if strcmp(VC,'L2')
            isV = true;
            return
        end
        if strcmp(VC,'T')
            isV = true;
            return
        end
    end

    function isV = Func_IsField(f,F)
        isV = false;
        nF  = length(F);
        for iF = 1:1:nF
            if strcmp(F{iF},f)
                isV = true;
                break
            end
        end
    end

    function isV = Func_IsVariable(VC,V)
        isV  = false;
        nVAR = length(V);
        for iVAR = 1:1:nVAR
            if strcmp(VC,V{iVAR})
                isV = true;
                break
            end
        end
    end

    function isP = Func_IsParameter(PC,P)
        isP = false;
        F   = fieldnames(P);
        for iPAR = 1:1:P.nP
            if strcmp(PC,F{iPAR})
                isP = true;
                break
            end
        end
    end

    function [QU,QL] = Func_GetAxis(B,VAR,V,P)
        if Func_IsParameter(VAR,P)
            QU = B.(VAR);
            QL = B.(VAR);
            return
        end
        if Func_IsVariable(VAR,V)
            QU = B.([VAR,'U']);
            QL = B.([VAR,'L']);
            return
        end
        if Func_IsSpecialField(VAR)
            QU = B.(VAR);
            QL = B.(VAR);
            return
        end
    end

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

end