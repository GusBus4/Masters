%% Input the .mat file file location containing a Mission Planner Flight Log
true = 1;
false = 0;
%file = 'C:\Users\GusBus\Google Drive\Masters\Design\Software\Flight Logs\PID Tune\2017-04-28 12-02-32.log-2727800.mat';
%file = 'C:\Users\GusBus\Google Drive\Masters\Design\Software\Flight Logs\PID Tune\2017-04-28 12-02-32.log-2000000.mat';
%file = 'C:\Users\GusBus\Google Drive\Masters\Flight Logs\Maiden FLight\2017-04-28 08-50-45 (Maiden Test Flight HRF).log-574744.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight logs\2017-11-01 10-59-52.log-1995833.mat';
file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight logs\crash.log-274015.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight logs\rate80stab80proc.log-333727.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight logs\2017-11-09 12-54-59.log-477460.mat';

load(file);

%% Configure Flight Analyser
plotEnable = 1;

analyseRCIN         = true;
analyseRCOUT        = true;
analyseRATE         = true;
analyseATT          = true;
analyseBARO         = true;
analyseSampleTimes  = true;

%Give start and end percentages of the data meant for analysis
startPercentage = 11;        
endPercentage = 75;        

%% Extract uSeconds values from RCIN, and calculate the start and end times,
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

mSeconds = uSeconds/1000;
Seconds = mSeconds/1000;


%% Analyse RCIN

if analyseRCIN == true
    
    firstPoint_RCIN     = get_uSecondsLocation(RCIN, uSecondsMin, uSecondsAbsMin);
    lastPoint_RCIN      = get_uSecondsLocation(RCIN, uSecondsMax, uSecondsAbsMin);

    pilot_in_useconds   = RCIN(firstPoint_RCIN:lastPoint_RCIN, 2);
    pilot_in_roll       = [pilot_in_useconds, RCIN(firstPoint_RCIN:lastPoint_RCIN, 3)];
    pilot_in_pitch      = [pilot_in_useconds, RCIN(firstPoint_RCIN:lastPoint_RCIN, 4)];
    pilot_in_throttle   = [pilot_in_useconds, RCIN(firstPoint_RCIN:lastPoint_RCIN, 5)];
    pilot_in_yaw        = [pilot_in_useconds, RCIN(firstPoint_RCIN:lastPoint_RCIN, 6)];
    
    %Plot RCIN Data
    if plotEnable == 1
    figure('Name','RCIN Values');
    plot_data(RCIN, RCIN_label, firstPoint_RCIN, lastPoint_RCIN, 1, 5, 's');
    end
end

%% Analyse RCOUT
if analyseRCOUT == true
    
    firstPoint_RCOUT     = get_uSecondsLocation(RCOU, uSecondsMin, uSecondsAbsMin);
    lastPoint_RCOUT      = get_uSecondsLocation(RCOU, uSecondsMax, uSecondsAbsMin);
    
    motor_out_useconds  = RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 2);
    motor_out_1         = [motor_out_useconds, RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 3)];
    motor_out_2         = [motor_out_useconds, RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 4)];
    motor_out_3         = [motor_out_useconds, RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 5)];
    motor_out_4         = [motor_out_useconds, RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 6)];
    
    %Plot RCOUT Data
    if plotEnable == 1
    figure('Name','RCOUT Values');
    plot_data(RCOU, RCOU_label, firstPoint_RCOUT, lastPoint_RCOUT, 1, 5, 's'); 
    end
end

%% Analyse RATE
if analyseRATE == true
    
    firstPoint_RATE         = get_uSecondsLocation(RATE, uSecondsMin, uSecondsAbsMin);
    lastPoint_RATE          = get_uSecondsLocation(RATE, uSecondsMax, uSecondsAbsMin);
    
    rate_useconds           = RATE(firstPoint_RATE:lastPoint_RATE, 2);
    rate_target_roll        = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 3)];
    rate_roll               = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 4)];
    rate_out_roll           = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 5)];
    rate_target_pitch       = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 6)];
    rate_pitch              = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 7)];
    rate_out_pitch          = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 8)];
    rate_target_yaw         = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 9)];
    rate_yaw                = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 10)];
    rate_out_yaw            = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 11)];
    rate_climb_yaw          = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 12)];
    rate_climb              = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 13)];
    rate_out_climb          = [rate_useconds, RATE(firstPoint_RATE:lastPoint_RATE, 14)];    
    
    %Plot RATE Data
    if plotEnable == 1
    figure('Name','RATE Values');
    plot_data(RATE, RATE_label, firstPoint_RATE, lastPoint_RATE, 1, 9, 's');
    end
end

%% Analyse ATT
if analyseATT == true
    
    firstPoint_ATT          = get_uSecondsLocation(ATT, uSecondsMin, uSecondsAbsMin);
    lastPoint_ATT           = get_uSecondsLocation(ATT, uSecondsMax, uSecondsAbsMin);
    
    attitude_useconds       = ATT(firstPoint_ATT:lastPoint_ATT, 2);
    attitude_target_roll    = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 3)];
    attitude_roll           = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 4)];
    attitude_target_pitch   = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 5)];
    attitude_pitch          = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 6)];
    attitude_target_yaw     = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 7)];
    attitude_yaw            = [attitude_useconds, ATT(firstPoint_ATT:lastPoint_ATT, 8)];
    
    %Plot ATT Data
    if plotEnable == 1
    figure('Name','ATT Values');
    plot_data(ATT, ATT_label, firstPoint_ATT, lastPoint_ATT, 1, 6, 's');
    end
end

%% Analyse BARO
if analyseBARO == true

    firstPoint_BARO         = get_uSecondsLocation(BARO, uSecondsMin, uSecondsAbsMin);
    lastPoint_BARO          = get_uSecondsLocation(BARO, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = BARO(firstPoint_BARO:lastPoint_BARO, 2);
    altitude                = [altitude_useconds, BARO(firstPoint_BARO:lastPoint_BARO, 3)];

    %Plot Altitude Data
    if plotEnable == 1
    figure('Name','Altitude Value');
    plot_data(BARO, BARO_label, firstPoint_BARO, lastPoint_BARO, 1, 1, 's');
    end
end

%% Analyse the time between data points
if analyseSampleTimes == true
    %RCIN
    if analyseRCIN == true
        deltaSamplesTime_us_RCIN            = get_dataDelta(RCIN(firstPoint_RCIN:lastPoint_RCIN, 2));
        deltaSampleTime_lineNumber_RCIN     = deltaSamplesTime_us_RCIN(:,1);
        deltaSampleTime_us_RCIN             = deltaSamplesTime_us_RCIN(:,2);
        deltaSampleTime_ms_RCIN             = deltaSampleTime_us_RCIN/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RCIN, deltaSampleTime_lineNumber_RCIN, (RCIN(firstPoint_RCIN:lastPoint_RCIN, 2))/1000,'Time Between RCIN Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RCIN Sample Times')   %Plot the Variations in sample frequency 
        end
    end
    
    %RCOUT
    if analyseRCOUT == true
        deltaSamplesTime_us_RCOUT           = get_dataDelta(RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 2));
        deltaSampleTime_lineNumber_RCOUT    = deltaSamplesTime_us_RCOUT(:,1);
        deltaSampleTime_us_RCOUT            = deltaSamplesTime_us_RCOUT(:,2);
        deltaSampleTime_ms_RCOUT            = deltaSampleTime_us_RCOUT/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RCOUT, deltaSampleTime_lineNumber_RCOUT, (RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 2))/1000,'Time Between RCOUT Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RCOUT Sample Times')   %Plot the Variations in sample frequency
        end
    end
    
    %RATE
    if analyseRATE == true
        deltaSamplesTime_us_RATE            = get_dataDelta(RATE(firstPoint_RATE:lastPoint_RATE, 2));
        deltaSampleTime_lineNumber_RATE     = deltaSamplesTime_us_RATE(:,1);
        deltaSampleTime_us_RATE             = deltaSamplesTime_us_RATE(:,2);
        deltaSampleTime_ms_RATE             = deltaSampleTime_us_RATE/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RATE, deltaSampleTime_lineNumber_RATE, (RATE(firstPoint_RATE:lastPoint_RATE, 2))/1000,'Time Between RATE Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RATE Sample Times')   %Plot the Variations in sample frequency
        end
    end
    
    %ATT
    if analyseATT == true
        deltaSamplesTime_us_ATT             = get_dataDelta(ATT(firstPoint_ATT:lastPoint_ATT, 2));
        deltaSampleTime_lineNumber_ATT      = deltaSamplesTime_us_ATT(:,1);
        deltaSampleTime_us_ATT              = deltaSamplesTime_us_ATT(:,2);
        deltaSampleTime_ms_ATT              = deltaSampleTime_us_ATT/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_ATT, deltaSampleTime_lineNumber_ATT, (ATT(firstPoint_ATT:lastPoint_ATT, 2))/1000,'Time Between ATT Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta ATT Sample Times')   %Plot the Variations in sample frequency
        end
    end
    
end


%% Final Message Box
msgbox(...
{   sprintf('Imported data from: %s', file)...
    ,sprintf('Printed %d%%  - %d%%', startPercentage, endPercentage)...
    ,sprintf('First Data Point Time %i s - %i s Last Data Point Time ', round(uSecondsMin/1000000.0) ,round(uSecondsMax/1000000.0))...
}...
,'Success!!'); 