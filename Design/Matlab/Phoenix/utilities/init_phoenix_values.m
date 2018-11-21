
%% Init Simulink Time Variables
fs                  = 4096;                             %sample frequency
Ts                  = 0.0025;                           %sample time - 400Hz
Outer_Ts            = 0.01;                             %sample time - 100Hz
Proximity_Ts        = 0.05;                             %sample time - 20Hz
HeadingAdjust_Ts    = 0.2;                             %sample time - 5Hz

%% Generate Way Points
waypoints_ned

%% Generate Sensor Variables
sensor_max_range = 3.5;
sensor_min_range = 0.0;

vertical_sensor_max_range = 2;
vertical_sensor_min_range = 0.0;

Ks = 0.05;
Kd = 0.75;
% Ks = 0.115;
% Kd = 1.2;

Vertical_Ks = 0.45;
Vertical_Kd = 0;

%% Init Environment
init_environment_2d


