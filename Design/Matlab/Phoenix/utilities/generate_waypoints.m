%% Load Data
    % N Waypoints
waypoint_x_data             = [0    ; 5     ; -5     ; -5     ; 5     ; 10; -010    ; 10     ; -10     ; 10     ; -10     ; 10];
    % E Waypoints
waypoint_y_data             = [0    ; 5     ; 5    ; -5     ; -5     ; 0];
    % D Waypoints
waypoint_z_data             = [0; -40; -40; -40; -40; -40];

waypoint_x_time             = 0;
waypoint_x_push             = 0;
waypoint_x_push_time        = 0;

waypoint_y_time             = 0;
waypoint_y_push             = 0;
waypoint_y_push_time        = 0;

waypoint_z_time             = 0;
waypoint_z_push             = 0;
waypoint_z_push_time        = 0;

%% North
for i = 1:size(waypoint_x_data)
    
    waypoint_x_time(i, 1)           = 0 + 0.01*(i-1);
    
end

for i = 1:2:(2*size(waypoint_x_data) - 1)
    waypoint_x_push(i, 1)       = 0;
    waypoint_x_push(i + 1, 1)   = 1;
    
    waypoint_x_push_time(i + 1, 1)   = 0.015 + 0.005*(i-1);
    waypoint_x_push_time(i + 2, 1)   = waypoint_x_push_time(i+1, 1) + 0.001;
end

waypoint_x_push_time = waypoint_x_push_time(1:length(waypoint_x_push));

%% East
for i = 1:size(waypoint_y_data)
    
    waypoint_y_time(i, 1)           = 0 + 0.01*(i-1);
    
end

for i = 1:2:(2*size(waypoint_y_data) - 1)
    waypoint_y_push(i, 1)       = 0;
    waypoint_y_push(i + 1, 1)   = 1;
    
    waypoint_y_push_time(i + 1, 1)   = 0.015 + 0.005*(i-1);
    waypoint_y_push_time(i + 2, 1)   = waypoint_y_push_time(i+1, 1) + 0.001;
end

waypoint_y_push_time = waypoint_y_push_time(1:length(waypoint_y_push));


%% Down
for i = 1:size(waypoint_z_data)
    
    waypoint_z_time(i, 1)           = 0 + 0.01*(i-1);
    
end

for i = 1:2:(2*size(waypoint_z_data) - 1)
    waypoint_z_push(i, 1)       = 0;
    waypoint_z_push(i + 1, 1)   = 1;
    
    waypoint_z_push_time(i + 1, 1)   = 0.015 + 0.005*(i-1);
    waypoint_z_push_time(i + 2, 1)   = waypoint_z_push_time(i+1, 1) + 0.001;
end

waypoint_z_push_time = waypoint_z_push_time(1:length(waypoint_z_push));


%% Create Simulink Variables

waypoint_x          = timeseries(waypoint_x_data, waypoint_x_time, 'Name', 'waypoint_x');
x_push              = timeseries(waypoint_x_push, waypoint_x_push_time, 'Name', 'x_push');

waypoint_y          = timeseries(waypoint_y_data, waypoint_y_time, 'Name', 'waypoint_y');
y_push              = timeseries(waypoint_y_push, waypoint_y_push_time, 'Name', 'y_push');

waypoint_z          = timeseries(waypoint_z_data, waypoint_z_time, 'Name', 'waypoint_z');
z_push              = timeseries(waypoint_z_push, waypoint_z_push_time, 'Name', 'z_push');


North   = [waypoint_x_data waypoint_x_time]
East    = [waypoint_y_data waypoint_y_time]
Down    = [waypoint_z_data waypoint_z_time]

