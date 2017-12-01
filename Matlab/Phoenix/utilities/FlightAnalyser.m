clear all;
close all;
clc;
%% Input the .mat file file location containing a Mission Planner Flight Log
true = 1;
false = 0;
%file = 'C:\Users\GusBus\Google Drive\Masters\Design\Software\Flight Logs\PID Tune\2017-04-28 12-02-32.log-2000000.mat';
file = 'C:\Users\GusBus\Google Drive\Masters\Flight Logs\Maiden FLight\2017-04-28 08-50-45 (Maiden Test Flight HRF).log-574744.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-01 10-59-52.log-1995833.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\crash.log-274015.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\rate80stab80proc.log-333727.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-09 12-54-59.log-477460.mat';
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\flights2811_MIAS_magnetometer.log-317729.mat';    %(30 - 80)
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-28 19-12-50.log-322417.mat'; %(6 - 55)
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-28 19-19-23.log-1133849.mat'; %(6.2 - 24)
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-28 19-30-40.log-1135884.mat'; %Crash
%file = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_logs\2017-11-28 19-49-55.log-80196.mat';

load(file);

%Give start and end percentages of the data meant for analysis
startPercentage = 1;        
endPercentage = 100; 

%% Configure Flight Analyser
plotEnable = true;
saveEnable = true;
makeFolder = true;

saveFolder = 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_graphs\MaidenFlight';

if makeFolder == true
    mkdir 'C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\flight_graphs\MaidenFlight';
end

analyseRCIN         = true;
analyseRCOUT        = true;
analyseRATE         = true;
analyseATT          = true;
analyseBARO         = true;
analyseVIBE         = true;

analyseSensors      = true;
analyseMAG          = analyseSensors;
analyseMAG2         = analyseSensors;
analyseGYR1         = analyseSensors;
analyseGYR2         = analyseSensors;
analyseIMU          = false;
analyseIMU2         = false;

analyseEKF1         = true;
analyseEKF2         = false;
analyseEKF3         = false;
analyseEKF4         = false;

analyseSampleTimes  = false;       

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
        plot_data(RCIN, RCIN_label, firstPoint_RCIN, lastPoint_RCIN, 1, 5, 's', 'RCIN');
        if saveEnable == 1
            saveName = [saveFolder, '\RCIN.fig'];
            saveas(gcf, saveName);
%             saveas(gcf, saveName, 'jpg')
        end
    end
    
    %RCIN
    if analyseSampleTimes == true
        deltaSamplesTime_us_RCIN            = get_dataDelta(RCIN(firstPoint_RCIN:lastPoint_RCIN, 2));
        deltaSampleTime_lineNumber_RCIN     = deltaSamplesTime_us_RCIN(:,1);
        deltaSampleTime_us_RCIN             = deltaSamplesTime_us_RCIN(:,2);
        deltaSampleTime_ms_RCIN             = deltaSampleTime_us_RCIN/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RCIN, deltaSampleTime_lineNumber_RCIN, (RCIN(firstPoint_RCIN:lastPoint_RCIN, 2))/1000,'Time Between RCIN Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RCIN Sample Times')   %Plot the Variations in sample frequency 
        end
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
    plot_data(RCOU, RCOU_label, firstPoint_RCOUT, lastPoint_RCOUT, 1, 5, 's', 'RCOUT');
    if saveEnable == 1
            saveName = [saveFolder, '\RCOUT.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\RCOUT.jpg'];
            saveas(gcf, saveName)
    end
    end
    
    %RCOUT
    if analyseSampleTimes == true
        deltaSamplesTime_us_RCOUT           = get_dataDelta(RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 2));
        deltaSampleTime_lineNumber_RCOUT    = deltaSamplesTime_us_RCOUT(:,1);
        deltaSampleTime_us_RCOUT            = deltaSamplesTime_us_RCOUT(:,2);
        deltaSampleTime_ms_RCOUT            = deltaSampleTime_us_RCOUT/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RCOUT, deltaSampleTime_lineNumber_RCOUT, (RCOU(firstPoint_RCOUT:lastPoint_RCOUT, 2))/1000,'Time Between RCOUT Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RCOUT Sample Times')   %Plot the Variations in sample frequency
        end
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
    plot_data(RATE, RATE_label, firstPoint_RATE, lastPoint_RATE, 1, 9, 's', 'RATE');
    if saveEnable == 1
            saveName = [saveFolder, '\RATE.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\RATE.jpg'];
            saveas(gcf, saveName)
    end
    end
    
    %RATE
    if analyseSampleTimes == true
        deltaSamplesTime_us_RATE            = get_dataDelta(RATE(firstPoint_RATE:lastPoint_RATE, 2));
        deltaSampleTime_lineNumber_RATE     = deltaSamplesTime_us_RATE(:,1);
        deltaSampleTime_us_RATE             = deltaSamplesTime_us_RATE(:,2);
        deltaSampleTime_ms_RATE             = deltaSampleTime_us_RATE/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_RATE, deltaSampleTime_lineNumber_RATE, (RATE(firstPoint_RATE:lastPoint_RATE, 2))/1000,'Time Between RATE Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta RATE Sample Times')   %Plot the Variations in sample frequency
        end
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
    plot_data(ATT, ATT_label, firstPoint_ATT, lastPoint_ATT, 1, 6, 's', 'ATT');
    if saveEnable == 1
            saveName = [saveFolder, '\ATT.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\ATT.jpg'];
            saveas(gcf, saveName)
    end
    end
    
    %ATT
    if analyseSampleTimes == true
        deltaSamplesTime_us_ATT             = get_dataDelta(ATT(firstPoint_ATT:lastPoint_ATT, 2));
        deltaSampleTime_lineNumber_ATT      = deltaSamplesTime_us_ATT(:,1);
        deltaSampleTime_us_ATT              = deltaSamplesTime_us_ATT(:,2);
        deltaSampleTime_ms_ATT              = deltaSampleTime_us_ATT/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_ATT, deltaSampleTime_lineNumber_ATT, (ATT(firstPoint_ATT:lastPoint_ATT, 2))/1000,'Time Between ATT Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta ATT Sample Times')   %Plot the Variations in sample frequency
        end
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
    plot_data(BARO, BARO_label, firstPoint_BARO, lastPoint_BARO, 1, 1, 's', 'Altitude');
    if saveEnable == 1
            saveName = [saveFolder, '\ALT.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\ALT.jpg'];
            saveas(gcf, saveName)
    end
    end
end

%% Analyse VIBE
if analyseVIBE == true

    firstPoint_VIBE         = get_uSecondsLocation(VIBE, uSecondsMin, uSecondsAbsMin);
    lastPoint_VIBE          = get_uSecondsLocation(VIBE, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = VIBE(firstPoint_VIBE:lastPoint_VIBE, 2);
    altitude                = [altitude_useconds, VIBE(firstPoint_VIBE:lastPoint_VIBE, 3)];

    %Plot Vibration Data
    if plotEnable == 1
    figure('Name','Vibration Value');
    plot_data(VIBE, VIBE_label, firstPoint_VIBE, lastPoint_VIBE, 1, 3, 's', 'Vibration');
    if saveEnable == 1
            saveName = [saveFolder, '\VIBE.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\VIBE.jpg'];
            saveas(gcf, saveName)
    end
    end
    
    %Sample Times
    if analyseSampleTimes == true
        deltaSamplesTime_us_VIBE            = get_dataDelta(VIBE(firstPoint_VIBE:lastPoint_VIBE, 2));
        deltaSampleTime_lineNumber_VIBE     = deltaSamplesTime_us_VIBE(:,1);
        deltaSampleTime_us_VIBE             = deltaSamplesTime_us_VIBE(:,2);
        deltaSampleTime_ms_VIBE             = deltaSampleTime_us_VIBE/1000;

        if plotEnable == 1
        plot_data_YXX(deltaSampleTime_ms_VIBE, deltaSampleTime_lineNumber_VIBE, (VIBE(firstPoint_VIBE:lastPoint_VIBE, 2))/1000,'Time Between VIBE Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta VIBE Sample Times')   %Plot the Variations in sample frequency 
        end
    end
end

%% Analyse MAG
if analyseMAG == true

    firstPoint_MAG         = get_uSecondsLocation(MAG, uSecondsMin, uSecondsAbsMin);
    lastPoint_MAG          = get_uSecondsLocation(MAG, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = MAG(firstPoint_MAG:lastPoint_MAG, 2);
    altitude                = [altitude_useconds, MAG(firstPoint_MAG:lastPoint_MAG, 3)];

    %Plot Magnetometer Data
    if plotEnable == 1
    figure('Name','Magnetometer Values');
    plot_data(MAG, MAG_label, firstPoint_MAG, lastPoint_MAG, 1, 3, 's', 'MAG');
    if saveEnable == 1
            saveName = [saveFolder, '\MAG.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\MAG.jpg'];
            saveas(gcf, saveName)
    end
    figure('Name','Magnetometer Healht');
    plot_data(MAG, MAG_label, firstPoint_MAG, lastPoint_MAG, 10, 1, 's', 'MAG');
    end
    
    if analyseSampleTimes == true
    deltaSamplesTime_us_MAG             = get_dataDelta(MAG(firstPoint_MAG:lastPoint_MAG, 2));
    deltaSampleTime_lineNumber_MAG      = deltaSamplesTime_us_MAG(:,1);
    deltaSampleTime_us_MAG              = deltaSamplesTime_us_MAG(:,2);
    deltaSampleTime_ms_MAG              = deltaSampleTime_us_MAG/1000;

    if plotEnable == 1
    plot_data_YXX(deltaSampleTime_ms_MAG, deltaSampleTime_lineNumber_MAG, (MAG(firstPoint_MAG:lastPoint_MAG, 2))/1000,'Time Between MAG Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta MAG Sample Times')   %Plot the Variations in sample frequency
    end
    end
end

%% Analyse MAG2
if analyseMAG2 == true

    firstPoint_MAG2         = get_uSecondsLocation(MAG2, uSecondsMin, uSecondsAbsMin);
    lastPoint_MAG2          = get_uSecondsLocation(MAG2, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = MAG2(firstPoint_MAG2:lastPoint_MAG2, 2);
    altitude                = [altitude_useconds, MAG2(firstPoint_MAG2:lastPoint_MAG2, 3)];

    %Plot Magnetometer Data
    if plotEnable == 1
    figure('Name','Magnetometer 2 Values');
    plot_data(MAG2, MAG2_label, firstPoint_MAG2, lastPoint_MAG2, 1, 3, 's', 'MAG2');
    if saveEnable == 1
            saveName = [saveFolder, '\MAG2.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\MAG2.jpg'];
            saveas(gcf, saveName)
    end
    figure('Name','Magnetometer 2 Health');
    plot_data(MAG2, MAG2_label, firstPoint_MAG2, lastPoint_MAG2, 10, 1, 's', 'MAG2');
    end
end

%% Analyse IMU
if analyseIMU == true

    firstPoint_IMU         = get_uSecondsLocation(IMU, uSecondsMin, uSecondsAbsMin);
    lastPoint_IMU          = get_uSecondsLocation(IMU, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = IMU(firstPoint_IMU:lastPoint_IMU, 2);
    altitude                = [altitude_useconds, IMU(firstPoint_IMU:lastPoint_IMU, 3)];

    %Plot IMU Data
    if plotEnable == 1
    figure('Name','IMU Values');
    plot_data(IMU, IMU_label, firstPoint_IMU, lastPoint_IMU, 1, 6, 's', 'IMU');
    end
end

%% Analyse IMU2
if analyseIMU2 == true

    firstPoint_IMU2         = get_uSecondsLocation(IMU2, uSecondsMin, uSecondsAbsMin);
    lastPoint_IMU2          = get_uSecondsLocation(IMU2, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = IMU2(firstPoint_IMU2:lastPoint_IMU2, 2);
    altitude                = [altitude_useconds, IMU2(firstPoint_IMU2:lastPoint_IMU2, 3)];

    %Plot IMU Data
    if plotEnable == 1
    figure('Name','IMU 2 Values');
    plot_data(IMU2, IMU2_label, firstPoint_IMU2, lastPoint_IMU2, 1, 6, 's', 'IMU2');
    end
end

%% Analyse GYR1
if analyseGYR1 == true

    firstPoint_GYR1         = get_uSecondsLocation(GYR1, uSecondsMin, uSecondsAbsMin);
    lastPoint_GYR1          = get_uSecondsLocation(GYR1, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = GYR1(firstPoint_GYR1:lastPoint_GYR1, 2);
    altitude                = [altitude_useconds, GYR1(firstPoint_GYR1:lastPoint_GYR1, 3)];

    %Plot Gyrometer Data
    if plotEnable == 1
    figure('Name','Gyrometer 1 Values');
    plot_data(GYR1, GYR1_label, firstPoint_GYR1, lastPoint_GYR1, 2, 3, 's', 'GYR1');
    if saveEnable == 1
            saveName = [saveFolder, '\GYR1.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\GYR1.jpg'];
            saveas(gcf, saveName)
    end
    end
end

%% Analyse GYR2
if analyseGYR2 == true

    firstPoint_GYR2         = get_uSecondsLocation(GYR2, uSecondsMin, uSecondsAbsMin);
    lastPoint_GYR2          = get_uSecondsLocation(GYR2, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = GYR2(firstPoint_GYR2:lastPoint_GYR2, 2);
    altitude                = [altitude_useconds, GYR2(firstPoint_GYR2:lastPoint_GYR2, 3)];

    %Plot Gyrometer Data
    if plotEnable == 1
    figure('Name','Gyrometer 2 Values');
    plot_data(GYR2, GYR2_label, firstPoint_GYR2, lastPoint_GYR2, 2, 3, 's', 'GYR2');
    end
end

%% Analyse EKF1
if analyseEKF1 == true

    firstPoint_EKF1         = get_uSecondsLocation(EKF1, uSecondsMin, uSecondsAbsMin);
    lastPoint_EKF1          = get_uSecondsLocation(EKF1, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = EKF1(firstPoint_EKF1:lastPoint_EKF1, 2);
    altitude                = [altitude_useconds, EKF1(firstPoint_EKF1:lastPoint_EKF1, 3)];

    %Plot EKF Data
    if plotEnable == 1
    figure('Name','Extended Kalman Filter 1 Values');
    plot_data(EKF1, EKF1_label, firstPoint_EKF1, lastPoint_EKF1, 1, 3, 's', 'EKF1');
    if saveEnable == 1
            saveName = [saveFolder, '\EKF1.fig'];
            saveas(gcf, saveName);
            saveName = [saveFolder, '\EKF1.jpg'];
            saveas(gcf, saveName)
    end
    end
    
    %Sample Times
    if analyseSampleTimes == true
    deltaSamplesTime_us_EKF1             = get_dataDelta(EKF1(firstPoint_EKF1:lastPoint_EKF1, 2));
    deltaSampleTime_lineNumber_EKF1      = deltaSamplesTime_us_EKF1(:,1);
    deltaSampleTime_us_EKF1              = deltaSamplesTime_us_EKF1(:,2);
    deltaSampleTime_ms_EKF1              = deltaSampleTime_us_EKF1/1000;

    if plotEnable == 1
    plot_data_YXX(deltaSampleTime_ms_EKF1, deltaSampleTime_lineNumber_EKF1, (EKF1(firstPoint_EKF1:lastPoint_EKF1, 2))/1000,'Time Between EKF1 Samples (Milli Seconds)', 'Line Number', 'mSecond', 'Delta EKF1 Sample Times')   %Plot the Variations in sample frequency
    end
    end
end

%% Analyse EKF2
if analyseEKF2 == true

    firstPoint_EKF2         = get_uSecondsLocation(EKF2, uSecondsMin, uSecondsAbsMin);
    lastPoint_EKF2          = get_uSecondsLocation(EKF2, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = EKF2(firstPoint_EKF2:lastPoint_EKF2, 2);
    altitude                = [altitude_useconds, EKF2(firstPoint_EKF2:lastPoint_EKF2, 3)];

    %Plot EKF Data
    if plotEnable == 1
    figure('Name','Extended Kalman Filter 2 Values');
    plot_data(EKF2, EKF2_label, firstPoint_EKF2, lastPoint_EKF2, 1, 3, 's', 'EKF2');
    end
end

%% Analyse EKF3
if analyseEKF3 == true

    firstPoint_EKF3         = get_uSecondsLocation(EKF3, uSecondsMin, uSecondsAbsMin);
    lastPoint_EKF3          = get_uSecondsLocation(EKF3, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = EKF3(firstPoint_EKF3:lastPoint_EKF3, 2);
    altitude                = [altitude_useconds, EKF3(firstPoint_EKF3:lastPoint_EKF3, 3)];

    %Plot Altitude Data
    if plotEnable == 1
    figure('Name','Extended Kalman Filter 3 Values');
    plot_data(EKF3, EKF3_label, firstPoint_EKF3, lastPoint_EKF3, 1, 3, 's', 'EKF3');
    end
end

%% Analyse EKF4
if analyseEKF4 == true

    firstPoint_EKF4         = get_uSecondsLocation(EKF4, uSecondsMin, uSecondsAbsMin);
    lastPoint_EKF4          = get_uSecondsLocation(EKF4, uSecondsMax, uSecondsAbsMin);
    
    altitude_useconds       = EKF4(firstPoint_EKF4:lastPoint_EKF4, 2);
    altitude                = [altitude_useconds, EKF4(firstPoint_EKF4:lastPoint_EKF4, 3)];

    %Plot Altitude Data
    if plotEnable == 1
    figure('Name','Extended Kalman Filter 4 Values');
    plot_data(EKF4, EKF4_label, firstPoint_EKF4, lastPoint_EKF4, 1, 3, 's', 'EKF4');
    end
end


% plot_pilot_in_vs_set_points(pilot_in_roll, attitude_target_roll, pilot_in_pitch, attitude_target_pitch, pilot_in_yaw, rate_target_yaw);

%% Final Message Box
msgbox(...
{   sprintf('Imported data from: %s', file)...
    ,sprintf('Printed %d%%  - %d%%', startPercentage, endPercentage)...
    ,sprintf('First Data Point Time %i s - %i s Last Data Point Time ', round(uSecondsMin/1000000.0) ,round(uSecondsMax/1000000.0))...
}...
,'Success!!'); 