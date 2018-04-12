function [  ] = plot_wall( xstart, ystart, zstart, xend, yend, zend )
%PLOT_WALL ~ Plot a wall
%Assumes the data takes the form of a flight log from ArduPilot, 2nd column
%is uSeconds, data starts from column 3.\\\

%   We want to ensure that the step size leaves no gap between plots for
%   the wall. 
%
%
%
%

xsize = xend - xstart;
ysize = yend - ystart;
zsize = zend - zstart;

maxSize = max([xsize, ysize, zsize]);

numberofsteps = 10;                         %Plot Every 0.1m

xStep = xsize/numberofsteps;
yStep = ysize/numberofsteps;
zStep = zsize/numberofsteps;

for i = 1:numberofsteps+1
    wallx(i) = xstart + (i-1)*xStep;
    wally(i) = ystart + (i-1)*yStep;
    wallz(i) = zstart + (i-1)*zStep;
end

%     wallx = [10, 10, 10, 10, 10];
%     wally = [0, 1, 2, 3, 10];
%     wallz = [0, 2, 4, 6, 8];

wall = [wallx; wally; wallz]

xindex = 1;
yindex = 1;
zindex = 1;





% plot3(wally, wallx, plotwallz, 'c', 'LineWidth', 1);

hold on;
view(3)
% Let's build up from the bottom, i.e plot it by XY layer
for i = 0:xStep:xsize
    for j = 0:yStep:ysize
        for a = 1:numberofsteps+1
            plotwally(a) = wally(1, yindex);
        end        
        for k = 0:zStep:zsize
            for a = 1:numberofsteps+1
                plotwallz(a) = wallz(1, zindex);
            end
            plot3(plotwally, wallx, plotwallz, 'r', 'LineWidth', 1);
            zindex = zindex + 1;   
        end
        zindex = 1;
        yindex = yindex + 1;
    end
    yindex = 1;
    xindex = xindex + 1;
end
grid on;
xlim([-20 20]);
ylim([-20 20]);
zlim([-1 20]);
hold off;
 

