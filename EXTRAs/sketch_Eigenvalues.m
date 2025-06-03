f = @(x,y) x.^2 + y.^2 - 1;
C = fimplicit(f,[-1.5 1.5 -1.5 1.5]);
Y = C.XData;
Z = C.YData;
close all;

%% 

FBR  = fieldnames(AR.BD1_i0.BR);
nFBR = length(FBR);

fig = figure();

minBR = 5;
maxBR = 12;

for iBR = minBR:1:maxBR%12%nFBR-1

    nP   = max(size(Y));
    nBRP = length(AR.BD1_i0.BR.(FBR{iBR}).i0);
    if nBRP ~= 1
        CYLINDER.i0 = repmat(AR.BD1_i0.BR.(FBR{iBR}).i0',[nP,1]);
        CYLINDER.I  = repmat(Z',[1,nBRP]);
        CYLINDER.R  = repmat(Y',[1,nBRP]);
        
        for i = 1:1:4
            hold on
            plot3(AR.BD1_i0.BR.(FBR{iBR}).i0,AR.BD1_i0.BR.(FBR{iBR}).EigR(:,i),AR.BD1_i0.BR.(FBR{iBR}).EigI(:,i),'LineWidth',1.2,'Color','b');
            hold off
        end
        
        hold on
        surf(CYLINDER.i0,CYLINDER.I,CYLINDER.R,'FaceColor','b','FaceAlpha',0.2,'EdgeColor','none')
        hold off
        
        F  = fieldnames(AR.BD1_i0.LABPTs);
        nF = length(F);
        for iF = 1:1:nF-1
            if ~contains(F{iF},'EP') && AR.BD1_i0.LABPTs.(F{iF}).BR == (iBR - 1)
                
                for i = 1:1:4
                    hold on
                    plot3(AR.BD1_i0.LABPTs.(F{iF}).i0,AR.BD1_i0.LABPTs.(F{iF}).EigR(:,i),AR.BD1_i0.LABPTs.(F{iF}).EigI(:,i),'Marker','o','MarkerFaceColor','r','MarkerSize',10)
                    hold off
                end
            end
        end
    end
    
end

xlim([min(AR.BD1_i0.BR.(FBR{minBR}).i0) max(AR.BD1_i0.BR.(FBR{maxBR}).i0)])
ylim([-1.5 1.5])
zlim([-1.5 1.5])