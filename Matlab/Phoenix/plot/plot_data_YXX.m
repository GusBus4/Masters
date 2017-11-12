function [ ] = plot_data_YXX( Ydata , Xdata1, Xdata2, Ylabel, Xlabel1, Xlabel2, figureTitle)
%PLOT_DATA_YXX
%Plots one set of Y data, vs 2 seperate sets of X data on 2 seperate graphs 
%All inputted data must be the same size
    
    figure;
    subplot(2, 1, 1);
    title(figureTitle)
    xlabel(Xlabel1)
    ylabel(Ylabel)
    hold on;
    %Plot the time between samples, and the line number of the sample.
    plot(Xdata1, Ydata, '.');        %Delta Time
    %ylim([0 200]);     %0 - 200ms
    hold off;
    
    subplot(2, 1, 2);
    xlabel(Xlabel2)
    ylabel(Ylabel)
    hold on;
    %Plot the time between samples, and the time the samples were taken.
    plot(Xdata2, Ydata);                     %Delta Time
    %ylim([0 200]);     %0 - 200ms
    hold off;
end

