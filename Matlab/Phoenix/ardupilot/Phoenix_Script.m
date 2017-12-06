clear all
init_global_variables

plotEnable          = 1;
plotRateTargets     = 1;
plotAngles          = 1;
plotInputs          = 0;
plotRCOut           = 0;
plotDelta           = 1;
plotLength          = 30;                            %Seconds
global dt
dt = 0.01;
dataSize = plotLength/dt;

pilot_throttle_in       = 1750.0;                %Good Question, I think it's just a 0 - 1 of 1000 - 2000 where 1500 = hover
pilot_roll_in           = 1500.0;                %Centidegrees
pilot_pitch_in          = 1500.0;                %Centidegrees
pilot_yaw_in            =    0.0;                %Centidegrees/s

roll_angle_latest       =    0.0;                %Centidegrees
pitch_angle_latest      =    0.0;                %Centidegrees
yaw_angle_latest        =    0.0;                %Centidegrees/s

global throttle_in
throttle_in             = 0.75;                 %Most Recent Throttle Command,      0 -> 1.

%% Rate Controller Variables
gyro_latest_x           = 0;                  %Current Roll Rotational Speed,     rad/s
%roll_rate_target        = 2.0;                  %Desired Roll Rotational Speed      rad/s  

gyro_latest_y           = 0;                  %Current Pitch Rotational Speed     rad/s
%pitch_rate_target       = 0.2;                  %Desired Pitch Rotational Speed     rad/s 

gyro_latest_z           = 0;                  %Current Yaw Rotational Speed       rad/s
%yaw_rate_target         = 0.2;                  %Desired Yaw Rotational Speed       rad/s

roll_thrust_target_in   = 0.0;                  %Roll Rate Controller Output Targets     -1 -> +1
pitch_thrust_target_in  = 0.0;                  %Pitch Rate Controller Output Targets     -1 -> +1
yaw_thrust_target_in    = 0.0;                  %Yaw Rate Controller Output Targets     -1 -> +1

roll_thrust_target      = roll_thrust_target_in;
pitch_thrust_target     = pitch_thrust_target_in;
yaw_thrust_target       = yaw_thrust_target_in;
    
for i = 1:dataSize    

    %% Attitude Controller
    
     [roll_attitude_target, pitch_attitude_target] = get_pilot_desired_lean_angles(pilot_roll_in, pilot_pitch_in);
     yaw_rate_target = get_pilot_desired_yaw_rate(pilot_yaw_in);
     pilot_throttle_scaled = get_pilot_desired_throttle(pilot_throttle_in);
     throttle_in = pilot_throttle_scaled;
      
    [roll_rate_target, pitch_rate_target, yaw_rate_target] = input_euler_angle_roll_pitch_euler_rate_yaw(roll_attitude_target, pitch_attitude_target, yaw_rate_target, roll_angle_latest, pitch_angle_latest, yaw_angle_latest, gyro_latest_z);
%      [throttle_in, throttle_avg_max] = set_throttle_out(pilot_throttle_scaled)
    
    %% Rate Controller
    update_throttle_rpy_mix();
    
    roll_thrust_target  = rate_target_to_motor_roll( gyro_latest_x, roll_rate_target );
    pitch_thrust_target = rate_target_to_motor_pitch( gyro_latest_y, pitch_rate_target );
    yaw_thrust_target   = rate_target_to_motor_yaw( gyro_latest_z, yaw_rate_target );
    
    %% Motor Mixer
    throttle_out = update_throttle_filter(throttle_in);

    thrust_rpyt_out_plot = output_armed_stabilizing(roll_thrust_target, pitch_thrust_target, yaw_thrust_target);

    rcout_1(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(1));
    rcout_2(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(2));
    rcout_3(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(3));
    rcout_4(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(4));

    
    %% Close the Rate loop
    if gyro_latest_x - roll_rate_target > 0
        gyro_latest_x = gyro_latest_x - 0.002;
    elseif gyro_latest_x - roll_rate_target < 0
        gyro_latest_x = gyro_latest_x + 0.002;
    else
    end

    if gyro_latest_y - pitch_rate_target > 0
        gyro_latest_y = gyro_latest_y - 0.002;
    elseif gyro_latest_y - pitch_rate_target < 0
        gyro_latest_y = gyro_latest_y + 0.002;
    else
    end

    if gyro_latest_z - yaw_rate_target > 0
        gyro_latest_z = gyro_latest_z - 0.002;
    elseif gyro_latest_z - yaw_rate_target < 0
        gyro_latest_z = gyro_latest_z + 0.002;
    else
    end
    
    
    
    %% Close the Attitude loop
    roll_angle_latest   = roll_angle_latest + rad2deg(gyro_latest_x)*dt
    pitch_angle_latest  = pitch_angle_latest + rad2deg(gyro_latest_y)*dt;
    yaw_angle_latest    = yaw_angle_latest + rad2deg(gyro_latest_z)*dt;

    %     if roll_angle_latest - roll_attitude_target > 0
%         roll_angle_latest = roll_angle_latest - 0.002;
%     elseif gyro_latest_x - roll_attitude_target < 0
%         roll_angle_latest = roll_angle_latest + 0.002;
%     else
%     end
% 
%     if pitch_angle_latest - pitch_attitude_target > 0
%         pitch_angle_latest = pitch_angle_latest - 10;
%     elseif pitch_angle_latest - pitch_attitude_target < 0
%         pitch_angle_latest = pitch_angle_latest + 10;
%     else
%     end

    %% Save Values for plotting
    throttle_value(i)              = throttle_in;                          %Used for plot
    roll_attitude_target_value(i)  = roll_attitude_target;                 %Used for plot
    pitch_attitude_target_value(i) = pitch_attitude_target;                %Used for plot
     
    roll_angle_latest_value(i)  = roll_angle_latest;
    pitch_angle_latest_value(i) = pitch_angle_latest;
    yaw_angle_latest_value(i)   = yaw_angle_latest;
    
    roll_rate_target_value(i)   = roll_rate_target;
    pitch_rate_target_value(i)  = pitch_rate_target;
    yaw_rate_target_value(i)    = yaw_rate_target;
    
    gyro_latest_x_value(i) = gyro_latest_x;
    gyro_latest_y_value(i) = gyro_latest_y;
    gyro_latest_z_value(i) = gyro_latest_z;
    
    throttle_out_value(i) = throttle_out;
end

%% Plots
if plotRateTargets == 1 || plotEnable == 'All'
    figure;
    
    subplot(3, 1, 1);
    title('Roll Rate Target');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees/Second')
%     ylim([-2000, 2000])
    xlim([-1, ((length(roll_rate_target_value))*dt) + 1])
    plot((1:length(roll_rate_target_value))*dt, roll_rate_target_value);
    hold off;
    
    subplot(3, 1, 2);
    title('Pitch Rate Target');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees/Second')
%     ylim([-2000, 2000])
    xlim([-1, ((length(pitch_rate_target_value))*dt) + 1])
    plot((1:length(pitch_rate_target_value))*dt, pitch_rate_target_value);
    hold off;
    
    subplot(3, 1, 3);
    title('Yaw Rate Target');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees/Second')
%     ylim([-2000, 2000])
    xlim([-1, ((length(yaw_rate_target_value))*dt) + 1])
    plot((1:length(yaw_rate_target_value))*dt, yaw_rate_target_value);
    hold off;
end

if plotAngles == 1 || plotEnable == 'All'
    figure;
    
    subplot(3, 1, 1);
    title('Roll Angle');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees')
%     ylim([-2000, 2000])
    xlim([-1, ((length(roll_angle_latest_value))*dt) + 1])
    plot((1:length(roll_angle_latest_value))*dt, roll_angle_latest_value);
    hold off;
    
    subplot(3, 1, 2);
    title('Pitch Angle');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees')
%     ylim([-2000, 2000])
    xlim([-1, ((length(pitch_angle_latest_value))*dt) + 1])
    plot((1:length(pitch_angle_latest_value))*dt, pitch_angle_latest_value);
    hold off;
    
    subplot(3, 1, 3);
    title('Yaw Angle');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees')
%     ylim([-2000, 2000])
    xlim([-1, ((length(yaw_angle_latest_value))*dt) + 1])
    plot((1:length(yaw_angle_latest_value))*dt, yaw_angle_latest_value);
    hold off;
end

%% Plot System Inputs
if (plotInputs == 1) || (plotEnable == 'All')
    figure;

    subplot(2, 1, 1);
    title('Throttle In');
    hold on;
    xlabel('Seconds');
    ylabel('Percentage')
    ylim([-10, 110])
    xlim([-1, ((length(throttle_value))*dt) + 1])
    plot((1:length(throttle_value))*dt, throttle_value*100);
    hold off;
    
    subplot(2, 1, 2);
    title('Throttle Out');
    hold on;
    xlabel('Seconds');
    ylabel('Percentage')
    ylim([-10, 110])
    xlim([-1, ((length(throttle_out_value))*dt) + 1])
    plot((1:length(throttle_out_value))*dt, throttle_out_value*100);
    hold off;
    
    figure;
    subplot(3, 1, 1);
    title('Roll In');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees')
    ylim([-2000, 2000])
    xlim([-1, ((length(roll_attitude_target_value))*dt) + 1])
    plot((1:length(roll_attitude_target_value))*dt, roll_attitude_target_value);
    hold off;
    
    subplot(3, 1, 2);
    title('Pitch In');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees')
    ylim([1000, 2000])
    xlim([-1, ((length(pitch_attitude_target_value))*dt) + 1])
    plot((1:length(pitch_attitude_target_value))*dt, pitch_attitude_target_value);
    hold off;
    
    subplot(3, 1, 3);
    title('Yaw In');
    hold on;
    xlabel('Seconds');
    ylabel('Centidegrees/Second')
    ylim([-100, 100])
    xlim([-1, ((length(yaw_rate_target_value))*dt) + 1])
    plot((1:length(yaw_rate_target_value))*dt, yaw_rate_target_value);
    hold off;
    
end

%% Plot RC Out Values
if plotRCOut == 1 || plotEnable == 'All'
    figure;
    
    subplot(2, 2, 1);
    title('RCOUT1');
    hold on;
    xlabel('Seconds');
    ylabel('Servo Value')
    ylim([1000, 2000])
    xlim([-1, ((length(rcout_1))*dt) + 1])
    plot((1:length(rcout_1))*dt, rcout_1);
    hold off;
    
    subplot(2, 2, 2);
    title('RCOUT2');
    hold on;
    xlabel('Seconds');
    ylabel('Servo Value')
    ylim([1000, 2000])
    xlim([-1, ((length(rcout_2))*dt) + 1])
    plot((1:length(rcout_2))*dt, rcout_2);
    hold off;
 
    subplot(2, 2, 3);
    title('RCOUT3');
    hold on;
    xlabel('Seconds');
    ylabel('Servo Value')
    ylim([1000, 2000])
    xlim([-1, ((length(rcout_3))*dt) + 1])
    plot((1:length(rcout_3))*dt, rcout_3);
    hold off;
    
    subplot(2, 2, 4);
    title('RCOUT4');
    hold on;
    xlabel('Seconds');
    ylabel('Servo Value')
    ylim([1000, 2000])
    xlim([-1, ((length(rcout_4))*dt) + 1])
    plot((1:length(rcout_4))*dt, rcout_4);
    hold off;
    
end

%% Plot Deltas between Servo Values
if plotDelta == 1 || plotEnable == 'All'
    deltaRoll   = rcout_2 + rcout_3 - rcout_1 - rcout_4;
    deltaPitch  = rcout_1 + rcout_3 - rcout_2 - rcout_4;
    deltaYaw    = rcout_1 + rcout_2 - rcout_3 - rcout_4;
    
    maxDeltas   = [max(deltaRoll), max(deltaPitch), max(deltaYaw)];
    maxDelta    = max(maxDeltas) + 50;
    
    minDeltas   = [min(deltaRoll), min(deltaPitch), min(deltaYaw)];
    minDelta    = min(minDeltas) - 50;
    
    figure;
    title('Delta Roll Servo Values');
    hold on;
    xlabel('Seconds');
    ylabel('Delta Servo Values')
    ylim([minDelta, maxDelta])
    xlim([-1, ((length(rcout_2))*dt) + 1]);
    plot((1:length(rcout_4))*dt, (rcout_2 + rcout_3 - rcout_1 - rcout_4) );
    hold off;    

    figure;
    title('Delta Pitch Servo Values');
    hold on;
    xlabel('Seconds');
    ylabel('Delta Servo Values')
    ylim([minDelta, maxDelta])
    xlim([-1, ((length(rcout_2))*dt) + 1]);
    plot((1:length(rcout_4))*dt, (rcout_1 + rcout_3 - rcout_2 - rcout_4) );
    hold off;    

    figure;
    title('Delta Yaw Servo Values');
    hold on;
    xlabel('Seconds');
    ylabel('Delta Servo Values')
    ylim([minDelta, maxDelta])
    xlim([-1, ((length(rcout_2))*dt) + 1])
    plot((1:length(rcout_4))*dt, (rcout_1 + rcout_2 - rcout_3 - rcout_4) );
    hold off;    

end        
