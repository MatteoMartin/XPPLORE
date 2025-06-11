function opts = Func_DOBD(varargin)
%
%   opts = Func_DOBD()
%
%   This function creates the default structure containing the visalization
%   settings for the bifurcation diagrams and the bifurcation points.
%
%   @param [SNPO] RGB color vector for SNPO
%   @param [SN]   RGB color vector for SN
%   @param [TR]   RGB color vector for TR
%   @param [HB]   RGB color vector for HB
%   @param [PD]   RGB color vector for PD
%   @param [BP]   RGB color vector for BP
%   @param [UZ]   RGB color vector for UZ
%   @param [EQS]  RGB color vector for stable fixed point
%   @param [EQU]  RGB color vector for unstable fixed point
%   @param [CYS]  RGB color vector for stable cycles
%   @param [CYU]  RGB color vector for unstable cycles
%   @param [BVP]  RGB color vector for boundary value problems
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
% Last Update - 01/07/2025

% XPPAUT's DEFAULT COLOR SCHEME
%SNPO = [  0   0   0]/255;
%SN   = [255   0   0]/255;
%TR   = [  0 160 100]/255;
%HB   = [  0   0 255]/255;
%PD   = [255 128  80]/255;
%BP   = [  0 255 255]/255;
%UZ   = [  0 255 194]/255;

% ANNA & MATTEO's COLOR SCHEME
%SNPO = [255 149   5]/255;
%SN   = [0   255 255]/255;
%TR   = [205 130 255]/255;
%HB   = [255   0 255]/255;
%PD   = [  0   0   0]/255;
%BP   = [  0 255 255]/255;
%UZ   = [  0 255 194]/255;


% DEFAULT VALUEs

defaultValueSNPO = [255 149   5]/255;
defaultValueSN   = [0   255 255]/255;
defaultValueTR   = [205 130 255]/255;
defaultValueHB   = [255   0 255]/255;
defaultValuePD   = [  0   0   0]/255;
defaultValueBP   = [  0 255 255]/255;
defaultValueUZ   = [  0 255 194]/255;

defaultValueEQS  = [1 0 0];
defaultValueEQU  = [0 0 0];
defaultValueCYS  = [0 1 0];
defaultValueCYU  = [0 0 1];
defaultValueBVP  = [0 0 0];


% PARSING

parser = inputParser;
addParameter(parser,'SNPO',defaultValueSNPO,@isvector)
addParameter(parser,'SN'  ,defaultValueSN  ,@isvector)
addParameter(parser,'TR'  ,defaultValueTR  ,@isvector)
addParameter(parser,'HB'  ,defaultValueHB  ,@isvector)
addParameter(parser,'PD'  ,defaultValuePD  ,@isvector)
addParameter(parser,'BP'  ,defaultValueBP  ,@isvector)
addParameter(parser,'UZ'  ,defaultValueUZ  ,@isvector)
addParameter(parser,'EQS' ,defaultValueEQS ,@isvector)
addParameter(parser,'EQU' ,defaultValueEQU ,@isvector)
addParameter(parser,'CYS' ,defaultValueCYS ,@isvector)
addParameter(parser,'CYU' ,defaultValueCYU ,@isvector)
addParameter(parser,'BVP' ,defaultValueBVP ,@isvector)
parse(parser,varargin{:});


% UNPACKING

SNPO = parser.Results.SNPO;
SN   = parser.Results.SN;
TR   = parser.Results.TR;
HB   = parser.Results.HB;
PD   = parser.Results.PD;
BP   = parser.Results.BP;
UZ   = parser.Results.UZ;
EQS  = parser.Results.EQS;
EQU  = parser.Results.EQU;
CYS  = parser.Results.CYS;
CYU  = parser.Results.CYU;
BVP  = parser.Results.BVP;


% BD - Ordinary Equilibrium Settings

opts.BifDiag.Eq.S          = EQS;
opts.BifDiag.Eq.U          = EQU;
%opts.BifDiag.Eq.LineWidth  = 1.5;
opts.BifDiag.Eq.LineWidth  = 1.2;
opts.BifDiag.Eq.LineStyle  = '-';
opts.BifDiag.Eq.Marker     = 'none';
opts.BifDiag.Eq.MarkerSize = 8;

% BD - Cycles Settings

opts.BifDiag.Cycle.S          = CYS;
opts.BifDiag.Cycle.U          = CYU;
%opts.BifDiag.Cycle.LineWidth  = 1.5;
opts.BifDiag.Cycle.LineWidth  = 1.2;
opts.BifDiag.Cycle.LineStyle  = '-';
opts.BifDiag.Cycle.Marker     = 'none';
opts.BifDiag.Cycle.MarkerSize = 8;

% BD - Cycles Settings

opts.BifDiag.BVP.P          = BVP;
%opts.BifDiag.BVP.LineWidth  = 1.5;
opts.BifDiag.BVP.LineWidth  = 1.2;
opts.BifDiag.BVP.LineStyle  = '-';
opts.BifDiag.BVP.Marker     = 'none';
opts.BifDiag.BVP.MarkerSize = 8;

% 2PBD - Bifurcations

opts.BifDiag.Bif.HB         = HB;
opts.BifDiag.Bif.PD         = PD;
opts.BifDiag.Bif.SNPO       = SNPO;
opts.BifDiag.Bif.SN         = SN;
opts.BifDiag.Bif.TR         = TR;
opts.BifDiag.Bif.UZ         = UZ;
opts.BifDiag.Bif.BP         = BP;
%opts.BifDiag.Bif.LineWidth = 1.5;
opts.BifDiag.Bif.LineWidth  = 1.2;
opts.BifDiag.Bif.LineStyle  = '-';
opts.BifDiag.Bif.Marker     = 'none';
opts.BifDiag.Bif.MarkerSize = 8;

% BP - Recognized

opts.Bif.Types = [ -4 ,  1 ,  2 ,  3 ,    5 ,  6 ,  7 ,  8 ];
opts.Bif.Vis   = [  1 ,  1 ,  1 ,  1 ,    1 ,  0 ,  1 ,  1 ];
opts.Bif.Names = {'UZ','BP','SN','HB','SNPO','BC','PD','TR'};

% BP - Saddle-Node

opts.Bif.SN.Marker          = 'o';
%opts.Bif.SN.MarkerSize      = 5;
opts.Bif.SN.MarkerSize      = 3;
opts.Bif.SN.Color           = SN;
opts.Bif.SN.MarkerFaceColor = SN;

% BP - Saddle-Node Periodics

opts.Bif.SNPO.Marker          = 'o';
%opts.Bif.SNPO.MarkerSize      = 5;
opts.Bif.SNPO.MarkerSize      = 3;
opts.Bif.SNPO.Color           = SNPO;
opts.Bif.SNPO.MarkerFaceColor = SNPO;

% BP - Hopf Bifurcation

opts.Bif.HB.Marker          = 's';
%opts.Bif.HB.MarkerSize      = 5;
opts.Bif.HB.MarkerSize      = 3;
opts.Bif.HB.Color           = HB;
opts.Bif.HB.MarkerFaceColor = HB;

% BP - Period Doubling

opts.Bif.PD.Marker          = '^';
%opts.Bif.PD.MarkerSize      = 5;
opts.Bif.PD.MarkerSize      = 3;
opts.Bif.PD.Color           = PD;
opts.Bif.PD.MarkerFaceColor = PD;

% BP - Torus

opts.Bif.TR.Marker          = 'diamond';
%opts.Bif.TR.MarkerSize      = 5;
opts.Bif.TR.MarkerSize      = 3;
opts.Bif.TR.Color           = TR;
opts.Bif.TR.MarkerFaceColor = TR;

% BP - Bifurcation Cycle

opts.Bif.BC.Marker          = 'hexagram';
%opts.Bif.BC.MarkerSize      = 5;
opts.Bif.BC.MarkerSize      = 3;
opts.Bif.BC.Color           = BP;
opts.Bif.BC.MarkerFaceColor = BP;

% BP - Bifurcation Point

opts.Bif.BP.Marker          = 'hexagram';
%opts.Bif.BP.MarkerSize      = 5;
opts.Bif.BP.MarkerSize      = 3;
opts.Bif.BP.Color           = BP;
opts.Bif.BP.MarkerFaceColor = BP;

% UZ - User

opts.Bif.UZ.Marker          = 'o';
%opts.Bif.UZ.MarkerSize      = 5;
opts.Bif.UZ.MarkerSize      = 3;
opts.Bif.UZ.Color           = UZ;
opts.Bif.UZ.MarkerFaceColor = UZ;

% NC 

opts.NC.C = {[255 149 5]/255,...    % x-nullcline
             [66 245 147]/255};     % y-nullcline

end