function [ ] = plot_data_YYX( Ydata1 , Ydata2, Xdata1, Ylabel1, Ylabel2, Xlabel1, figureTitle)
%PLOT_DATA_YXX
%Plots one set of Y data, vs 2 seperate sets of X data on 2 seperate graphs 
%All inputted data must be the same size
    
    figure;
    title(figureTitle);
    ylabel(strcat(Ylabel1, Ylabel2));
    xlabel(Xlabel1);
    hold on;
    plot(Xdata1, Ydata1);
    plot(Xdata1, Ydata2);
    hold off;
end

