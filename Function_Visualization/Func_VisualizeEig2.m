function Func_VisualizeEig2(M,BD,varargin)
%
%   Func_VisualizeEig2(M,BD,[PAR],[BRIND],[OPTIONs])
%
%   Function to visualize the eigenvalues with the
%   bifurcation diagram in BD.
%   The variables on the x/y/z axes are in VAR.
%   The colours of the branches are specified in opts.
%
%   @param M     :   Model's structure
%   @param BD    :   Bifurcation Diagram structure
%   
%   @optional PAR     :   Parameter to be visualized.
%   @optional BRIND   :   Index/Indices of branches to be visualized.
%   @optional OPTIONs :   Options structure
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 06/03/2025




% DEFAULT VALUEs - OPTIONs
defaultOptions = Func_DOBD();

% DEFAULT VALUEs - PARAMETERs
defaultPAR   = BD.P;

% DEFAULT VALUEs - BRANCH INDEXEs
defaultBRIND = {};

% PARSING INPUT

parser = inputParser;
addRequired(parser ,'M'  ,@isstruct)
addRequired(parser ,'BD' ,@isstruct)
addParameter(parser,'PAR'    ,defaultPAR     ,@iscell  )
addParameter(parser,'BRIND'  ,defaultBRIND   ,@iscell  )
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
parse(parser,M,BD,varargin{:});


% UNPACKING INPUT

PAR   = parser.Results.PAR    ;
BRIND = parser.Results.BRIND  ;
opts  = parser.Results.OPTIONs;

% INPUT

BDBR = BD.BR;
P    = M.P;
V    = Func_DynVAR(M.V);
PTs  = BD.LABPTs;
DIM  = length(V);
    
% Begin Visualization

FBR = fieldnames(BDBR);
FPT = fieldnames(PTs);

if isempty(BRIND), BRIND = arrayfun(@(x) x, 1:BDBR.nBR, 'UniformOutput', false); end
nBRIND = length(BRIND);

ParMin = nan;
ParMax = nan;

f = figure();
hC = fimplicit(@(x,y)x.^2 + y.^2 - 1,[-1.5 1.5 -1.5 1.5]);
CYL.EigR = hC.XData;
CYL.EigI = hC.YData;
close(f);

% Visualize BD Branches
for i=1:1:nBRIND

    iBR = BRIND{i};
    BR  = FBR{iBR};
    T   = BDBR.(BR).TYP ;
    BT  = BDBR.(BR).TPar;

    if Func_IsVisualizableBranch(BDBR.(BR),PAR,V,P)
        X = Func_GetAxis(BDBR.(BR),PAR{1},V,P);
        Y = Func_GetAxis(BDBR.(BR),'EigR',V,P);
        Z = Func_GetAxis(BDBR.(BR),'EigI',V,P);

        if isnan(ParMin) || ParMin > min(X), ParMin = min(X); end
        if isnan(ParMax) || ParMax < max(X), ParMax = max(X); end
    
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

        Func_VisualizeBranch(X,Y,Z,C,LS,LW,M,MS,'none')
        Func_VisualizeLabPoints(BRIND{i},PTs,PAR,V,P,opts,CYL);
    end
end

Func_VisualizeCylinder(CYL,ParMin,ParMax);
    
    % FUNCTIONs

    function Func_VisualizeCylinder(C,ParMin,ParMax)

        nP    = max(size(C.EigR));
        C.Par = repmat(linspace(ParMin,ParMax,10),[nP,1]);
        C.RM  = repmat(C.EigR',[1,10]);
        C.IM  = repmat(C.EigI',[1,10]);

        hold on
        surf(C.Par,C.RM,C.IM,'FaceColor','k','FaceAlpha',0.2,'EdgeColor','none')
        hold off

        %hold on
        %plot3(C.Par(:,1)  ,C.RM(:,1)  ,C.IM(:,1)  ,'Color','k','LineWidth',1.2)
        %plot3(C.Par(:,end),C.RM(:,end),C.IM(:,end),'Color','k','LineWidth',1.2)
        %hold off

    end

    function Func_VisualizeBranch(X,Y,Z,C,LS,LW,M,MS,MFC)
        nDIM = length(Y);
        hold on
        for iD = 1:1:nDIM
            plot3(X,Y{iD},Z{iD},'Color',C,...
                                'LineStyle',LS, ...
                                'LineWidth',LW, ...
                                'Marker',M,     ...
                                'MarkerSize',MS,...
                                'MarkerFaceColor',MFC)
        end
        hold on
    end

    function Func_VisualizeLabPoints(BRi,PTs,PAR,V,P,opts,CYL)
        FPTs = fieldnames(PTs);
        for k = 1:size(FPTs)-1
            PTi = FPTs{k};

            if PTs.(PTi).BR == BRi - 1

                I = find(opts.Bif.Types == PTs.(PTi).TYP,1);
                if isempty(I), continue, end
        
                if Func_IsVisualizableBranch(PTs.(PTi),PAR,V,P)
                    X = Func_GetAxis(PTs.(PTi),PAR{1},V,P);
                    Y = Func_GetAxis(PTs.(PTi),'EigR',V,P);
                    Z = Func_GetAxis(PTs.(PTi),'EigI',V,P);

                    % Visualize Labeled Points along Eig-BD branches
                    Func_VisualizeBranch(X,Y,Z, ...
                        opts.Bif.(opts.Bif.Names{I}).Color,'none',1, ...
                        opts.Bif.(opts.Bif.Names{I}).Marker,...
                        opts.Bif.(opts.Bif.Names{I}).MarkerSize,...
                        opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor);

                    % Visualize the slice where bifurcation is located
                    X = unique(X)*ones(size(CYL.EigR));
                    hold on
                    plot3(X,CYL.EigR,CYL.EigI,'LineWidth',1,'Color',opts.Bif.(opts.Bif.Names{I}).Color)
                    fill3(X,CYL.EigR,CYL.EigI,opts.Bif.(opts.Bif.Names{I}).Color,'FaceAlpha',0.2,'LineStyle','none')
                    hold off
                end
            end
        end
    end
    
    function isV = Func_IsVisualizableBranch(B,PAR,V,P)
        isV  = true;
        F    = fieldnames(B);
        nPAR = length(PAR);
        for iV = 1:1:nPAR
            if not(Func_IsSpecialField(PAR{iV}))
                if not(Func_IsVariable(PAR{iV},V))
                    if not(Func_IsParameter(PAR{iV},P))
                        isV = false;
                        break
                    else
                        isV = Func_IsField(PAR{iV},F);
                        if not(isV), break; end
                    end
                end
            else
                isV = Func_IsField(PAR{iV},F);
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

    function isV = Func_IsEigenvalue(VC)
        isV = false;
        if contains(VC,'Eig')
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
    
    function Q = Func_GetAxis(B,PAR,V,P)
        if Func_IsParameter(PAR,P)
            Q = B.(PAR);
            return
        end
        if Func_IsEigenvalue(PAR)
            nDIM = length(V);
            for iD = 1:1:nDIM
                Q{iD} = B.(PAR)(:,iD);
            end
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
