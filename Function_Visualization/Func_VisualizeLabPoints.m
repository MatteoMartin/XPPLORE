function Func_VisualizeLabPoints(M,BD,varargin)
%
%   Func_VisualizeLabPoints(M,LABPTs,[VAR],[BRIND],[PTIND],[OPTIONs],[TYPE])
%
%   Function to visualize the labelled points in LABPTs.
%   The variables on the x/y/z axes are in VAR.
%   The colours of the branches are specified in opts.
%
%   @param M      :   Model's structure.
%   @param LABPTs :   Labelled points.
%
%   @optional VAR     :   Axes' variables
%   @optional BRIND   :   Index/Indices of branches to be visualized
%   @optional PTIND   :   Index/Indices of points to be visualized
%   @optional OPTIONs :   Options structure
%   @optional TYPE    :   Standard/Initial/Upper/Lower/Average
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 02/13/2025


% DEFAULT VALUEs

defaultOptions = Func_DOBD();
defaultBRIND = {};
defaultPTIND = {};
defaultTYPE = 'Standard';
% defaultBRIND = arrayfun(@(x) x, 1:BD.BR.nBR, 'UniformOutput', false);
% defaultPTIND = arrayfun(@(x) x, BD.LABPTs.:BD.LABPTs.nPT, 'UniformOutput', false);

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
addParameter(parser,'BRIND'  ,defaultBRIND   ,@iscell)
addParameter(parser,'PTIND'  ,defaultPTIND   ,@iscell)
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
addParameter(parser,'TYPE'   ,defaultTYPE    ,@ischar)
parse(parser,M,BD,varargin{:});

% UNPACKING INPUT

VAR  = parser.Results.VAR;
BRIND = parser.Results.BRIND;
PTIND = parser.Results.PTIND;
opts = parser.Results.OPTIONs;
TYPE = parser.Results.TYPE;

% PARSING TYPE

if strcmp(TYPE,'Standard'), TYPE = {'U','L'}; end
if strcmp(TYPE,'Average') , TYPE = {'A'};     end
if strcmp(TYPE,'Initial') , TYPE = {'i'};     end
if strcmp(TYPE,'Lower')   , TYPE = {'L'};     end
if strcmp(TYPE,'Upper')   , TYPE = {'U'};     end

% INPUT

PTs = BD.LABPTs;
P   = M.P;
V   = Func_DynVAR(M.V);
nV  = length(VAR);

VIZPTs = Func_GetVisualizablePoints(PTs,BRIND,PTIND);

for iB = 1:1:length(VIZPTs)
    PTi = VIZPTs{iB};

    TYP = abs(PTs.(PTi).TYP);
    if abs(TYP) > 10, TYP = floor(abs(PTs.(PTi).TYP)/10); end

    I = find(opts.Bif.Types == TYP,1);
    if isempty(I), continue, end

    if Func_IsVisualizablePoint(PTs.(PTi),VAR,V,P)
        [XU,XL] = Func_GetAxis(PTs.(PTi),VAR{1},V,P,TYPE);
        [YU,YL] = Func_GetAxis(PTs.(PTi),VAR{2},V,P,TYPE);
        if length(VAR) == 3, [ZU,ZL] = Func_GetAxis(PTs.(PTi),VAR{3},V,P,TYPE);
        else,                ZU = []; ZL = []; 
        end
    
        if nV == 2
            hold on
            plot(XU,YU,'LineStyle'      ,'none',...
                       'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                       'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                       'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                       'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            if not(isempty(XL)) && not(isempty(YL))
                plot(XL,YL,'LineStyle'      ,'none',...
                           'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                           'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                           'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                           'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            end
            hold off
        end
        if nV == 3
            hold on
            if not(isempty(XL)) && not(isempty(YL)) && not(isempty(ZL))
                plot3(XL,YL,ZL,'LineStyle'      ,'none',...
                               'Marker'         ,opts.Bif.(opts.Bif.Names{I}).Marker     ,...
                               'Color'          ,opts.Bif.(opts.Bif.Names{I}).Color      ,...
                               'MarkerSize'     ,opts.Bif.(opts.Bif.Names{I}).MarkerSize ,...
                               'MarkerFaceColor',opts.Bif.(opts.Bif.Names{I}).MarkerFaceColor)
            end
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

    function VIZPTs = Func_GetVisualizablePoints(PTs,BRIND,PTIND)
        nPT = PTs.nPT;
        VIZPTs = {};
        j=1;
        FPT = fieldnames(PTs);
        for i=1:nPT
            if isempty(BRIND) && isempty(PTIND)
                VIZPTs{j} = FPT{i};
                j = j + 1;
            end

            if any(cellfun(@(x) isequal(x,PTs.(FPT{i}).BR),BRIND)) || ...
                    any(cellfun(@(x) isequal(x,PTs.(FPT{i}).LAB),PTIND))
                VIZPTs{j} = FPT{i};
                j = j + 1;
            end
        end
    end

    function isV = Func_IsVisualizablePoint(B,VAR,V,P)
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

    function [QU,QL] = Func_GetAxis(B,VAR,V,P,TYPE)
        if Func_IsParameter(VAR,P)
            QU = B.(VAR);
            if length(TYPE) == 2, QL = B.(VAR);
            else,                 QL = [];
            end
            return
        end
        if Func_IsVariable(VAR,V)
            if length(TYPE) == 2
                QU = B.([VAR,TYPE{1}]);
                QL = B.([VAR,TYPE{2}]);
            else
                QU = B.([VAR,TYPE{1}]);
                QL = [];
            end
            return
        end
        if Func_IsSpecialField(VAR)
            QU = B.(VAR);
            if length(TYPE) == 2, QL = B.(VAR);
            else,                 QL = [];
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