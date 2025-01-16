function NC = Func_ReadNullclines(fNC)
%
%   NC = Func_ReadNullclines(fNC)
%
%   Function to read the nullclines exported in the fNC file.
%   The name of the file fNC must be of the format [text]_x_y.dat.
%   Where x/y is the name of the variable along the x/y-axis.
%
%   @param fNC  :  Name of the nullclines file.
%
%
% PhD Students Martin Matteo (*') & Thomas Anna Kishida (+')
%
% (*) University of Padova
% (+) University of Pittsburgh
% (') Both authors contributed equally to the work.
%
% Last Update - 01/08/2025


% FILE - Retrieval

L = strrep(fNC,'.dat','');
L = split(L,'_');
VAR.x = L{2};
VAR.y = L{3};


% INITIALIZATIONs

i = 0;
P = zeros(2,2);
fTX = true; 
fTY = true;


% INITIALIZATION - Structure NC

NC = struct((sprintf('NC%s',VAR.x)),struct(),(sprintf('NC%s',VAR.y)),struct());


% FILE - Opening

f = fopen(fNC,'r');


% FILE - Parsing

while not(feof(f))
    L = fgetl(f);
    L = split(L,' ');
    L = L(not(cellfun('isempty', L)));
    
    % POPULATION - Structure NC
    if length(L) == 3
        i = i + 1;
        L = cellfun(@str2double, L);
        P(i,:) = L(1:2)';

        if fTX && L(3) == 1
            j = 0; LAB = VAR.x; fTX = false;
        elseif fTY && L(3) == 2
            j = 0; LAB = VAR.y; fTY = false;
        end

        if i == 2
            i = 0; j = j + 1;
            NC.(sprintf('NC%s',LAB)).(sprintf('PT%i',j)) = P;
        end     
    end
end


%  UPDATE - Structure NC
NC.(sprintf('NC%s',VAR.x)).nPT = length(fieldnames(NC.(sprintf('NC%s',VAR.x))));
NC.(sprintf('NC%s',VAR.y)).nPT = length(fieldnames(NC.(sprintf('NC%s',VAR.y))));


% FILE - Closing

fclose(f);

end