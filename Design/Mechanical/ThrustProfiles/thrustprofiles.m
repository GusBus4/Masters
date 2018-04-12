clear all; 
close all; 

Importdata=xlsread('Thrust Profile Measurements.xlsx');

g = 9.81;
x = linspace(1000,2000,1000);
x = 1450;

m=Importdata(2:10,43);
Vcalibrate=Importdata(2:10,44)-Importdata(1,44);

Tcalibrate=m*g;
Thrustfactor = Tcalibrate./Vcalibrate; 
meanthrustfactor = mean(Thrustfactor);

%% Measurement motor 1

m1=Importdata(21,24);
Vcalibrate1=Importdata(21,25)-Importdata(20,25);

Tcalibrate1=m1*g;
Thrustfactor1 = (max(Tcalibrate1))/max(Vcalibrate1); 


beginpoint1 = 2;                % beginpoint excel matrix
endpoint1 = 17;                  % endpoint excel matrix
V1offset = Importdata(1,25);     % Offset motor 1
PWM1 = Importdata(beginpoint1:endpoint1,24);
Voltage1 = Importdata(2:endpoint1,25)-V1offset;
Thrust1 = Voltage1*-meanthrustfactor;

p1=polyfit(PWM1,Thrust1,2);
fit1 = p1(1)*x.^2+p1(2)*x+p1(3);

% figure(9);
% plot(PWM1,Thrust1)
% % plot(PWM1,Thrust1,x,fit1)
% title('Thrustprofile motor 1')
% xlabel('PWM');
% ylabel('Thrust (N)');

%% Measurement motor 2
m2=Importdata(18,19);
Vcalibrate2=Importdata(18,20)-Importdata(17,20);

Tcalibrate2=m2*g;


Thrustfactor2 = (max(Tcalibrate2))/max(Vcalibrate2);


beginpoint2 = 2;                % beginpoint excel matrix
endpoint2 = 14;                  % endpoint excel matrix
V2offset = Importdata(1,20);     % Offset motor 2
PWM2 = Importdata(beginpoint2:endpoint2,19);
Voltage2 = Importdata(2:endpoint2,20)-V2offset;
Thrust2 = Voltage2*-meanthrustfactor;

p2=polyfit(PWM2,Thrust2,2);
fit2 = p2(1)*x.^2+p2(2)*x+p2(3);

% figure(10);
% plot(PWM2,Thrust2)
% % plot(PWM2,Thrust2,x,fit2)
% title('Thrustprofile motor 2')
% xlabel('PWM');
% ylabel('Thrust (N)');

%% Measurement motor 3

m3=Importdata(21,30);
Vcalibrate3=Importdata(21,31)-Importdata(20,31);

Tcalibrate3=m3*g;

Thrustfactor3 = (max(Tcalibrate3))/max(Vcalibrate3);

beginpoint3 = 2;                % beginpoint excel matrix
endpoint3 = 14;                  % endpoint excel matrix
V3offset = Importdata(1,31);     % Offset motor 2
PWM3 = Importdata(beginpoint3:endpoint3,30);
Voltage3 = Importdata(2:endpoint3,31)-V3offset;
Thrust3 = Voltage3*-meanthrustfactor;

p3=polyfit(PWM3,Thrust3,2);
fit3 = p3(1)*x.^2+p3(2)*x+p3(3);

% figure;
% plot(PWM3,Thrust3)
% title('Thrustprofile motor 3')
% xlabel('PWM');
% ylabel('Thrust (N)');


%% Measurement motor 
m4=Importdata(21,36);
Vcalibrate4=Importdata(21,37)-Importdata(20,37);

Tcalibrate4=m4*g;

Thrustfactor4 = (max(Tcalibrate4))/max(Vcalibrate4);
beginpoint4 = 2;                % beginpoint excel matrix
endpoint4 = 13;                  % endpoint excel matrix
V4offset = Importdata(1,37);     % Offset motor 2
PWM4 = Importdata(beginpoint4:endpoint4,36);
Voltage4 = Importdata(2:endpoint4,37)-V4offset;
Thrust4 = Voltage4*-meanthrustfactor;

p4=polyfit(PWM4,Thrust4,2);
fit4 = p4(1)*x.^2+p4(2)*x+p4(3);

% figure;
% plot(PWM4,Thrust4)
% title('Thrustprofile motor 4')
% xlabel('PWM');
% ylabel('Thrust (N)');


figure;
hold on;
plot(PWM1,Thrust1)
plot(PWM2,Thrust2)
plot(PWM3,Thrust3)
plot(PWM4,Thrust4)
title('Thrust Profiles')
xlabel('PWM');
ylabel('Thrust (N)');
legend('Pair 1', 'Pair 2', 'Pair 3', 'Pair 4', 'Location', 'southeast');
hold off;

maxpwm1 = max(PWM1)
maxpwm2 = max(PWM2)
maxpwm3 = max(PWM3)
maxpwm4 = max(PWM4)

minpwm1 = min(PWM1)
minpwm2 = min(PWM2)
minpwm3 = min(PWM3)
minpwm4 = min(PWM4)

maxthrust(1) = max(Thrust1)
maxthrust(2) = max(Thrust2)
maxthrust(3) = max(Thrust3)
maxthrust(4) = max(Thrust4)

maxThrust = maxthrust(1) + maxthrust(2) + maxthrust(4) + maxthrust(4)

minthrust(1) = min(Thrust1)
minthrust(2) = min(Thrust2)
minthrust(3) = min(Thrust3)
minthrust(4) = min(Thrust4)

minThrust = minthrust(1) + minthrust(2) + minthrust(4) + minthrust(4)

% figure;
% subplot(2,2,1);
% plot(PWM1,Thrust1)
% title('Thrustprofile motor 1')
% xlabel('PWM');
% ylabel('Thrust (N)');
% subplot(2,2,2);
% plot(PWM2,Thrust2)
% title('Thrustprofile motor 2')
% xlabel('PWM');
% ylabel('Thrust (N)');
% subplot(2,2,3);
% plot(PWM3,Thrust3)
% title('Thrustprofile motor 3')
% xlabel('PWM');
% ylabel('Thrust (N)');
% subplot(2,2,4);
% plot(PWM4,Thrust4)
% title('Thrustprofile motor 4')
% xlabel('PWM');
% ylabel('Thrust (N)');




