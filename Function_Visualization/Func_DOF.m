function opts = Func_DOF(varargin)
%
%   opts = Func_DOF()
%
%   This function creates the structure of the default figure style options
%
%   @output opts:   Options structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/06/2025

% Validator

isXYZLim = @(x) length(x) == 2 && x(1) < x(2);

% Parser

p = inputParser;
addOptional(p,'format'            ,'-dpdf'            )
addOptional(p,'extension'         ,'.pdf'             )
addOptional(p,'resolution'        ,'-r600'            )
addOptional(p,'width'             ,10                 ,@isnumeric)
addOptional(p,'height'            ,10                 ,@isnumeric)
addOptional(p,'Layer'             ,'top'              ,@ischar)
addOptional(p,'ClippingStyle'     ,'rectangle'        ,@ischar)
addOptional(p,'FontName'          ,'Times New Roman'  ,@ischar)
addOptional(p,'FontSize'          ,12                 ,@isnumeric)
addOptional(p,'xlim'              ,[]                 ,isXYZLim)
addOptional(p,'ylim'              ,[]                 ,isXYZLim)
addOptional(p,'zlim'              ,[]                 ,isXYZLim)
addOptional(p,'units'             ,'centimeters'      ,@ischar)
addOptional(p,'gridLineStyle'     ,'none'             ,@ischar)
addOptional(p,'minorGridLineStyle','none'             ,@ischar)
addOptional(p,'gridAlpha'         ,0.05               ,@isnumeric)
addOptional(p,'minorGridAlpha'    ,0.05               ,@isnumeric)
parse(p,varargin{:})

% Figure - Size

opts.width  = p.Results.width;
opts.height = p.Results.height;
opts.units  = p.Results.units;

% Figure - Format

opts.format     = p.Results.format;
opts.extension  = p.Results.extension;
opts.resolution = p.Results.resolution;

% Figure - Grid Settings

opts.gridLineStyle      = p.Results.gridLineStyle;
opts.minorGridLineStyle = p.Results.minorGridLineStyle;
opts.gridAlpha          = p.Results.gridAlpha;     
opts.minorGridAlpha     = p.Results.minorGridAlpha;

% Figure - Layer Organization

opts.Layer         = p.Results.Layer;
opts.ClippingStyle = p.Results.ClippingStyle;

% Figure - Font

opts.FontName = p.Results.FontName;
opts.FontSize = p.Results.FontSize;

% Figure - Axes Boundaries 

opts.xlim = p.Results.xlim;
opts.ylim = p.Results.ylim;
opts.zlim = p.Results.zlim;

end