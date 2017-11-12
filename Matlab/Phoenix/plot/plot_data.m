function [ uSecondsData ] = plot_data( data , dataLabel, firstPlotPoint, lastPlotPoint, firstPlot, totalPlots, timeScale)
%PLOT_DATA ~ Plot data gathered from flight logs
%Assumes the data takes the form of a flight log from ArduPilot, 2nd column
%is uSeconds, data starts from column 3.
    
    uSecondsData = data(firstPlotPoint:lastPlotPoint,2);
    mSecondsData = uSecondsData/1000;
    secondsData = mSecondsData/1000;
    figureColumnTotal = ceil(totalPlots/3);
    figureRowTotal = ceil(totalPlots/figureColumnTotal);

    for i = 1:totalPlots
        subplot(figureRowTotal, figureColumnTotal, i);
        title(dataLabel(i+(firstPlot-1)+2, 1));
        
        title(dataLabel(i+(firstPlot-1)+2, 1));
        hold on;
        ydata = data(firstPlotPoint:lastPlotPoint, i+2);
        
        %Plot the data after checking the specified timescale
        if timeScale == 's'|| timeScale == 'S'
            xlabel('Time (Seconds)');
            plot(secondsData, ydata);
        elseif timeScale == 'm' || timeScale == 'M'
            xlabel('Time (Milli Seconds)');
            plot(mSecondsData, ydata);
        elseif timeScale == 'u' || timeScale == 'U' 
            xlabel('Time (Micro Seconds)');
            plot(uSecondsData, ydata);
        end
        
        hold off;
        %ylim([1000 2000]);
    end
end

