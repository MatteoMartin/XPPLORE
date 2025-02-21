function Func_SaveFigure(fig, varargin)
%
%       Func_SaveFigure(fig, [FILENAME], [OPTIONs])
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
% Last Update - 01/03/2025

% WARNING - The method to move the grid on top or on the bottom of the plot
%           will be no longer supported in future version of Matlab.
%           This function avoid the display of the current error.

warning('off','all')


% DEFAULT VALUEs

defaultOptions  = Func_DOF();
defaultFileName = '';

% PARSING INPUT

parser = inputParser;
addRequired(parser ,'fig'      ,@isgraphics)
addParameter(parser,'FILENAME' ,defaultFileName,@ischar  )
addParameter(parser,'OPTIONs'  ,defaultOptions ,@isstruct)
parse(parser,fig,varargin{:});


% UNPACKING INPUT

fileName = parser.Results.FILENAME;
opts     = parser.Results.OPTIONs;


% CONSTANTS 

typeAxes        = 'matlab.graphics.axis.Axes';
typeTiledLayout = 'matlab.graphics.layout.TiledChartLayout';
typeWorldGroup  = 'matlab.graphics.primitive.world.Group';
typeLegend      = 'matlab.graphics.illustration.Legend';


% SIZE

fig.Units       = opts.units;
fig.Position(3) = opts.width;
fig.Position(4) = opts.height;


% PROPERTIES

figV = 'fig.Children'; Explode(figV,fig)


% EXPORT

fig.PaperPositionMode = 'auto';
if not(isempty(fileName))
    print([fileName,opts.extension], opts.format, opts.resolution)
end


    function Explode(figV,fig)
        ObjToModFont = eval(figV);
        if strcmp(class(ObjToModFont),typeAxes)
            SetObjGraphComp(ObjToModFont, @SetAxesProperty)
            SetObjGraphComp(ObjToModFont, @SetGridProperty)
        end
        if strcmp(class(ObjToModFont),typeTiledLayout)
            for i = 1:1:length(ObjToModFont)
                Explode([figV, '(',num2str(i),').Children'],fig)
            end
        end
        if strcmp(class(ObjToModFont),typeWorldGroup)
            for i = 1:1:length(ObjToModFont)
                try
                    Explode([figV,sprintf('(%i)',i)],fig)
                catch
                    if strcmp(class(ObjToModFont(i)),typeAxes)
                        SetObjGraphComp(ObjToModFont(i), @SetAxesProperty)
                        SetObjGraphComp(ObjToModFont(i), @SetGridProperty)
                    end
                end
            end
        end
        if strcmp(class(ObjToModFont),typeLegend)
        end
    end

    function SetObjGraphComp(figV, f)
        if length(figV) == 1
            f(figV)
        else
            for i = 1:1:length(figV)
                f(figV(i))
            end
        end
    end

    function SetGridProperty(figV)
        set(figV, 'LooseInset',          max(get(figV,'TightInset'), 0.02), ...
                  'GridLineStyle',       opts.gridLineStyle,                ...
                  'YGrid',               'on',                              ...
                  'XGrid',               'on',                              ...
                  'GridLineStyle',       opts.gridLineStyle,                ...
                  'MinorGridLineStyle' , opts.minorGridLineStyle,           ...
                  'GridAlpha'          , opts.gridAlpha,                    ...
                  'MinorGridAlpha'     , opts.minorGridAlpha,               ...
                  'Box'                , 'on',                              ...
                  'Layer'              , opts.Layer,                        ...
                  'ClippingStyle'      , opts.ClippingStyle)
        
        AX_ = struct(figV);
        AX_.XGridHandle.FrontMajorEdge.Layer = 'back';
        AX_.YGridHandle.FrontMajorEdge.Layer = 'back';
    end

    function SetAxesProperty(figV)
        set(figV,'FontName',opts.FontName,'FontSize',opts.FontSize);
        if not(isempty(opts.xlim))
            set(figV,'XLim',opts.xlim)
        end
        if not(isempty(opts.ylim))
            set(figV,'YLim',opts.ylim)
        end
        if not(isempty(opts.zlim))
            set(figV,'ZLim',opts.zlim)
        end
    end

end



