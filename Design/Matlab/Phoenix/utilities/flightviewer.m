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
end

%% Plot Flight
plot3(earth_linear_position_no_noise(:,2), earth_linear_position_no_noise(:,1), -earth_linear_position_no_noise(:,3), 'LineWidth', 2);

%% Plot Waypoints
plot3(waypoint_ned_data(:,2), waypoint_ned_data(:,1), -waypoint_ned_data(:,3), 'c+', 'LineWidth', 2);
% plot3(-5, 5, 6, 'gx', 'LineWidth', 5);

%% Set Plot Parameters
grid on;
grid minor;
ylim([-5 25]);
xlim([-15 15]);
zlim([-1 15]);
xlabel('East')
ylabel('North')
zlabel('Altitude');
title('Global Position NEA')
hold off;