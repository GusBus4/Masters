%X-Body
%
%                                           -
%                   1                       |
%              7         5                  |sensor_max_range
%                                           |
%            4      O      3                |
%                                           -            
%              6         8
%                   2
%                                           Y-Body
%  O = [current_pos_y current_pos_x]
%                                                   

current_pos_body = dcm_earth_to_body(1:2, 1:2)*[current_pos_n; current_pos_e];

current_pos_body_x = current_pos_body(1, 1)                                 %Rotated North Value
current_pos_body_y = current_pos_body(2, 1)                                 %Rotated East Value

sensor1 = [ 
            current_pos_body_x current_pos_body_x + sensor_max_range;
            current_pos_body_y current_pos_body_y
          ];
      
sensor2 = [ 
            current_pos_body_x current_pos_body_x - sensor_max_range;
            current_pos_body_y current_pos_body_y
          ];

sensor3 = [
            current_pos_body_x current_pos_body_x;
            current_pos_body_y current_pos_body_y + sensor_max_range
          ];
      
sensor4 = [
            current_pos_body_x current_pos_body_x;
            current_pos_body_y current_pos_body_y - sensor_max_range
          ];
      
sensor5 = [
            current_pos_body_x current_pos_body_x + sensor_max_range*sin(deg2rad(45));
            current_pos_body_y current_pos_body_y + sensor_max_range*cos(deg2rad(45))
          ] ;
      
sensor6 = [
            current_pos_body_x current_pos_body_x - sensor_max_range*sin(deg2rad(45));
            current_pos_body_y current_pos_body_y - sensor_max_range*cos(deg2rad(45))
          ] ;

sensor7 = [
            current_pos_body_x current_pos_body_x + sensor_max_range*sin(deg2rad(45));
            current_pos_body_y current_pos_body_y - sensor_max_range*cos(deg2rad(45))
          ] ;
      
sensor8 = [
            current_pos_body_x current_pos_body_x - sensor_max_range*sin(deg2rad(45));
            current_pos_body_y current_pos_body_y + sensor_max_range*cos(deg2rad(45))
          ];    

sensors =  zeros(2, 2, 7);

sensors(1, 1, 1) = sensor1(1, 1);
sensors(1, 2, 1) = sensor1(1, 2);
sensors(2, 1, 1) = sensor1(2, 1);
sensors(2, 2, 1) = sensor1(2, 2);

sensors(1, 1, 2) = sensor2(1, 1);
sensors(1, 2, 2) = sensor2(1, 2);
sensors(2, 1, 2) = sensor2(2, 1);
sensors(2, 2, 2) = sensor2(2, 2);

sensors(1, 1, 3) = sensor3(1, 1);
sensors(1, 2, 3) = sensor3(1, 2);
sensors(2, 1, 3) = sensor3(2, 1);
sensors(2, 2, 3) = sensor3(2, 2);

sensors(1, 1, 4) = sensor4(1, 1);
sensors(1, 2, 4) = sensor4(1, 2);
sensors(2, 1, 4) = sensor4(2, 1);
sensors(2, 2, 4) = sensor4(2, 2);

sensors(1, 1, 5) = sensor5(1, 1);
sensors(1, 2, 5) = sensor5(1, 2);
sensors(2, 1, 5) = sensor5(2, 1);
sensors(2, 2, 5) = sensor5(2, 2);

sensors(1, 1, 6) = sensor6(1, 1);
sensors(1, 2, 6) = sensor6(1, 2);
sensors(2, 1, 6) = sensor6(2, 1);
sensors(2, 2, 6) = sensor6(2, 2);

sensors(1, 1, 7) = sensor7(1, 1);
sensors(1, 2, 7) = sensor7(1, 2);
sensors(2, 1, 7) = sensor7(2, 1);
sensors(2, 2, 7) = sensor7(2, 2);

sensors(1, 1, 8) = sensor8(1, 1);
sensors(1, 2, 8) = sensor8(1, 2);
sensors(2, 1, 8) = sensor8(2, 1);
sensors(2, 2, 8) = sensor8(2, 2);

hold on;
grid on;

plot(sensor1(2,:), sensor1(1,:), 'g', 'LineWidth', 2)
plot(sensor2(2,:), sensor2(1,:), 'g', 'LineWidth', 2)
plot(sensor3(2,:), sensor3(1,:), 'g', 'LineWidth', 2)
plot(sensor4(2,:), sensor4(1,:), 'g', 'LineWidth', 2)
plot(sensor5(2,:), sensor5(1,:), 'g', 'LineWidth', 2)
plot(sensor6(2,:), sensor6(1,:), 'g', 'LineWidth', 2)
plot(sensor7(2,:), sensor7(1,:), 'g', 'LineWidth', 2)
plot(sensor8(2,:), sensor8(1,:), 'g', 'LineWidth', 2)

% xlim([-20 20])
% ylim([-20 20])
hold off;
      
      