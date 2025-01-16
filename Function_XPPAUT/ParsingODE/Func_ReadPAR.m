function P = Func_ReadPAR(fileODE)
%
%   P = Func_ReadPAR(fileODE)
%
%   Function that retrive the whole set of parameters from the .ode file
%   specified as input parameter to this function.
%
%   @param fileODE      :   File .ode from which derive the model's
%                           parameters.
%
%   @output P           :   Parameters' structure. Each field is structure
%                           containing a given parameter (P1,...PN).
%                           The field of each structure are the following,
%                           -   N:  Parameter's name
%                           -   V:  Parameter's value
%
% PhD Students Martin Matteo (*') & Thomas Anna Kshita (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 10/11/2024

% REGEX - Expression
regexPAR  = '(params|param|par|p) [a-zA-Z0-9]+';
regexOTH  = '(#|init|@)';

% File - Opening
try    fID = fopen(fileODE);
catch, error('FILE - File not found!') 
end

% Parameters - Extraction
kPAR = 1; line = fgetl(fID);
while ischar(line)

    if isempty(regexp(line,regexOTH,'start'))
        if not(isempty(regexp(line,regexPAR,'once')))
            I = strfind(line,' '); 
            I = I(1);
            line = line(I:end);
            
            I  = strfind(line,'=');
            nI = length(I);
            nL = length(line);

            for iI = 1:1:nI
                isChar = false;
                if iI == 1, S = 1; else, S = I(iI-1); end
                for jI = I(iI)-1:-1:S
                    if not(isChar) && strcmp(line(jI),' '), continue
                    else, isChar = true;
                    end

                    if strcmp(line(jI),' ') || strcmp(line(jI),','), break, end
                end
                N = replace(line(jI+1:I(iI)-1),' ','');

                isChar = false;
                if iI == nI, S = nL; else, S = I(iI+1); end
                for jI = I(iI)+1:1:S
                    if not(isChar) && strcmp(line(jI),' '), continue
                    else, isChar = true;
                    end

                    if strcmp(line(jI),' ') || strcmp(line(jI),','), break, end
                end
                if jI ~= nL, jI = jI - 1; end
                V = str2double(replace(line(I(iI)+1:jI),' ',''));
                
                P.(N) = V;
                kPAR  = kPAR + 1;
            end
        end
    end

    line = fgetl(fID);
end

P.nP = kPAR-1;

% File - Close
fclose(fID);


end