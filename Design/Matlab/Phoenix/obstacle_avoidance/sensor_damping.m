figure;

current_pos_n = 10;                                                          
current_pos_e = -10;                                                          
current_yaw = deg2rad(0);

dcm_earth_to_body = angle2dcm(0,0,current_yaw, 'XYZ');

init_sensors_2d;
init_environment_2d;

body_velocity = [1 1];  % N, E

hold on;
plot([current_pos_body_y; (current_pos_body_y + body_velocity(2))], [current_pos_body_x; (current_pos_body_x + body_velocity(1))], 'c', 'LineWidth', 2)
hold off;


%% Calculate the veolcity along each sensing axis
body_velocity_unit_vector = body_velocity/norm(body_velocity)

sensor1_vector = [sensor_max_range 0]/norm([sensor_max_range 0])
sensor2_vector = [-sensor_max_range 0]/norm([-sensor_max_range 0])
sensor3_vector = [0 sensor_max_range]/norm([0 sensor_max_range])
sensor4_vector = [0 -sensor_max_range]/norm([0 -sensor_max_range])

sensor5_vector = [sensor_max_range*sin(deg2rad(45)) sensor_max_range*cos(deg2rad(45))]/norm([sensor_max_range*sin(deg2rad(45)) sensor_max_range*cos(deg2rad(45))])
sensor6_vector = [-sensor_max_range*sin(deg2rad(45)) -sensor_max_range*cos(deg2rad(45))]/norm([-sensor_max_range*sin(deg2rad(45)) -sensor_max_range*cos(deg2rad(45))])
sensor7_vector = [sensor_max_range*sin(deg2rad(45)) -sensor_max_range*cos(deg2rad(45))]/norm([sensor_max_range*sin(deg2rad(45)) -sensor_max_range*cos(deg2rad(45))])
sensor8_vector = [-sensor_max_range*sin(deg2rad(45)) sensor_max_range*cos(deg2rad(45))]/norm([-sensor_max_range*sin(deg2rad(45)) sensor_max_range*cos(deg2rad(45))])

angle_between_sensor1 = acos(dot((body_velocity_unit_vector), (sensor1_vector)))
angle_between_sensor2 = acos(dot((body_velocity_unit_vector), (sensor2_vector)))
angle_between_sensor3 = acos(dot((body_velocity_unit_vector), (sensor3_vector)))
angle_between_sensor4 = acos(dot((body_velocity_unit_vector), (sensor4_vector)))
angle_between_sensor5 = acos(dot((body_velocity_unit_vector), (sensor5_vector)))
angle_between_sensor6 = acos(dot((body_velocity_unit_vector), (sensor6_vector)))
angle_between_sensor7 = acos(dot((body_velocity_unit_vector), (sensor7_vector)))
angle_between_sensor8 = acos(dot((body_velocity_unit_vector), (sensor8_vector)))

velocity_along_sensor1_axis = norm(body_velocity) * cos(angle_between_sensor1)
velocity_along_sensor2_axis = norm(body_velocity) * cos(angle_between_sensor2)
velocity_along_sensor3_axis = norm(body_velocity) * cos(angle_between_sensor3)
velocity_along_sensor4_axis = norm(body_velocity) * cos(angle_between_sensor4)
velocity_along_sensor5_axis = norm(body_velocity) * cos(angle_between_sensor5)
velocity_along_sensor6_axis = norm(body_velocity) * cos(angle_between_sensor6)
velocity_along_sensor7_axis = norm(body_velocity) * cos(angle_between_sensor7)
velocity_along_sensor8_axis = norm(body_velocity) * cos(angle_between_sensor8)

hold on;
plot([current_pos_body_y; current_pos_body_y], [current_pos_body_x; (current_pos_body_x + velocity_along_sensor1_axis)], 'y', 'LineWidth', 2)
plot([current_pos_body_y; current_pos_body_y], [current_pos_body_x; (current_pos_body_x - velocity_along_sensor2_axis)], 'y', 'LineWidth', 2)
plot([current_pos_body_y; (current_pos_body_y + velocity_along_sensor3_axis)], [current_pos_body_x; current_pos_body_x], 'y', 'LineWidth', 2)
plot([current_pos_body_y; (current_pos_body_y - velocity_along_sensor4_axis)], [current_pos_body_x; current_pos_body_x], 'y', 'LineWidth', 2)
% plot([current_pos_body_y; (current_pos_body_y - velocity_along_sensor4_axis)], [current_pos_body_x; current_pos_body_x], 'y', 'LineWidth', 2)
hold off;



xlim([-22 5])                                                               %East Limit
ylim([-5 22])   