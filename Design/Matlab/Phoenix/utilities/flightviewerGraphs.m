%% Plot North Flight
x = zeros(length(tout), 1) + 1;
figure;
hold on;
plot(tout, earth_linear_position_no_noise(:,1), 'b', 'LineWidth', 2);
% plot(fullrunalign_tout, fullrunalign_pos(:,1), 'b',  'LineWidth', 2);
plot(tout, waypoints(:, 1), 'r', 'LineWidth', 2);
% plot(simflightnowindtout, simflightnowind(:,1), 'g',  'LineWidth', 2);
% plot(fullrunnoalign_tout, fullrunnoalign_pos(:,1), 'g',  'LineWidth', 2);
% plot(tout, x, 'k--', 'LineWidth', 2);
plot(tout, waypoints(:, 1), 'r', 'LineWidth', 2);
ylabel('North Position (m)', 'FontSize', 20)
xlabel('Time (s)', 'FontSize', 20)

ax = gca;
ax.FontSize = 16;

grid on;
grid minor;
hold off;

%% Plot East
figure;
hold on;
plot(tout, earth_linear_position_no_noise(:,2), 'b', 'LineWidth', 2);
% plot(fullrunalign_tout, fullrunalign_pos(:,2), 'b',  'LineWidth', 2);
% plot(simflightnowindtout, simflightnowind(:,2), 'g',  'LineWidth', 2);
% plot(fullrunnoalign_tout, fullrunnoalign_pos(:,2), 'g',  'LineWidth', 2);
plot(tout, waypoints(:, 2), 'r', 'LineWidth', 2);
% plot(tout, x, 'k--', 'LineWidth', 2);
ylabel('East Position (m)', 'FontSize', 20)
xlabel('Time (s)','FontSize', 20)

ax = gca;
ax.FontSize = 16;

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
plot(tout, earth_linear_position_no_noise(:,3), 'b','LineWidth', 2);
% plot(fullrunalign_tout, fullrunalign_pos(:,3), 'b',  'LineWidth', 2);
% plot(simflightnowindtout, simflightnowind(:,3), 'g',  'LineWidth', 2);
% plot(fullrunnoalign_tout, fullrunnoalign_pos(:,3), 'g',  'LineWidth', 2);
plot(tout, waypoints(:, 3), 'r', 'LineWidth', 2);
ylabel('Down Position (m)', 'FontSize', 20)
xlabel('Time (s)', 'FontSize', 20)

ax = gca;
ax.FontSize = 16;

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

%% Plot Velocity Commands With proximity vector
figure;
hold on;
plot(1:length(PosVelocityCommands), PosVelocityCommands(:, 1), 'LineWidth', 2);
plot(1:length(proximity_vector2), proximity_vector2, 'LineWidth', 2);
plot(1:length(proximity_vector5), proximity_vector5, 'LineWidth', 2);
ylabel('Velocity Commands', 'FontSize', 20)
xlabel('Time')
grid on;
grid minor;
hold off;

figure;
hold on;
plot(1:length(PosVelocityCommands), PosVelocityCommands(:, 2),'b', 'LineWidth', 2);
plot(1:length(proximity_vector6), proximity_vector6, 'r', 'LineWidth', 2);
plot(1:length(proximity_vector3), proximity_vector3, 'g', 'LineWidth', 2);
ylabel('Velocity Commands', 'FontSize', 20)
xlabel('Time')
grid on;
ylim([-1, 1])
grid minor;
hold off;


