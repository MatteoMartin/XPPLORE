function SETTINGV = Func_ReadSettings(fileODE)
%
%   SETTINGV = Func_ReadSettings(fileODE)
%
%   Function to read the settings specified inside an ODE file.
%
%   @param fileODE   :  ODE file name.
%
%   @output SETTINGV :  Settings structure.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 11/26/2024

% File - Opening
try    fID = fopen(fileODE);
catch, error('FILE - File not found!') 
end

% File - String to Detect
regexSettings          = '@';
regexSettingsSeparator = ',';
regexComment           = '#';
regexSet               = 'set';


% Parameters - Extraction
line = fgetl(fID); SETTINGV = struct(); kSET = 1;
while ischar(line)
    if ~contains(line, regexComment)
        if contains(line,regexSettings)
            line = replace(line,' ','');
            line = replace(line,regexSettings,'');
            if contains(line(1:4),regexSet)
                continue;
            end
            if contains(line,regexSettingsSeparator)
                splitLine = split(line,',');
                splitLine = split(splitLine,'=');
                for iS = 1:1:length(splitLine)
                    SETTINGV.(splitLine{iS,1}) = splitLine{iS,2};
                    kSET = kSET + 1;
                end
            else
                splitLine = split(line,'=');
                SETTINGV.(splitLine{1}) = splitLine{2};
                kSET = kSET + 1;
            end
        end
    end

    line = fgetl(fID);
end


end