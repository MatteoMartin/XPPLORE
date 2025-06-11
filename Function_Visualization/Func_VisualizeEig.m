function Func_VisualizeEig(M,BD,varargin)
%
%   Func_VisualizeEig(M,BD,[VAR],[BRIND],[TYPE],[OPTIONs])
%
%   Function to visualize the eigenvalues with the
%   bifurcation diagram in BD.
%   The variables on the x/y/z axes are in VAR.
%   The colours of the branches are specified in opts.
%
%   @param M     :   Model's structure
%   @param BD    :   Bifurcation Diagram structure
%   
%   @optional VAR     :   Axes' variables
%   @optional BRIND   :   Index/Indices of branches to be visualized.
%   @optional TYPE    :   Real or Imaginary parts of Eig?
%   @optional OPTIONs :   Options structure
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 06/11/2025

% DEFAULT VALUEs - OPTIONs
defaultOptions = Func_DOBD();

% DEFAULT VALUEs - VARIABLEs
defaultVAR = {BD.P{1},'EigR','EigI'};

% DEFAULT VALUEs - BRANCH INDEXEs
defaultBRIND = {};


% PARSING INPUT

parser = inputParser;
addRequired(parser ,'M'  ,@isstruct)
addRequired(parser ,'BD' ,@isstruct)
addParameter(parser,'VAR'    ,defaultVAR     ,@iscell)
addParameter(parser,'BRIND'  ,defaultBRIND   ,@iscell)
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
parse(parser,M,BD,varargin{:});


% UNPACKING INPUT

VAR   = parser.Results.VAR;
%TYPE  = parser.Results.TYPE;
BRIND = parser.Results.BRIND;
opts  = parser.Results.OPTIONs;


% INFORMATION

CP = BD.P;
P  = M.P;
V  = Func_DynVAR(M.V);
nD = length(V);


% TYPE DEFINITION

TYPE = Func_VAR2TYPE(VAR,CP);
if strcmp(TYPE,'NV'), exit('Warning! - Invalid VAR entry! - Aborting!\n'); end


% INPUT

BDBR = BD.BR;
PTs  = BD.LABPTs;

if isempty(BRIND)
    BRIND = arrayfun(@(x) x, 1:BDBR.nBR, 'UniformOutput', false); 
end


% CYLINDER

ParMin   = nan;
ParMax   = nan;
f        = figure();
hC       = fimplicit(@(x,y)x.^2 + y.^2 - 1,[-1.5 1.5 -1.5 1.5]);
CYL.EigR = hC.XData;
CYL.EigI = hC.YData;
close(f);


% VISUALIZATION

FBR = fieldnames(BDBR);
for i=1:1:length(BRIND)

    BR  = FBR{BRIND{i}};
    T   = BDBR.(BR).TYP ;
    BT  = BDBR.(BR).TPar;

    if Func_IsVisualizableBranch(BDBR.(BR),VAR,V,P)
        [XU,XL] = Func_GetAxis(BDBR.(BR),VAR{1},V,P);
        [YU,YL] = Func_GetAxis(BDBR.(BR),VAR{2},V,P);
        if length(VAR) == 3, [ZU,ZL] = Func_GetAxis(BDBR.(BR),VAR{3},V,P); end
    
        if strcmp(TYPE,'Both')
            if Func_IsContinuationParameter(VAR{1},CP), PAR = XU{1}; end
            if Func_IsContinuationParameter(VAR{2},CP), PAR = YU{1}; end
            if Func_IsContinuationParameter(VAR{3},CP), PAR = ZU{1}; end
            if isnan(ParMin) || ParMin > min(PAR), ParMin = min(PAR); end
            if isnan(ParMax) || ParMax < max(PAR), ParMax = max(PAR); end
        end

        if BT == 0
            if T == 1 , TYP = 'Eq'   ; C = 'S'; end
            if T == 2 , TYP = 'Eq'   ; C = 'U'; end
            if T == 3 , TYP = 'Cycle'; C = 'S'; end
            if T == 4 , TYP = 'Cycle'; C = 'U'; end
            if T == 8 , TYP = 'BVP'  ; C = 'P'; end
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
        M  = opts.BifDiag.(TYP).Marker;
        MS = opts.BifDiag.(TYP).MarkerSize;

        if strcmp(TYPE,'Re/Im') && length(VAR) == 3, LS = '-.';
        else                                       , LS = opts.BifDiag.(TYP).LineStyle;
        end

        % BRANCHEs
        if length(VAR) == 3
            for j = 1:1:nD
                Func_VisualizeBranch(XU{j},YU{j},ZU{j},C,LS,LW,M,MS,'none')
                Func_VisualizeBranch(XL{j},YL{j},ZL{j},C,LS,LW,M,MS,'none')
            end
        elseif length(VAR) == 2
            for j = 1:1:nD
                Func_VisualizeBranch(XU{j},YU{j},[],C,LS,LW,M,MS,'none')
                Func_VisualizeBranch(XL{j},YL{j},[],C,LS,LW,M,MS,'none')
            end
        end

        % BIF & EIG BIF
        Func_VisualizePoints(BRIND{i},PTs,VAR,V,P,opts);

        % Re/Im - BD & BIF
        if strcmp(TYPE,'Re/Im')
            Func_CaseReIm_VisualizeBDBranch(VAR,XU,XL,YU,YL,ZU,ZL,C,LW,M,MS)
            Func_CaseReIm_VisualizeBDPoints(BRIND{i},PTs,VAR,V,P,opts)
        end

        % Both - BIF SLICEs
        if strcmp(TYPE,'Both')
            Func_CaseBoth_VisualizePointSlices(BRIND{i},PTs,VAR,V,P,CYL,opts)
        end

    end
end  

% Both - TUBE
if strcmp(TYPE,'Both')
    Func_VisualizeCylinder(CYL,VAR,CP,ParMin,ParMax)
end

    % FUNCTIONs

    function Func_CaseReIm_VisualizeBDBranch(VAR,XU,XL,YU,YL,ZU,ZL,C,LW,M,MS)
        if length(VAR) == 3 && (strcmp(VAR{1},'EigR') || strcmp(VAR{1},'EigI'))
            Func_VisualizeBranch(zeros(size(YU{1})),YU{1},ZU{1},C,'-',LW,M,MS,'none')
            Func_VisualizeBranch(zeros(size(YL{1})),YL{1},ZL{1},C,'-',LW,M,MS,'none')
        end
        if length(VAR) == 3 && (strcmp(VAR{2},'EigR') || strcmp(VAR{2},'EigI'))
            Func_VisualizeBranch(XU{1},zeros(size(XU{1})),ZU{1},C,'-',LW,M,MS,'none')
            Func_VisualizeBranch(XL{1},zeros(size(XL{1})),ZL{1},C,'-',LW,M,MS,'none')
        end
        if length(VAR) == 3 && (strcmp(VAR{3},'EigR') || strcmp(VAR{3},'EigI'))
            Func_VisualizeBranch(XU{1},YU{1},zeros(size(YU{1})),C,'-',LW,M,MS,'none')
            Func_VisualizeBranch(XL{1},YL{1},zeros(size(YL{1})),C,'-',LW,M,MS,'none')
        end
    end

    function Func_CaseReIm_VisualizeBDPoints(BRi,PTs,VAR,V,P,opts)
        FPTs = fieldnames(PTs);
        
        for k = 1:size(FPTs)-1
            PTi = FPTs{k};

            if PTs.(PTi).BR == BRi - 1

                I = find(opts.Bif.Types == PTs.(PTi).TYP,1);
                if isempty(I), continue, end

                if Func_IsVisualizableBranch(PTs.(PTi),VAR,V,P)
                    X = Func_GetAxis(PTs.(PTi),VAR{1},V,P);
                    Y = Func_GetAxis(PTs.(PTi),VAR{2},V,P);
                    if length(VAR) == 3, Z = Func_GetAxis(PTs.(PTi),VAR{3},V,P); 
                    end

                    % OPTIONs
                    color           = opts.Bif.(opts.Bif.Names{I}).Color;
                    lineStyle       = 'none';
                    lineWidth       = 1;
                    marker          = opts.Bif.(opts.Bif.Names{I}).Marker;
                    markerSize      = opts.Bif.(opts.Bif.Names{I}).MarkerSize;
                    markerFaceColor = opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor;

                    % BIF over BD
                    if length(VAR) == 3 && (strcmp(VAR{1},'EigR') || strcmp(VAR{1},'EigI'))
                        Func_VisualizeBranch(0,Y{1},Z{1},color,lineStyle,lineWidth,marker,markerSize,markerFaceColor)
                    end
                    if length(VAR) == 3 && (strcmp(VAR{2},'EigR') || strcmp(VAR{2},'EigI'))
                        Func_VisualizeBranch(X{1},0,Z{1},color,lineStyle,lineWidth,marker,markerSize,markerFaceColor)
                    end
                    if length(VAR) == 3 && (strcmp(VAR{3},'EigR') || strcmp(VAR{3},'EigI'))
                        Func_VisualizeBranch(X{1},Y{1},0,color,lineStyle,lineWidth,marker,markerSize,markerFaceColor)
                    end
                    
                end
            end
        end
    end

    function Func_CaseBoth_VisualizePointSlices(BRi,PTs,VAR,V,P,CYL,opts)
        FPTs = fieldnames(PTs);
        
        for k = 1:size(FPTs)-1
            PTi = FPTs{k};

            if PTs.(PTi).BR == BRi - 1

                I = find(opts.Bif.Types == PTs.(PTi).TYP,1);
                if isempty(I), continue, end

                if Func_IsVisualizableBranch(PTs.(PTi),VAR,V,P)
                    X = Func_GetAxis(PTs.(PTi),VAR{1},V,P);
                    Y = Func_GetAxis(PTs.(PTi),VAR{2},V,P);
                    if length(VAR) == 3, Z = Func_GetAxis(PTs.(PTi),VAR{3},V,P); 
                    end

                    % OPTIONs
                    color     = opts.Bif.(opts.Bif.Names{I}).Color;
                    lineStyle = 'none';
                    lineWidth = 1;

                    % SLICEs
                    if not(strcmp(VAR{1},'EigI')) && not(strcmp(VAR{1},'EigR'))
                        X = X{1}*ones(size(CYL.EigR));
                        hold on
                        plot3(X,CYL.EigR,CYL.EigI,'LineWidth',lineWidth,'Color',color)
                        fill3(X,CYL.EigR,CYL.EigI,color,'FaceAlpha',0.2,'LineStyle',lineStyle)
                        hold off
                    elseif not(strcmp(VAR{2},'EigI')) && not(strcmp(VAR{2},'EigR'))
                        Y = Y{2}*ones(size(CYL.EigR));
                        hold on
                        plot3(CYL.EigR,Y,CYL.EigI,'LineWidth',lineWidth,'Color',color)
                        fill3(CYL.EigR,Y,CYL.EigI,color,'FaceAlpha',0.2,'LineStyle',lineStyle)
                        hold off
                    elseif not(strcmp(VAR{3},'EigI')) && not(strcmp(VAR{3},'EigR'))
                        Z = Z{3}*ones(size(CYL.EigR));
                        hold on
                        plot3(CYL.EigR,CYL.EigI,Z,'LineWidth',lineWidth,'Color',color)
                        fill3(CYL.EigR,CYL.EigI,Z,color,'FaceAlpha',0.2,'LineStyle',lineStyle)
                        hold off
                    end
                    
                end
            end
        end
    end

    function TYPE = Func_VAR2TYPE(VAR,CP)

        iE = 0; iV = 0; iP = 0;
        for iS = 1:1:length(VAR)
            if Func_IsEig(VAR{iS})                         , iE = iE + 1;
            elseif Func_IsVariable(VAR{iS},V)              , iV = iV + 1;
            elseif Func_IsContinuationParameter(VAR{iS},CP), iP = iP + 1;
            end
        end

        if length(VAR) == 3 && (iE == 2 && iP == 1)
            TYPE = 'Both';
        elseif length(VAR) == 3 && ((iE == 1 && iP == 1 && iV == 1) || (iE == 1 && iP == 2))
            TYPE = 'Re/Im';
        elseif length(VAR) == 2 && ((iE == 2) || (iE == 1 && iP == 1))
            TYPE = 'Re/Im';
        else
            TYPE = 'NV';
        end
    end

    function Func_VisualizeCylinder(C,VAR,CP,ParMin,ParMax)

        nP    = max(size(C.EigR));
        C.Par = repmat(linspace(ParMin,ParMax,10),[nP,1]);
        C.RM  = repmat(C.EigR',[1,10]);
        C.IM  = repmat(C.EigI',[1,10]);

        hold on
        if Func_IsContinuationParameter(VAR{1},CP)
            surf(C.Par,C.RM,C.IM,'FaceColor','k','FaceAlpha',0.2,'EdgeColor','none')
        elseif Func_IsContinuationParameter(VAR{2},CP)
            surf(C.RM,C.Par,C.IM,'FaceColor','k','FaceAlpha',0.2,'EdgeColor','none')
        elseif Func_IsContinuationParameter(VAR{3},CP)
            surf(C.RM,C.IM,C.Par,'FaceColor','k','FaceAlpha',0.2,'EdgeColor','none')
        end
        hold off

    end

    function Func_VisualizeBranch(X,Y,Z,C,LS,LW,M,MS,MFC)
        if isempty(Z)
            hold on
            plot(X,Y,'Color',C,      ...
                'LineStyle',LS, ...
                'LineWidth',LW, ...
                'Marker',M,     ...
                'MarkerSize',MS,...
                'MarkerFaceColor',MFC)
            hold off
        else
            hold on
            plot3(X,Y,Z,'Color',C,      ...
                'LineStyle',LS, ...
                'LineWidth',LW, ...
                'Marker',M,     ...
                'MarkerSize',MS,...
                'MarkerFaceColor',MFC)
            hold on
        end
    end

    function Func_VisualizePoints(BRi,PTs,VAR,V,P,opts)
        FPTs = fieldnames(PTs);
        
        for k = 1:size(FPTs)-1
            PTi = FPTs{k};

            if PTs.(PTi).BR == BRi - 1

                I = find(opts.Bif.Types == PTs.(PTi).TYP,1);
                if isempty(I), continue, end

                if Func_IsVisualizableBranch(PTs.(PTi),VAR,V,P)
                    X = Func_GetAxis(PTs.(PTi),VAR{1},V,P);
                    Y = Func_GetAxis(PTs.(PTi),VAR{2},V,P);
                    if length(VAR) == 3, Z = Func_GetAxis(PTs.(PTi),VAR{3},V,P); 
                    end

                    % OPTIONs
                    color           = opts.Bif.(opts.Bif.Names{I}).Color;
                    lineStyle       = 'none';
                    lineWidth       = 1;
                    marker          = opts.Bif.(opts.Bif.Names{I}).Marker;
                    markerSize      = opts.Bif.(opts.Bif.Names{I}).MarkerSize;
                    markerFaceColor = opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor;

                    % LABELLED POINTs - BRANCHEs
                    if length(VAR) == 3
                        for iD = 1:1:length(V)
                            Func_VisualizeBranch(X{iD},Y{iD},Z{iD},color,lineStyle,lineWidth,marker,markerSize,markerFaceColor)
                        end
                    elseif length(VAR) == 2
                        for iD = 1:1:length(V)
                            Func_VisualizeBranch(X{iD},Y{iD},[],color,lineStyle,lineWidth,marker,markerSize,markerFaceColor)
                        end
                    end
                    
                end
            end
        end
    end
    
    function isV = Func_IsVisualizableBranch(B,VAR,V,P)
        isV  = true;
        F    = fieldnames(B);
        nVAR = length(VAR);
        for iV = 1:1:nVAR
            if not(Func_IsSpecialField(VAR{iV}))
                if not(Func_IsVariable(VAR{iV},V))
                    if not(Func_IsParameter(VAR{iV},P))
                        if not(Func_IsEig(VAR{iV}))
                            isV = false;
                            break
                        end
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

    function isV = Func_IsEig(VC)
        isV = false;
        if strcmp(VC,'EigR')
            isV = true;
            return
        end
        if strcmp(VC,'EigI')
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

    function isP = Func_IsContinuationParameter(PC,P)
        isP = false;
        for iPAR = 1:1:length(P)
            if strcmp(PC,P{iPAR})
                isP = true;
                break
            end
        end
    end
    
    function [QU,QL] = Func_GetAxis(B,VAR,V,P)

        nD = length(V);
        QU = cell(1,nD);
        QL = cell(1,nD);

        if Func_IsParameter(VAR,P)
            for iD = 1:1:nD
                QU{iD} = B.(VAR);
                QL{iD} = B.(VAR);
            end
            return
        end

        if Func_IsVariable(VAR,V)
            for iD = 1:1:nD
                QU{iD} = B.([VAR,'U']);
                QL{iD} = B.([VAR,'L']);
            end
            return
        end

        if Func_IsEig(VAR)
            for iD = 1:1:nD
                QU{iD} = B.(VAR)(:,iD);
                QL{iD} = B.(VAR)(:,iD);
            end
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
