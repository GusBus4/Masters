%% Init Simulink Time Variables
fs                  = 4096;                             %sample frequency
Ts                  = 0.0025;                           %sample time - 400Hz
Outer_Ts            = 0.01;                             %sample time - 100Hz
Proximity_Ts        = 0.05;                             %sample time - 20Hz
HeadingAdjust_Ts    = 1;                                %sample time - 1Hz

%% Generate Way Points
waypoints_ned

%% Generate Sensor Variables
sensor_max_range = 2;
sensor_min_range = 0.04;

vertical_sensor_max_range = 3.5;
vertical_sensor_min_range = 0.04;

% Ks = 0.5;
% Kd = 2;

Ks = 1;                 %Stable with yaw, body acceleration
Kd = 0.5;

%% Init Environment
init_environment_2d

%% Init Sensors
init_sensors_2d

