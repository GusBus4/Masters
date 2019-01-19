waypoint_ned_data = zeros(6, 3)
flight_radius = 5;

% for i = 1:360
%     
%     waypoint_ned_data(i, :)    = [flight_radius*cos(deg2rad(i)) flight_radius*sin(deg2rad(i)) -6];
%     
% end


%% Simple Waypoint
waypoint_ned_data(1, :)     = [0          0         -6];
waypoint_ned_data(2, :)     = [0       0         -6];
waypoint_ned_data(3, :)     = [10       0         -6];
waypoint_ned_data(4, :)     = [10       10         -6];
waypoint_ned_data(5, :)     = [0       10         -6];
waypoint_ned_data(6, :)     = [0        0         -6];

%% Full Suite
% waypoint_ned_data(1, :)     = [0          0         -6];
% waypoint_ned_data(2, :)     = [0       0         -6];
% waypoint_ned_data(3, :)     = [10       0         -6];
% waypoint_ned_data(4, :)     = [15.25       1.5         -6];
% waypoint_ned_data(5, :)     = [15       -2         -6];
% waypoint_ned_data(6, :)     = [15        -18         -6];
% waypoint_ned_data(7, :)     = [10       -18         -6];
% waypoint_ned_data(8, :)     = [0        0         -6];
% waypoint_ned_data(9, :)     = [10          -6         -6];

% waypoint_ned_data(10, :)     = [15       0         -6];
% waypoint_ned_data(11, :)     = [15       -15         -6];
% waypoint_ned_data(12, :)     = [0        -15         -6];
% waypoint_ned_data(13, :)     = [0         0         -6];
% waypoint_ned_data(14, :)     = [0         0         -6];

% waypoint_ned_data(3, :)     = [-5       5       -40];
% waypoint_ned_data(4, :)     = [-5       -5      -40];
% waypoint_ned_data(5, :)     = [5        -5      -40];
% waypoint_ned_data(6, :)     = [5        5       -40];
% waypoint_ned(8)     = [0        0       -40];
% waypoint_ned(9)     = [0        0       -40];
% waypoint_ned(10)    = [0        0       -40];



waypoint_ned_time             = 0;
waypoint_ned_push             = 0;
waypoint_ned_push_time        = 0;

%% NED
for i = 1:length(waypoint_ned_data)
    
    waypoint_ned_time(i, 1)           = 0 + 0.01*(i-1);
    
end

for i = 1:2:(2*length(waypoint_ned_data) - 1)
    waypoint_ned_push(i, 1)       = 0;
    waypoint_ned_push(i + 1, 1)   = 1;
    
    waypoint_ned_push_time(i + 1, 1)   = 0.015 + 0.005*(i-1);
    waypoint_ned_push_time(i + 2, 1)   = waypoint_ned_push_time(i+1, 1) + 0.001;
end

waypoint_ned_data
waypoint_ned_time

waypoint_ned_push
waypoint_ned_push_time = waypoint_ned_push_time(1:length(waypoint_ned_push))


%% Create Simulink Variables
waypoint_ned        = timeseries(waypoint_ned_data, waypoint_ned_time, 'Name', 'waypoint_ned');
ned_push            = timeseries(waypoint_ned_push, waypoint_ned_push_time, 'Name', 'ned_push');