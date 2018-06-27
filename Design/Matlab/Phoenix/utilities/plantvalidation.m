clc;
close all;

% init_phoenix_values;

plotEnableForces                = 0;
plotEnableRotationalVelocity    = 0;
plotEnableLeanAngles            = 0;
plotEnableGlobalAcceleration    = 0;
plotEnableBodyAcceleration      = 1;
plotEnableLinearVelocity        = 0;
plotEnableGlobalPosition        = 0;
plotEnableDragForces            = 0;
plotMotorThrust                 = 0;
plotTorqeRequest                = 0;

p = bodeoptions;
p.Phasewrapping = 'on';
t = linspace(0,tout(end),length(euler_angles_rad))';

%% Plot Moments and Forces
if plotEnableForces == 1
    figure
    subplot(3,1,1)
    plot(t,moments(:,1))
    xlabel('tout in seconds')
    ylabel('Roll Moment')
    title('Moments and Forces')
    subplot(3,1,2)
    plot(t,moments(:,2))
    xlabel('tout in seconds')
    ylabel('Pitch moment')
    subplot(3,1,3)
    plot(t,moments(:,3))
    xlabel('tout in seconds')
    ylabel('Yaw Moment')
end

%% Plot Rotational Velocity
if plotEnableRotationalVelocity == 1
    figure
    subplot(3,1,1)
    plot(t,body_rotational_velocity(:,1),t,refrollrate)
    xlabel('tout in seconds')
    ylabel('Roll Angular Rate in rad/s')
    legend('roll','reference roll')
    title('Lean Rates')
    subplot(3,1,2)
    plot(t,body_rotational_velocity(:,2),t,refpitchrate)
    xlabel('tout in seconds')
    ylabel('Pitch Angular Rate in rad/s')
    legend('pitch','reference pitch')
    subplot(3,1,3)
    plot(t,body_rotational_velocity(:,3),t,refyawrate)
    xlabel('tout in seconds')
    ylabel('Yaw Angular Rate in rad/s')
    legend('yaw','reference yaw')
end

  %% Plot Lean Angles
if plotEnableLeanAngles == 1
    figure
    subplot(3,1,1)
    plot(t,euler_angles_rad(:,1))
    xlabel('tout in seconds')
    ylabel('Roll in rad')
    legend('roll')
    title('Lean angles')
    subplot(3,1,2)
    plot(t,euler_angles_rad(:,2))
    xlabel('tout in seconds')
    ylabel('Pitch in rad')
    legend('pitch')
    subplot(3,1,3)
    plot(t,euler_angles_rad(:,3))
    xlabel('tout in seconds')
    ylabel('Yaw in rad')
    legend('yaw')
end

  %% Plot Linear Acceleration
if plotEnableGlobalAcceleration == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t, earth_linear_acceleration(:,1), t, refxaccel);
    legend('x', 'xref');
    xlabel('tout in seconds');
    ylabel('Earth linear Accel X');
    title('Linear Acceleration');
    subplot(3,1,2);
    plot(t, earth_linear_acceleration(:,2), t, refyaccel);
    legend('y', 'yref')
    xlabel('tout in seconds');
    ylabel('Earth linear Accel Y');
    subplot(3,1,3);
    plot(t, earth_linear_acceleration(:,3), t, refzaccel);
    legend('z', 'zref')
    xlabel('tout in seconds');
    ylabel('Earth linear Accel Z');
    hold off;
end

  %% Plot Body Acceleration
if plotEnableBodyAcceleration == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t, accelerometer_readings.data(:,1), t, refxaccel);
    legend('x', 'xref');
    xlabel('tout in seconds');
    ylabel('Body linear Accel X');
    title('Body Linear Acceleration');
    subplot(3,1,2);
    plot(t, accelerometer_readings.data(:,2), t, refyaccel);
    legend('y', 'yref')
    xlabel('tout in seconds');
    ylabel('Body linear Accel Y');
    subplot(3,1,3);
    plot(t, accelerometer_readings.data(:,3), t, refzaccel);
    legend('z', 'zref')
    xlabel('tout in seconds');
    ylabel('Body linear Accel Z');
    hold off;
end

    %% Plot Global Velocity
if plotEnableLinearVelocity == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t,earth_linear_velocity(:,1),t, refxvel_e, 'Linewidth', 1.5);
    legend('N', 'Nref');
    xlabel('tout in seconds');
    ylabel('Earth linear velocity North');
    title('Global Velocity');
    subplot(3,1,2);
    plot(t,earth_linear_velocity(:,2), t, refyvel_e, 'Linewidth', 1.5);
    legend('E', 'Eref')
    xlabel('tout in seconds');
    ylabel('Earth linear velocity East');
    subplot(3,1,3);
    plot(t,earth_linear_velocity(:,3), t, refzvel_e, 'Linewidth', 1.5);
    legend('D', 'Dref')
    xlabel('tout in seconds');
    ylabel('Earth linear velocity Down');
    hold off;
end

    %% Plot Global Position
if plotEnableGlobalPosition == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t,earth_linear_position(:,1),t, refxpos, 'Linewidth', 1.5);
    legend('N', 'Nref');
    xlabel('tout in seconds');
    ylabel('Earth linear position North');
    title('Global Position');
    subplot(3,1,2);
    plot(t,earth_linear_position(:,2), t, refypos, 'Linewidth', 1.5);
    legend('E', 'Eref')
    xlabel('tout in seconds');
    ylabel('Earth linear position East');
    subplot(3,1,3);
    plot(t,earth_linear_position(:,3), t, refzpos, 'Linewidth', 1.5);
    legend('D', 'Dref')
    xlabel('tout in seconds');
    ylabel('Earth linear position Down');
    hold off;
end

if plotEnableDragForces == 1
    %% Plot Drag Forces
    figure;
    subplot(3, 1, 1);
    plot(drag_body_force.time(:, 1), drag_body_force.data(:, 1))
    xlabel('Time')
    ylabel('X')
    title('Drag Body Forces')
    subplot(3, 1, 2);
    plot(drag_body_force.time(:, 1), drag_body_force.data(:, 2))
    xlabel('Time')
    ylabel('Y')
    subplot(3, 1, 3);
    plot(drag_body_force.time(:, 1), drag_body_force.data(:, 3))
    xlabel('Time')
    ylabel('Z')
end

if plotMotorThrust == 1
    %% Plot Motor Thrusts
    figure;
    subplot(2, 2, 2);
    plot(motor_thrust.time(:, 1), motor_thrust.data(:, 1))
    ylim([-15, 0.1]);
    xlabel('Time')
    ylabel('Newtons')
    title('Motor 1 Thrust')
    subplot(2, 2, 3);
    plot(motor_thrust.time(:, 1), motor_thrust.data(:, 2))
    ylim([-15, 0.1]);
    xlabel('Time')
    ylabel('Newtons')
    title('Motor 2 Thrust')
    subplot(2, 2, 1);
    plot(motor_thrust.time(:, 1), motor_thrust.data(:, 3))
    ylim([-15, 0.1]);
    xlabel('Time')
    ylabel('Newtons')
    title('Motor 3 Thrust')    
    subplot(2, 2, 4);
    plot(motor_thrust.time(:, 1), motor_thrust.data(:, 4))
    ylim([-15, 0.1]);
    xlabel('Time')
    ylabel('Newtons')
    title('Motor 4 Thrust')
end

if plotTorqeRequest == 1
    %% Plot Motor Thrusts
    figure;
    subplot(3, 1, 1);
    plot(torque_requests.time(:, 1), torque_requests.data(:, 1))
    ylim([-2, 2]);
    xlabel('Time')
    title('Roll Moment (L) Request')
    
    subplot(3, 1, 2);
    plot(torque_requests.time(:, 1), torque_requests.data(:, 2))
    ylim([-2, 2]);
    xlabel('Time')
    title('Pitch Moment (M) Request')
    
    subplot(3, 1, 3);
    plot(torque_requests.time(:, 1), torque_requests.data(:, 3))
    ylim([-2, 2]);
    xlabel('Time')
    title('Yaw Moment (N) Request') 
end



















