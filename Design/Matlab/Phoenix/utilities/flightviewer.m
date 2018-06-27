%% Plot Flight
figure;
hold on;
view(3);

%% Plot World
for i = 0:0.1:roof
    plot3(wall_1(2, :), wall_1(1, :), [i i], 'r')
    plot3(wall_2(2, :), wall_2(1, :), [i i], 'r')
    plot3(wall_3(2, :), wall_3(1, :), [i i], 'r')
    plot3(wall_4(2, :), wall_4(1, :), [i i], 'r')
    plot3(wall_5(2, :), wall_5(1, :), [i i], 'r')
    plot3(wall_6(2, :), wall_6(1, :), [i i], 'r')
    plot3(wall_7(2, :), wall_7(1, :), [i i], 'r')
    plot3(wall_8(2, :), wall_8(1, :), [i i], 'r')
    plot3(wall_9(2, :), wall_9(1, :), [i i], 'r')
    plot3(wall_10(2, :), wall_10(1, :), [i i], 'r')
    plot3(wall_11(2, :), wall_11(1, :), [i i], 'r')
    plot3(wall_12(2, :), wall_12(1, :), [i i], 'r')
end

%% Plot Flight
plot3(earth_linear_position_no_noise(:,2), earth_linear_position_no_noise(:,1), -earth_linear_position_no_noise(:,3), 'LineWidth', 2);

%% Plot Waypoints
plot3(waypoint_ned_data(:,2), waypoint_ned_data(:,1), -waypoint_ned_data(:,3), 'c+', 'LineWidth', 6);
% plot3(-5, 5, 6, 'gx', 'LineWidth', 5);

%% Plot Proximity Vector
for i = 1:length(proximity_vector)
    plot3( [pv_position(i, 2) pv_position(i, 2) + proximity_vector(i, 2)], [pv_position(i, 1) pv_position(i, 1) + proximity_vector(i, 1)], [-pv_position(i, 3) -pv_position(i, 3) + proximity_vector(i, 3)], 'LineWidth', 2 )
end

%% Plot Heading Vector


% for i = 1:length(yaw_angle_target)
%     heading_vector = angle2dcm(0, 0, yaw_angle_target(i), 'XYZ')*[1;0;0];
%     plot3( [heading_position(i, 2) heading_position(i, 2) - heading_vector(2)], [heading_position(i, 1) heading_position(i, 1) + heading_vector(1)], [-heading_position(i, 3) -heading_position(i, 3) + heading_vector(3)], 'LineWidth', 2 )
% end

%% Set Plot Parameters
grid on;
grid minor;
xlim([-22 5])                                                               %East Limit
ylim([-5 22])                                                               %North Limit
zlim([-1 15]);
xlabel('East')
ylabel('North')
zlabel('Altitude');
title('Global Position NEA')
hold off;