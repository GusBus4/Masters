%% Plot North Flight
x = zeros(length(tout), 1) + 10;
figure;
hold on;
plot(tout, earth_linear_position_no_noise(:,1), 'LineWidth', 2);
plot(tout, x, 'k--', 'LineWidth', 2);
plot(tout, waypoints(:, 1), 'r', 'LineWidth', 2);
ylabel('North Position', 'FontSize', 20)
xlabel('Time', 'FontSize', 20)
grid on;
grid minor;
hold off;

%% Plot East
figure;
hold on;
plot(tout, earth_linear_position_no_noise(:,2), 'LineWidth', 2);
plot(tout, waypoints(:, 2), 'r', 'LineWidth', 2);
ylabel('East Position', 'FontSize', 20)
xlabel('Time','FontSize', 20)
grid on;
grid minor;
hold off;

%% Plot Down
figure;
for i = 1:length(earth_linear_position_no_noise(:,3))
    if earth_linear_position_no_noise(i,3) > 0
        earth_linear_position_no_noise(i,3) = 0;
    end
end
hold on;
plot(tout, earth_linear_position_no_noise(:,3), 'LineWidth', 2);
plot(tout, waypoints(:, 3), 'r', 'LineWidth', 2);
ylabel('Down Position', 'FontSize', 20)
xlabel('Time', 'FontSize', 20)
grid on;
grid minor;
hold off;

% Plot Proximity Vector
figure;
plot(1:length(proximity_vector1(:, 1)), proximity_vector1(:,1), 'LineWidth', 2);
ylabel('North Velocity Command', 'FontSize', 20)
% xlabel('Time')
grid on;
grid minor;
set(gca,'xtick',[])
set(gca,'xticklabel',[])

figure;
plot(1:length(proximity_vector1(:, 2)), proximity_vector1(:,2), 'LineWidth', 2);
ylabel('East Velocity Command', 'FontSize', 20)
% xlabel('Time')
grid on;
grid minor;
set(gca,'xtick',[])
set(gca,'xticklabel',[])

figure;
plot(1:length(proximity_vector1(:, 3)), proximity_vector1(:,3), 'LineWidth', 2);
ylabel('Down velocity Command', 'FontSize', 20)
% xlabel('Time')
grid on;
grid minor;
set(gca,'xtick',[])
set(gca,'xticklabel',[])


figure;
plot(1:length(yaw_angle_error(:)), yaw_angle_error(:), 'LineWidth', 2);
ylabel('Yaw Angle Error', 'FontSize', 20)
% xlabel('Time')
grid on;
grid minor;
set(gca,'xtick',[])
set(gca,'xticklabel',[])
