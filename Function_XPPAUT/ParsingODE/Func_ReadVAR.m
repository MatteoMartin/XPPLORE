function V = Func_ReadVAR(fileODE)
%
%   [VS, TVS] = Func_ReadVAR(fileODE)
%
%   Function that derive the variable directly from the .ode file passed as
%   input to the function. The structure is ordered to match with the files
%   exported from XPP.
%
%   @param fileODE      :   File .ode from where to derive the variable.
%
%   @output VS          :   Structure in which each entries represent the
%                           variables involved in the model extracted from 
%                           the ODE file. The order is the same presented
%                           in the file mentioned previously.
%   @output TVS         :   Structure in which each entries represent the
%                           method with which a variable has been defined.
%
% PhD Students Martin Matteo (*') & Thomas Anna Kshita (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 12/19/2024

% REGEX - Expression (New)
regexODE1 = 'd([a-zA-Z0-9]+)\[?(\d+)?\.?\.?(\d+)?\]?/dt';
regexODE2 = '([a-zA-Z0-9]+)\[?(\d+)?\.?\.?(\d+)?\]?''';
regexAUX  = 'aux\s([a-zA-Z0-9]+)\[?(\d+)?\.?\.?(\d+)?\]?(?:\s|\s+)?=';

% REGEX - Expression (Old)
regexONLY = 'only\s[a-zA-Z0-9]+';
regexSTOV = 'markov\s[a-zA-Z0-9]+';
regexSTO  = 'markov\s';
regexMULV = '(?<=\[)[^)]*(?=\])';
regexMUL  = '[0-9]+';

% CHECKs - Keywords
checkAUX    = 'aux\s';
checkONLY   = 'only\s';
checkMARKOV = 'markov\s';

% CHECKs - Skipping conditions
checkBNDRY = 'bndry';
checkCOMM  = '#';

% File - Opening
try    fID = fopen(fileODE);
catch, error('FILE - File not found!');
end

% Variables  - Extraction
kVAR = 1; VAR{kVAR} = 't'; TVAR{kVAR} = 'T';
kVAR = 2; line = fgetl(fID);
while ischar(line)
    
    if not(contains(line,checkCOMM))

        if any(regexp(line,checkONLY,'start') == 1)
            fprintf('WARNING! - Detected: ONLY - Under development!\n')
            fprintf('         - Detected: ONLY - Skipped variables!\n')
        end

        if any(regexp(line,checkMARKOV,'start') == 1)
            fprintf('WARNING! - Detected: MARKOV - Under development!\n')
            fprintf('         - Detected: MARKOV - Skipped variables!\n')
        end
    
        % EXTRACTION - Dynamical variables
        if not(contains(line,checkBNDRY))
            if not(isempty(regexp(line,regexODE1,'once'))) || ...
                not(isempty(regexp(line,regexODE2,'once')))
                T = regexp(line,regexODE1,'tokens');
                if isempty(T), T = regexp(line,regexODE2,'tokens'); end
    
                if isempty(T{1}{2}) && isempty(T{1}{3})
                    VAR{kVAR}  = T{1}{1};
                    TVAR{kVAR} = 'D';
                    kVAR = kVAR + 1;
                else
                    for iVAR = str2double(T{1}{2}):1:(str2double(T{1}{3}))
                        VAR{kVAR}  = sprintf('%s%i',T{1}{1},iVAR);
                        TVAR{kVAR} = 'D';
                        kVAR = kVAR + 1;
                    end
                end
            end
        end
    
        % EXTRACTION - Auxialiary
        if any(regexp(line,checkAUX,'start') == 1)
            T = regexp(line,regexAUX,'tokens');
            
            if isempty(T{1}{2}) && isempty(T{1}{3})
                VAR{kVAR}  = T{1}{1};
                TVAR{kVAR} = 'A';
                kVAR = kVAR + 1;
            else
                for iVAR = str2double(T{1}{2}):1:(str2double(T{1}{3}))
                    VAR{kVAR}  = sprintf('%s%i',T{1}{1},iVAR);
                    TVAR{kVAR} = 'A';
                    kVAR = kVAR + 1;
                end
            end
        end
    end

    line = fgetl(fID);
end

% File - Closing
fclose(fID);

TVS = cell(1,size(TVAR,2));
VS  = cell(1,size(VAR,2));

nC = sum(cellfun(@(x) isequal(x,'D'), TVAR))+1;
iC = 1;
iA = 1;

for iV = 1:1:length(VAR)
    if strcmp(TVAR{iV},'A')
        jV = nC + iA;
        iA = iA + 1;
    else
        jV = iC;
        iC = iC + 1;
    end
    TVS{jV} = TVAR{iV};
    VS{jV}  = VAR{iV};
end

for iV = 1:1:length(VS)
    V.(VS{iV}) = TVS{iV};
end


end