%% Create Variables to run script
% close all;

current_pos_n = 15.27;                                                          
current_pos_e = 0.89;                                                          
current_yaw = deg2rad(0);

dcm_earth_to_body = angle2dcm(0,0,current_yaw, 'XYZ');

number_of_points = 1000;
resolution = 3;

%% Create both environment and sensors
init_environment_2d
init_sensors_2d

%% Init Values
intersections_y_body        = zeros(length(sensors), length(walls_body));
intersections_x_body        = zeros(length(sensors), length(walls_body));
intersection_distances      = zeros(length(sensors), length(walls_body));
min_intersection_distances  = zeros(1, length(sensors));
intersection_counter        = 1;

for sensor_number = 1:length(sensors)
    
    y1 = sensors(1, 1, sensor_number);                                      %Xb1
    y2 = sensors(1, 2, sensor_number);                                      %Xb2
    x1 = sensors(2, 1, sensor_number);                                      %Yb1
    x2 = sensors(2, 2, sensor_number);                                      %Yb2
        
    for wall_number = 1:length(walls_body)
        sensor_number = sensor_number
        wall_number = wall_number
        
        %Create column vectors
        cv1 = [
                sensors(1, 2, sensor_number) - sensors(1, 1, sensor_number);
                sensors(2, 2, sensor_number) - sensors(2, 1, sensor_number);
                0
              ];
        cv2 = [
                walls_body(1, 2, wall_number) - walls_body(1, 1, wall_number);
                walls_body(2, 2, wall_number) - walls_body(2, 1, wall_number);
                0
              ];


        y3 = walls_body(1, 1, wall_number);                                 %Xb1
        y4 = walls_body(1, 2, wall_number);                                 %Xb2
        x3 = walls_body(2, 1, wall_number);                                 %Yb1
        x4 = walls_body(2, 2, wall_number);                                 %Yb2

%                 if ((x4 - x3)*(y1 - y2) - (x1 - x2)*(y4 - y3)) == 0                   %Colinear
%                 intersections_x_body(sensor_number, intersection_counter) = 0;
%                 intersections_y_body(sensor_number, intersection_counter) = 0;
%                 intersection_distances(sensor_number, intersection_counter) = sensor_max_range;       
        denominator = ((x4 - x3)*(y1 - y2) - (x1 - x2)*(y4 - y3));

        if denominator ~= 0

            ta = ((y3 - y4)*(x1 - x3) + (x4 - x3)*(y1 - y3))/denominator;
            tb = ((y1 - y2)*(x1 - x3) + (x2 - x1)*(y1 - y3))/denominator;

            if ta >= 0 && ta <= 1 && tb >= 0 && tb <= 1
                intersections_y_body(sensor_number, intersection_counter) = x1 + ta*(x2 - x1);       %Intersections
                intersections_x_body(sensor_number, intersection_counter) = y3 + tb*(y4 - y3);
                intersection_distances(sensor_number, intersection_counter) = sqrt( (current_pos_body_x - intersections_x_body(sensor_number, intersection_counter))^2 + (current_pos_body_y - intersections_y_body(sensor_number, intersection_counter))^2 );
                
                %Check if the angle between the vectors is above a certain threshold
                if angle_check(cv1, cv2, 20) == 0
                    intersection_distances(sensor_number, intersection_counter) = -intersection_distances(sensor_number, intersection_counter)
                end   
            else
                intersection_distances(sensor_number, intersection_counter) = sensor_max_range;
            end
        else
            intersection_distances(sensor_number, intersection_counter) = sensor_max_range;
        end
        
        
        
        intersection_counter = intersection_counter + 1;
    end
    
    %Only return the smallest intersection value
    
    if abs(min(intersection_distances(sensor_number, :))) >= min(abs(intersection_distances(sensor_number, :))) && min(intersection_distances(sensor_number, :)) > 0
        
        min_intersection_distances(sensor_number) = min(intersection_distances(sensor_number, :))
    else
        min_intersection_distances(sensor_number) = sensor_max_range
    end
    
    intersection_counter = 1;
end


%% Using the Closest reading, create a "proximity vector"
% proximity_vector = p
% p = [x y]
% p.x = sensor3 + sensor5*sin(45) + sensor8*sin(45) - sensor4 - sensor7*sin(45) - sensor6*sin(45)
% p.y = sensor1 + sensor5*sin(45) + sensor7*sin(45) - sensor2 - sensor8*sin(45) - sensor6*sin(45)
proximity_vector = zeros(1,2);

% proximity_vector(1) = min([min_intersection_distances(3) min_intersection_distances(5)*0.7071  min_intersection_distances(8)*0.7071]) - min(min_intersection_distances(4) min_intersection_distances(6)*0.7071 - min_intersection_distances(7)*0.7071
% proximity_vector(2) = min_intersection_distances(1) + min_intersection_distances(5)*0.7071 + min_intersection_distances(7)*0.7071 - min_intersection_distances(2) - min_intersection_distances(8)*0.7071 - min_intersection_distances(6)*0.7071

proximity_vector(1) = min_intersection_distances(1) + min_intersection_distances(5)*0.7071 + min_intersection_distances(7)*0.7071 - min_intersection_distances(2) - min_intersection_distances(6)*0.7071 - min_intersection_distances(8)*0.7071;  %Xbody
proximity_vector(2) = min_intersection_distances(3) + min_intersection_distances(5)*0.7071 + min_intersection_distances(8)*0.7071 - min_intersection_distances(4) - min_intersection_distances(6)*0.7071 - min_intersection_distances(7)*0.7071;  %Ybody

proximity = [
                current_pos_body_x current_pos_body_x+proximity_vector(1);
                current_pos_body_y current_pos_body_y+proximity_vector(2);
            ];

hold on;
plot(proximity(2, :), proximity(1, :), 'c','LineWidth', 3.0) 

plot( [current_pos_body_y current_pos_body_y],[current_pos_body_x current_pos_body_x+min_intersection_distances(1)], 'Ro', 'MarkerSize', 10, 'LineWidth', 2)
plot( [current_pos_body_y current_pos_body_y],[current_pos_body_x current_pos_body_x-min_intersection_distances(2)], 'Ro', 'MarkerSize', 10,'LineWidth', 2)
plot( [current_pos_body_y+min_intersection_distances(3) current_pos_body_y],[current_pos_body_x current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)
plot( [current_pos_body_y-min_intersection_distances(4) current_pos_body_y],[current_pos_body_x current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)

plot( [current_pos_body_y+(0.7071*min_intersection_distances(5)) current_pos_body_y],[current_pos_body_x+(0.7071*min_intersection_distances(5)) current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)
plot( [current_pos_body_y-(0.7071*min_intersection_distances(6)) current_pos_body_y],[current_pos_body_x-(0.7071*min_intersection_distances(6)) current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)
plot( [current_pos_body_y-(0.7071*min_intersection_distances(7)) current_pos_body_y],[current_pos_body_x+(0.7071*min_intersection_distances(7)) current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)
plot( [current_pos_body_y+(0.7071*min_intersection_distances(8)) current_pos_body_y],[current_pos_body_x-(0.7071*min_intersection_distances(8)) current_pos_body_x], 'Ro', 'MarkerSize', 10,'LineWidth', 2)

ylabel('North Position', 'FontSize', 20)
xlabel('East Position', 'FontSize', 20)
axis equal;
hold off;






