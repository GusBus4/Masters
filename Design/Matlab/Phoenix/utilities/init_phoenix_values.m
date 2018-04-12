%% Init Simulink Time Variables
fs=4096;                            %sample frequency
Ts=0.0025;                          %sample time - 400Hz
Outer_Ts = Ts;

%% Generate Way Points
waypoints_ned

%% Generate Sensor Variables
sensor_max_range = 1500;
sensor_min_range = 40;