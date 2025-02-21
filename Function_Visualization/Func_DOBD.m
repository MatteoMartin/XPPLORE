function opts = Func_DOBD()
%
%   opts = Func_DOBD()
%
%   This function creates the default structure containing the visalization
%   settings for the bifurcation diagrams and the bifurcation points.
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

% Colors

SNPO = [  0   0   0]/255;
SN   = [255   0   0]/255;
TR   = [  0 160 100]/255;
HB   = [  0   0 255]/255;
PD   = [255 128  80]/255;
BP   = [  0 255 255]/255;
UZ   = [  0 255 194]/255;

%SNPO = [255 149   5]/255;
%SN   = [0   255 255]/255;
%TR   = [205 130 255]/255;
%HB   = [255   0 255]/255;
%PD   = [  0   0   0]/255;
%BP   = [  0 255 255]/255;
%UZ   = [  0 255 194]/255;

% BD - Ordinary Equilibrium Settings

opts.BifDiag.OrdEq.S          = 'r';
opts.BifDiag.OrdEq.U          = 'k';
%opts.BifDiag.OrdEq.LineWidth  = 1.5;
opts.BifDiag.OrdEq.LineWidth  = 1.2;
opts.BifDiag.OrdEq.LineStyle  = '-';
opts.BifDiag.OrdEq.Marker     = 'none';
opts.BifDiag.OrdEq.MarkerSize = 8;

% BD - Cycles Settings

opts.BifDiag.Cycle.S          = 'g';
opts.BifDiag.Cycle.U          = 'b';
%opts.BifDiag.Cycle.LineWidth  = 1.5;
opts.BifDiag.Cycle.LineWidth  = 1.2;
opts.BifDiag.Cycle.LineStyle  = '-';
opts.BifDiag.Cycle.Marker     = 'none';
opts.BifDiag.Cycle.MarkerSize = 8;

% BD - Cycles Settings

opts.BifDiag.BVP.P          = 'k';
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
%opts.BifDiag.Bif.LineWidth  = 1.5;
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

% BP - Bifurcation Cycle

opts.Bif.BP.Marker          = 'hexagram';
%opts.Bif.BP.MarkerSize      = 5;
opts.Bif.BP.MarkerSize      = 3;
opts.Bif.BP.Color           = BP;
opts.Bif.BP.MarkerFaceColor = BP;

% BP - User

opts.Bif.UZ.Marker          = 'o';
%opts.Bif.UZ.MarkerSize      = 5;
opts.Bif.UZ.MarkerSize      = 3;
opts.Bif.UZ.Color           = UZ;
opts.Bif.UZ.MarkerFaceColor = UZ;

% NC 

opts.NC.C = {[255 149 5]/255,...    % x-nullcline
             [66 245 147]/255};     % y-nullcline

% Colors - Bifurcations 
%opts.C.SNPO = [255 149   5]/255;
%opts.C.SN   = [0   255 255]/255;
%opts.C.TR   = [205 130 255]/255;
%opts.C.HB   = [255   0 255]/255;
%opts.C.PD   = [  0   0   0]/255;
%opts.C.BP   = [  0 255 255]/255;
%opts.C.UZ   = [  0 255 194]/255;

end