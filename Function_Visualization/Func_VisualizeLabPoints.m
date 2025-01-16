function Func_VisualizeLabPoints(M,BD,varargin)
%
%   Func_VisualizeLabPoints(M,LABPTs,[VAR],[OPTIONs])
%
%   Function to visualize the labelled points in LABPTs.
%   The variables on the x/y/z axes are in VAR.
%   The colours of the branches are specified in opts.
%
%   @param M      :   Model's structure.
%   @param LABPTs :   Labelled points.
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
% Last Update - 01/07/2025


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

PTs = BD.LABPTs;
P   = M.P;
V   = Func_DynVAR(M.V);
nV  = length(VAR);

FPT = fieldnames(PTs);
for iB = 1:1:PTs.nPT
    PTi = FPT{iB};

    I = find(opts.Bif.Types == PTs.(PTi).TYP,1);
    if isempty(I), continue, end

    if Func_IsVisualizableBranch(PTs.(PTi),VAR,V,P)
        [XU,XL] = Func_GetAxis(PTs.(PTi),VAR{1},V,P);
        [YU,YL] = Func_GetAxis(PTs.(PTi),VAR{2},V,P);
        if length(VAR) == 3, [ZU,ZL] = Func_GetAxis(PTs.(PTi),VAR{3},V,P);
        else,                ZU = []; ZL = []; 
        end
    
        if nV == 2
            hold on
            plot(XU,YU,'LineStyle'      ,'none',...
                       'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                       'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                       'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                       'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            plot(XL,YL,'LineStyle'      ,'none',...
                       'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                       'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                       'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                       'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            hold off
        end
        if nV == 3
            hold on
            plot3(XL,YL,ZL,'LineStyle'      ,'none',...
                           'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                           'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                           'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                           'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            plot3(XU,YU,ZU,'LineStyle'      ,'none',...
                           'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                           'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                           'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                           'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            hold off
        end
    end
end

    % FUNCTIONs
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
                    end
                end
            else
                isV = Func_IsField(VAR{iV},F);
            end
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