%% Place the Rotors
%  Use absolute position. Offset rotors by arm length and dcm. 
%       ccw       cw            
%N         3    1
%           \  /
%            \/
%            /\
%           /  \
%          2    4       
%       cw        ccw   E
%%%%%%%%%%%%%%%%%%%%%%%%%
earth_linear_position_absolute      =   [
                                            2;
                                            2;
                                            -6
                                        ];

yaw_angle = deg2rad(45);                                    
dcm_earth_to_body = angle2dcm(0,0, yaw_angle, 'XYZ');

T1 = -15;
T2 = -15;
T3 = -15;
T4 = -15;

%% Inputs
armLength           = 0.41;            %Meters
alpha               = deg2rad(15);     %Rad

roll_arm    = armLength * sin(alpha);
pitch_arm   = armLength * cos(alpha);

%% Rotate the walls from NED frame to body frame
init_environment_2d

%% Rotate position into body frame
body_linear_position_absolute = dcm_earth_to_body*earth_linear_position_absolute;

%%  First assume no rotation to simplify
%  rotor_pos = [Npos ±Noffset; Epos ±Eoffset; Dpos]
rotor_pos = zeros([4 3]);
rotor_pos(:, 1) = [body_linear_position_absolute(1)+pitch_arm; body_linear_position_absolute(2)+roll_arm; body_linear_position_absolute(3)];
rotor_pos(:, 2) = [body_linear_position_absolute(1)-pitch_arm; body_linear_position_absolute(2)-roll_arm; body_linear_position_absolute(3)];
rotor_pos(:, 3) = [body_linear_position_absolute(1)+pitch_arm; body_linear_position_absolute(2)-roll_arm; body_linear_position_absolute(3)];
rotor_pos(:, 4) = [body_linear_position_absolute(1)-pitch_arm; body_linear_position_absolute(2)+roll_arm; body_linear_position_absolute(3)];

%% Init Values
intersections_y_body        = zeros(4, length(walls_body));
intersections_x_body        = zeros(4, length(walls_body));
intersection_distances      = zeros(4, length(walls_body));
min_intersection_distances  = zeros(1, 4);
intersection_counter        = 1;
disturbance_percentage = zeros([4 1]);

                                  %Yb2
        
% for wall_number = 1:length(walls_body)
        wall_number = 1
    %% We first need to find the gradient of the wall
    wall_gradient = (walls_body(1, 2, wall_number) - walls_body(1, 1, wall_number))/(walls_body(2, 2, wall_number) - walls_body(2, 1, wall_number));
    
    %Closest point will be perpindicular to that line
    line_gradient = -wall_gradient;
    
    
    
    for rotor_number = 1:4
    
        %% Calculate the line perpindicluar to the wall from the middle of each rotor
        max_influence_distance = 1;
        
        x1 = rotor_pos(rotor_number(2));
        y1 = rotor_pos(rotor_number(1));
        
        x2 = x1 + sqrt((max_influence_distance^2)/(1 + line_gradient^2))
        y2 = line_gradient(x2 - x1) + y1
        
        plot([y2 - y1], [x2 - x1], 'c',  'LineWidth', 2)
        
%         %Create column vectors
%         cv1 = [
%                 x2 - x1;
%                 y2 - y1;
%                 0
%               ];
%         cv2 = [
%                 walls_body(1, 2, wall_number) - walls_body(1, 1, wall_number);
%                 walls_body(2, 2, wall_number) - walls_body(2, 1, wall_number);
%                 0
%               ];
% 
%         y3 = walls_body(1, 1, wall_number);                                 %Xb1
%         y4 = walls_body(1, 2, wall_number);                                 %Xb2
%         x3 = walls_body(2, 1, wall_number);                                 %Yb1
%         x4 = walls_body(2, 2, wall_number);                                 %Yb2
% 
%         
%         ta = ((y3 - y4)*(x1 - x3) + (x4 - x3)*(y1 - y3))/denominator;
%         tb = ((y1 - y2)*(x1 - x3) + (x2 - x1)*(y1 - y3))/denominator;
% 
%         if ta >= 0 && ta <= 1 && tb >= 0 && tb <= 1
%             intersections_y_body(rotor_number, intersection_counter) = x1 + ta*(x2 - x1);       %Intersections
%             intersections_x_body(rotor_number, intersection_counter) = y3 + tb*(y4 - y3);
%             intersection_distances(rotor_number, intersection_counter) = sqrt( (current_pos_body_x - intersections_x_body(rotor_number, intersection_counter))^2 + (current_pos_body_y - intersections_y_body(rotor_number, intersection_counter))^2 );
% 
%             %Check if the angle between the vectors is above a certain threshold
%             if angle_check(cv1, cv2, 20) == 0
%                 intersection_distances(rotor_number, intersection_counter) = -intersection_distances(rotor_number, intersection_counter);
%             end   
%         else
%             intersection_distances(rotor_number, intersection_counter) = sensor_max_range;
%         end
% 
%         
%         
%         
%         intersection_counter = intersection_counter + 1;
%     end
%     
%     %Only return the smallest intersection value
%     
%     if abs(min(intersection_distances(rotor_number, :))) >= min(abs(intersection_distances(rotor_number, :))) && min(intersection_distances(rotor_number, :)) > 0
%         
%         min_intersection_distances(rotor_number) = min(intersection_distances(rotor_number, :));
%     else
%         min_intersection_distances(rotor_number) = sensor_max_range;
    end
%     
%     intersection_counter = 1;
% end
% 


Tnw1 = T1 * disturbance_percentage(1);
Tnw2 = T2 * disturbance_percentage(2);
Tnw3 = T3 * disturbance_percentage(3);
Tnw4 = T4 * disturbance_percentage(4);
