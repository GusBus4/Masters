waypoint_ned_data(1, :)     = [0         -2        0];
waypoint_ned_data(2, :)     = [0         -2       -6];
waypoint_ned_data(3, :)     = [2         -2       -6];
waypoint_ned_data(4, :)     = [4         -2       -6];
waypoint_ned_data(5, :)     = [8         -2       -6];
waypoint_ned_data(6, :)     = [12        -2       -6];
% waypoint_ned_data(2, :)     = [5        5       -40];
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