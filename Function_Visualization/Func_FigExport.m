function Func_FigExport(fig, fileName, varargin)
%
%       Func_FigExport(fig, fileName, varargin)
%
%   Function that facilitate the savage of the figure specified as
%   parameter of the function.
%
%   @param fig      :   Figure to export
%   @param opts     :   Options' structure
%   @param fileName :   File name
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/06/2025

% WARNING - The method to move the grid on top or on the bottom of the plot
%           will be no longer supported in future version of Matlab.
%           This function avoid the display of the current error.

warning('off','all')


% DEFAULT VALUEs

defaultOptions  = Func_DOF();


% PARSING INPUT

parser = inputParser;
addRequired(parser ,'fig'     , @isgraphics)
addRequired(parser ,'fileName', @ischar    )
addParameter(parser,'OPTIONs' , defaultOptions ,@isstruct)
parse(parser,fig,fileName,varargin{:});


% UNPACKING INPUT

opts = parser.Results.OPTIONs;

% EXPORT

fig.PaperPositionMode = 'auto';
fig.PaperSize         = [fig.Position(3) fig.Position(4)];
if not(isempty(fileName))
    print([fileName,opts.extension], opts.format, opts.resolution)
end

end



