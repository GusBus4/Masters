close all;

% %% Plot 3D Flight
% figure;
% plot3(earth_linear_position(:,2), earth_linear_position(:,1), -earth_linear_position(:,3));
% xlabel('East')
% ylabel('North')
% zlabel('Altitude');
% ylim([-3 10]);
% xlim([-10 10]);
% zlim([-1 20]);
% grid on;
% grid minor;
% title('Global Position NEA')
% 
% %% Plot X and Y Positions
% figure;
% plot(earth_linear_position(:,2),earth_linear_position(:,1), 'LineWidth', 2.0)
% xlabel('East')
% ylabel('North')
% title('Global Position NE')
% % ylim([(min(earth_linear_position(:,1)) - 10) (max(earth_linear_position(:,1)) + 10)]);
% ylim([-20 20]);
% xlim([-20 20]);


%% Plot Wall
figure;
hold on;
view(3);
plot3(earth_linear_position(:,2), earth_linear_position(:,1), -earth_linear_position(:,3), 'LineWidth', 2);
plot3(waypoint_ned_data(:,2), waypoint_ned_data(:,1), -waypoint_ned_data(:,3), 'c-+', 'LineWidth', 2);
plot_wall(-1, 2, 0, 8, 2.2, 10)
plot_wall(-1, -2, 0, 8, -2.2, 10)
plot_wall(-1, -2.2, 0, -1.1, 2.2, 10)
grid on;
grid minor;
ylim([-3 10]);
xlim([-10 10]);
zlim([-1 20]);
xlabel('East')
ylabel('North')
zlabel('Altitude');
title('Global Position NEA')
hold off;