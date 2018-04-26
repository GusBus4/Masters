sensor_range = 2;

current_pos_x = 0;
current_pos_y = 0;
current_pos_z = 4;

%x
%
%                                           -
%                   1                       |
%              7         5                  |sensor_range
%                                           |
%            4      X      3                |
%                                           -            
%              6         8
%                   2
%                                           y
%           X = [current_pos_x current_pos_y]
%                                                   

sensor1 = [ 
            current_pos_x current_pos_x + sensor_range;
            current_pos_y current_pos_y
            current_pos_z current_pos_z
          ]
      
sensor2 = [ 
            current_pos_x current_pos_x - sensor_range;
            current_pos_y current_pos_y
            current_pos_z current_pos_z
          ]

sensor3 = [
            current_pos_x current_pos_x;
            current_pos_y current_pos_y + sensor_range
            current_pos_z current_pos_z
          ]
      
sensor4 = [
            current_pos_x current_pos_x;
            current_pos_y current_pos_y - sensor_range
            current_pos_z current_pos_z
          ]
      
sensor5 = [
            current_pos_x current_pos_x + sensor_range*sin(deg2rad(45));
            current_pos_y current_pos_y + sensor_range*cos(deg2rad(45));
            current_pos_z current_pos_z
          ] 
      
sensor6 = [
            current_pos_x current_pos_x - sensor_range*sin(deg2rad(45));
            current_pos_y current_pos_y - sensor_range*cos(deg2rad(45));
            current_pos_z current_pos_z
          ] 

sensor7 = [
            current_pos_x current_pos_x + sensor_range*sin(deg2rad(45));
            current_pos_y current_pos_y - sensor_range*cos(deg2rad(45));
            current_pos_z current_pos_z
          ] 
      
sensor8 = [
            current_pos_x current_pos_x - sensor_range*sin(deg2rad(45));
            current_pos_y current_pos_y + sensor_range*cos(deg2rad(45));
            current_pos_z current_pos_z
          ]

sensor9 = [
            current_pos_x current_pos_x;
            current_pos_y current_pos_y;
            current_pos_z current_pos_z + sensor_range;
          ]      
      
sensor10 = [
            current_pos_x current_pos_x;
            current_pos_y current_pos_y;
            current_pos_z current_pos_z - sensor_range;
          ]      

hold on;
view(3)
plot3(sensor1(1,:), sensor1(2,:), sensor1(3,:))
plot3(sensor2(1,:), sensor2(2,:), sensor2(3,:))
plot3(sensor3(1,:), sensor3(2,:), sensor3(3,:))
plot3(sensor4(1,:), sensor4(2,:), sensor4(3,:))
plot3(sensor5(1,:), sensor5(2,:), sensor5(3,:))
plot3(sensor6(1,:), sensor6(2,:), sensor6(3,:))
plot3(sensor7(1,:), sensor7(2,:), sensor7(3,:))
plot3(sensor8(1,:), sensor8(2,:), sensor8(3,:))
plot3(sensor9(1,:), sensor9(2,:), sensor9(3,:))
plot3(sensor10(1,:), sensor10(2,:), sensor10(3,:))

xlim([-10 10])
ylim([-10 10])
zlim([-1  19])
hold off;
      
      