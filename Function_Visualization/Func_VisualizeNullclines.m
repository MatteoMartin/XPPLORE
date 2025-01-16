function Func_VisualizeNullclines(NC,varargin)
%
%   Func_VisualizeNullclines(NC,[OPTION])
%
%   Function used to visualize the nullclines in the structure NC.
%
%   @param NC :   Nullclines structure
%
%   @optional OPTIONs :   Option structure
%
%   
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/08/2024

% DEFAULT VALUEs

defaultOptions = Func_DOBD();

% PARSING INPUT

parser = inputParser;
addRequired(parser ,'NC'     ,@isstruct                )
addParameter(parser,'OPTIONs',defaultOptions ,@isstruct)
parse(parser,NC,varargin{:});

% UNPACKING INPUT

opts = parser.Results.OPTIONs;


% VISUALIZATION

FNC  = fieldnames(NC);
nFNC = length(FNC);

for iNC = 1:1:nFNC
    NCi = FNC{iNC};

    FPT = fieldnames(NC.(NCi));
    
    for iP = 1:1:NC.(NCi).nPT
        N = NC.(NCi).(FPT{iP});

        hold on
        plot(N(:,1),N(:,2),'Color',opts.NC.C{iNC},'LineWidth',1.2)
        hold off
    end
end





end