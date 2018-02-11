clear all;

load('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\global.mat');

% Importdata = load('.\flight logs\2017-04-28 12-02-32.log-2000000.mat');
% Importdata = load('.\flight logs\rate80stab80proc.log-333727.mat');
% Importdata = load('.\flight logs\crash.log-274015.mat');
% Importdata = load('.\flight logs\2017-04-28 08-50-45 (Maiden Test Flight HRF).log-574744.mat');
% Importdata = load('.\flight logs\2017-11-03 14-24-34.log-529770.mat');
Importdata = load('.\flight logs\2017-11-09 12-54-59.log-477460.mat');

%% Store Variables
Vibration   =   Importdata.VIBE;
Attitude    =   Importdata.ATT;
Rate        =   Importdata.RATE;
Rcout       =   Importdata.RCOU;

%% Give start and end percentages of the data meant for analysis
startPercentage     =   72.21;        
endPercentage       =   98;        

%% RCOUT Extraction
uSecondsRcout       = Importdata.RCOU(:,2);
uSecondsMinRcout    = uSecondsRcout(1); 
uSecondsRcout       = uSecondsRcout(:) - uSecondsMinRcout;       %Set the first data point as zero time

dataSizeRcout = size(Importdata.RCOU);

if startPercentage == 0
    firstPoint = 1;
    lastPoint = round((endPercentage/100.0)*dataSizeRcout(1), 0);
else
    firstPoint = round((startPercentage/100.0)*dataSizeRcout(1), 0);
    lastPoint = round((endPercentage/100.0)*dataSizeRcout(1), 0);
end

mSecondsRcout = uSecondsRcout/1000;
SecondsRcout = mSecondsRcout/1000;

% define time range for simulinkmodel
% tmax = max(Importdata.RCOU(:,2));
% tmin = min(Importdata.RCOU(:,2));
% tstep = (tmax-tmin)/length(Importdata.RCOU(:,2));

RCOUT1 = [SecondsRcout,Rcout(:,3)];
RCOUT2 = [SecondsRcout,Rcout(:,4)];
RCOUT3 = [SecondsRcout,Rcout(:,5)];
RCOUT4 = [SecondsRcout,Rcout(:,6)];

%% Rate Extraction
% RATE_DESIRED_ROLL =     [SecondsRcout,Rate(:,3)];
% RATE_ROLL =             [SecondsRcout,Rate(:,4)];
% RATE_DESIRED_PITCH =    [SecondsRcout,Rate(:,6)];
% RATE_PITCH =            [SecondsRcout,Rate(:,7)];
% RATE_DESIRED_YAW =      [SecondsRcout,Rate(:,9)];
% RATE_YAW =              [SecondsRcout,Rate(:,10)];


%% Initial Values
initang = round((startPercentage/100.0)*dataSizeRcout(1), 0);
initang = 2922;
InitialAngles = [Attitude(initang,4) Attitude(initang,6) Attitude(initang,8)];
InitialAngles = deg2rad(InitialAngles);


initRate = round((startPercentage/100.0)*dataSizeRcout(1), 0);
initRate = 2718;
InitialRate = [Rate(initRate,4) Rate(initRate,6) Rate(initRate,8)];
InitialRate = deg2rad(InitialRate/100);

Rcout(firstPoint,2)
Rate(initRate,2)
Attitude(initang,2)

%% Vibrations
%Vibrations in accelerometer in XYZ (still have to implement at accelerometer!
Vibe=[SecondsRcout Vibration(:,3) Vibration(:,4) Vibration(:,5)];


%% Extras
% RCOUT check
rcout1mean = mean(RCOUT1(firstPoint:lastPoint,2));
rcout2mean = mean(RCOUT2(firstPoint:lastPoint,2));
rcout3mean = mean(RCOUT3(firstPoint:lastPoint,2));
rcout4mean = mean(RCOUT4(firstPoint:lastPoint,2));
contributionrcout1=rcout1mean/(rcout1mean+rcout2mean+rcout3mean+rcout4mean);
contributionrcout2=rcout2mean/(rcout1mean+rcout2mean+rcout3mean+rcout4mean);
contributionrcout3=rcout3mean/(rcout1mean+rcout2mean+rcout3mean+rcout4mean);
contributionrcout4=rcout4mean/(rcout1mean+rcout2mean+rcout3mean+rcout4mean);



% Altitude
figure; plot(Importdata.BARO(527:734,3))