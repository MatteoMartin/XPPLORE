function Func_VisualizeNullclines(NC,varargin)
%
%   Func_VisualizeNullclines(NC,[VAR],[OPTION])
%
%   Function used to visualize the nullclines in the structure NC.
%
%   @param NC :   Nullclines structure
%
%   @optional VAR     :   Variable structure
%   @optional OPTIONs :   Option structure
%
%   
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/08/2025

% DEFAULT VALUEs - options

defaultOptions = Func_DOBD();

% DEFAULT VALUEs - nullclines

defaultVAR = replace(fieldnames(NC),'NC','')';


% PARSING INPUT

parser = inputParser;
addRequired(parser ,'NC'     ,@isstruct                )
addParameter(parser,'VAR'    ,defaultVAR     ,@iscell  )
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
parse(parser,NC,varargin{:});


% UNPACKING INPUT

opts = parser.Results.OPTIONs;
VAR  = parser.Results.VAR;


% PROCESSING

VNC = replace(fieldnames(NC),'NC','')';

iX = find(strcmp(VAR,VNC{1}));
iY = find(strcmp(VAR,VNC{2}));


% VISUALIZATION

FNC  = fieldnames(NC);
nFNC = length(FNC);

for iNC = 1:1:nFNC
    NCi = FNC{iNC};

    FPT = fieldnames(NC.(NCi));
    
    for iP = 1:1:NC.(NCi).nPT
        N = NC.(NCi).(FPT{iP});

        hold on
        plot(N(:,iX),N(:,iY),'Color',opts.NC.C{iNC},'LineWidth',1.2)
        hold off
    end
end





end