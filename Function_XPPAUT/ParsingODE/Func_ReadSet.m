function PARV = Func_ReadSet(fileSET, PAR)
% 
%   PARV = Func_ReadSet(fileSET, PAR)
%
%   Function which returns the file name, the information regarding the
%   current simulation as instance the model parameters.
%
%   @param fileSET .set file name from which extract information over the
%                   parameters stored in PAR.
%   @param PAR      Parameter cell array. Each element of this cell array 
%                   contains the name of the parameters of the investigated
%                   .ode file.
%
%   @param PARV     Parameter cell array. Each cell is now a two-fields
%                   structure. These are .p and .v. The former stores the
%                   parameter name, instead .v its value.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

% File - Opening
try    fID = fopen(fileSET);
catch, error('FILE - File not found!') 
end

% File - String to Detect
regexParameters = '(# Parameters)';
regexClosingSec = '(#)';

% Parameters - Extraction
line = fgetl(fID); PARV = {}; kPAR = 1;
while ischar(line)

    if regexp(line,regexParameters,'once')
        line = fgetl(fID);
        while isempty(regexp(line,regexClosingSec,'start'))
            strings = split(line,' ');
            PARV{kPAR}.v = str2double(strings{1});
            PARV{kPAR}.s = strings{end};
            kPAR = kPAR + 1;
            line = fgetl(fID);
        end
    end

    line = fgetl(fID);
end

% Parameters - Check
nP  = length(PAR);
nPV = length(PARV);
cP  = 0;
for iP = 1:1:nP
    for jP = 1:1:nPV
        if strcmp(PARV{jP}.s, PAR{iP})
            cP = cP + 1;
            break
        end
    end
end

% Parameters - Raising Error
if not((cP == nP) && (nPV == nP))
    fprintf('ERROR! - Unmatching Parameters!')
end

% File - Close
fclose(fID);

end
