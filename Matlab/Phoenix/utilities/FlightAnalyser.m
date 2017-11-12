% close all;
% clear all;
%input the .mat file file location containing a Mission Planner Flight Log

%file = 'C:\Users\GusBus\Google Drive\Masters\Design\Software\Flight Logs\PID Tune\2017-04-28 12-02-32.log-2727800.mat';
%file = 'C:\Users\GusBus\Google Drive\Masters\Design\Software\Flight Logs\PID Tune\2017-04-28 12-02-32.log-2000000.mat';
%  file = 'C:\Users\GusBus\Google Drive\Masters\Flight Logs\Maiden FLight\2017-04-28 08-50-45 (Maiden Test Flight HRF).log-574744.mat';
% file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\files\2017-11-01 10-59-52.log-1995833.mat';
%  file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\files\crash.log-274015.mat';
% file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\files\rate80stab80proc.log-333727.mat';
file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\files\2017-11-09 12-54-59.log-477460.mat';


load(file);

plotEnable = 1;

%Give start and end percentages of the data meant for analysis
startPercentage = 72.21;        
endPercentage = 98;        

%Extract uSeconds values from RCIN, and calculate the start and end times,
%as well as the length
uSeconds = RCIN(:,2);
uSecondsAbsMin = uSeconds(1); 
uSeconds = uSeconds(:) - uSecondsAbsMin;       %Set the first data point as zero time

if startPercentage == 0
    firstPoint = 1;
    lastPoint = round((endPercentage/100.0)*length(RCIN), 0);
else
    firstPoint = round((startPercentage/100.0)*length(RCIN), 0);
    lastPoint = round((endPercentage/100.0)*length(RCIN), 0);
end

uSecondsMin = uSeconds(firstPoint); 
uSecondsMax = uSeconds(lastPoint);
uSecondsLength = uSecondsMax - uSecondsMin;

mSeconds = uSeconds/1000;

%Plot RCIN Data
 firstPlotPoint_RCIN = get_uSecondsLocation(RCIN, uSecondsMin, uSecondsAbsMin);
 lastPlotPoint_RCIN = get_uSecondsLocation(RCIN, uSecondsMax, uSecondsAbsMin);
%  lastPlotPoint_RCIN = 504;
 
 if plotEnable == 1
    figure('Name','RCIN Values');
    plot_data(RCIN, RCIN_label, firstPlotPoint_RCIN, lastPlotPoint_RCIN, 1, 5, 's');
 end
 
%Plot RCOUT Data
 firstPlotPoint_RCOU = get_uSecondsLocation(RCOU, uSecondsMin, uSecondsAbsMin);
 lastPlotPoint_RCOU = get_uSecondsLocation(RCOU, uSecondsMax, uSecondsAbsMin);

 if plotEnable == 1
    figure('Name','RCOUT Values');
    plot_data(RCOU, RCOU_label, firstPlotPoint_RCOU, lastPlotPoint_RCOU, 1, 5, 's'); 
 end

 %Plot ATT Data
 firstPlotPoint_ATT = get_uSecondsLocation(ATT, uSecondsMin, uSecondsAbsMin);
 lastPlotPoint_ATT = get_uSecondsLocation(ATT, uSecondsMax, uSecondsAbsMin);
 
 if plotEnable == 1
    figure('Name','ATT Values');
    plot_data(ATT, ATT_label, firstPlotPoint_ATT, lastPlotPoint_ATT, 1, 6, 's');
 end
 
%Plot Altitude Data
 firstPlotPoint_BARO = get_uSecondsLocation(BARO, uSecondsMin, uSecondsAbsMin);
 lastPlotPoint_BARO = get_uSecondsLocation(BARO, uSecondsMax, uSecondsAbsMin);
 lastPlotPoint_BARO = 504;
 
 if plotEnable == 1
    figure('Name','Altitude Value');
    plot_data(BARO, BARO_label, firstPlotPoint_BARO, 5, 1, 1, 'm');
 end

%Analyse the time between data points
deltaSamplesTime_us_RCIN = get_dataDelta(RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN, 2));
deltaSampleTime_lineNumber_RCIN = deltaSamplesTime_us_RCIN(:,1);
deltaSampleTime_us_RCIN = deltaSamplesTime_us_RCIN(:,2);
deltaSampleTime_ms_RCIN = deltaSampleTime_us_RCIN/1000;

if plotEnable == 1
    plot_data_YXX(deltaSampleTime_ms_RCIN, deltaSampleTime_lineNumber_RCIN, (RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN, 2))/1000,'Time Between RCIN Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RCIN Sample Times')   %Plot the Variations in sample frequency 
end

deltaSamplesTime_us_ATT = get_dataDelta(ATT(firstPlotPoint_ATT:lastPlotPoint_ATT, 2));
deltaSampleTime_lineNumber_ATT = deltaSamplesTime_us_ATT(:,1);
deltaSampleTime_us_ATT = deltaSamplesTime_us_ATT(:,2);
deltaSampleTime_ms_ATT = deltaSampleTime_us_ATT/1000;

if plotEnable == 1
    plot_data_YXX(deltaSampleTime_ms_ATT, deltaSampleTime_lineNumber_ATT, (ATT(firstPlotPoint_ATT:lastPlotPoint_ATT, 2))/1000,'Time Between ATT Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta ATT Sample Times')   %Plot the Variations in sample frequency
end





%% Plot certain data together
rollChannelIn = RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN,3);
pitchChannelIn = RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN,4);
throttleChannelIn = RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN,5);
yawChannelIn = RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN,6);
uSeconds_RCIN = RCIN(firstPlotPoint_RCIN:lastPlotPoint_RCIN,2);
%
uSeconds_RCIN=uSeconds_RCIN-min(uSeconds_RCIN);


rollAngle = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,4);
pitchAngle = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,6);
yawAngle = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,8);
rollAngleDesired = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,3);
pitchAngleDesired = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,5);
yawAngleDesired = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,7);
uSeconds_ATT = ATT(firstPlotPoint_ATT:lastPlotPoint_ATT,2);

%
uSeconds_ATT = uSeconds_ATT-min(uSeconds_ATT);

altitude = AHR2(firstPlotPoint_BARO:lastPlotPoint_BARO,6);
uSeconds_AHR2 = AHR2(firstPlotPoint_BARO:lastPlotPoint_BARO,6);

%
uSeconds_AHR2 = uSeconds_AHR2-min(uSeconds_AHR2);


%% not implemented

motorOut1 = RCOU(firstPlotPoint_RCOU:lastPlotPoint_RCOU, 3);
motorOut2 = RCOU(firstPlotPoint_RCOU:lastPlotPoint_RCOU, 4);
motorOut3 = RCOU(firstPlotPoint_RCOU:lastPlotPoint_RCOU, 5);
motorOut4 = RCOU(firstPlotPoint_RCOU:lastPlotPoint_RCOU, 6);
uSeconds_RCOU = RCOU(firstPlotPoint_RCOU:lastPlotPoint_RCOU, 2);

%
uSeconds_RCOU = uSeconds_RCOU-min(uSeconds_RCOU);

if plotEnable == 2
    figure;
    hold on;
    title('RCIN Values vs Angle');
    plotyy(uSeconds_RCIN, -rollChannelIn, uSeconds_ATT-100000, rollAngle);
    legend('Roll Input', 'Roll Angle');
    hold off;
    
    figure;
    hold on;
    title('RCIN Values vs Angle');
    plotyy(uSeconds_RCIN, -pitchChannelIn, uSeconds_ATT-100000, pitchAngle);
    legend('Pitch Input', 'Pitch Angle');
    hold off;
    
%     figure;
%     hold on;
%     title('RCIN Values vs Angle');
%     plotyy(uSeconds_RCIN, yawChannelIn, uSeconds_ATT, yawAngle);
%     legend('Yaw Input', 'Yaw Angle');
%     hold off;
    
    figure;
    hold on;
    title('Desired Roll Angle vs Angle');
    plotyy(uSeconds_ATT, rollAngleDesired, uSeconds_ATT, rollAngle);
    legend('Desired Roll Angle', 'Roll Angle');
    hold off;
    
    figure;
    hold on;
    title('Desired Pitch Angle vs Angle');
    plotyy(uSeconds_ATT, pitchAngleDesired, uSeconds_ATT, pitchAngle);
    %plot(uSeconds_ATT, pitchAngleDesired-pitchAngle, 'Color',[0,0.9,0.9]);
    %errorbar(pitchAngleDesired, pitchAngle);
    %legend('Desired Pitch', 'Pitch Error', 'Pitch Angle');
    legend('Desired Pitch Angle', 'Pitch Angle');
    %legend('Pitch Error');
    hold off;
    
    figure;
    hold on;
    title('Desired Yaw Angle vs Angle');
    
    plot(uSeconds_ATT, yawAngleDesired);
    plot(uSeconds_ATT, yawAngle);
    plotyy(uSeconds_ATT, yawAngleDesired, uSeconds_ATT, yawAngle);
    
    
    legend('Desired Yaw Angle', 'Yaw Angle');
    hold off;
%     figure;
%     hold on;
%     title('Throttle rcin values vs Altitude');
%     plotyy(uSeconds_RCIN, throttleChannelIn, uSeconds_AHR2, altitude);
%     legend('Throttle Input', 'Altitude');
%     hold off;
end

%Add in Proper Drone 3 Frame here
%
%   3    1
%    \2a/
%     \/
%     /\
%    /  \
%   2    4
%Calculate moments
alpha = 12;


%Calculate minute and seconds values for printing to screen
plotTimeMinutesDec = math_uSeconds_minutes(uSecondsLength);         %Convert uSeconds value to a decimal minutes value
plotTimeSecondsDec = plotTimeMinutesDec - floor(plotTimeMinutesDec); %Convert the fraction to a decimal seconds value
plotTimeMinutes = floor(plotTimeMinutesDec);
plotTimeSeconds = round(plotTimeSecondsDec*60);

%Final Message Box
msgbox(...
{   sprintf('Imported data from: %s', file)...
    ,sprintf('Printed %d%%  - %d%%', startPercentage, endPercentage)...
    ,sprintf('Plot Length %d minutes, %d seconds',plotTimeMinutes,plotTimeSeconds)...
    ,sprintf('First Data Point Time %i s - %i s Last Data Point Time ', round(uSecondsMin/1000000.0) ,round(uSecondsMax/1000000.0))...
}...
,'Success!!'); 