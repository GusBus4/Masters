clear all
init_global_variables

plotEnable = 0;
plotLength = 15;                            %Seconds
global dt
dt = 0.01;
dataSize = plotLength/dt;

pilot_throttle_in       = 1500;
pilot_roll_in           = 1500;
pilot_pitch_in          = 1500;
pilot_yaw_in            = 1500;

throttle_in             = 0.75;                 %Most Recent Throttle Command

gyro_latest_x           = 0.2;                  %Current Roll Rotational Speed
rate_target_ang_vel_x   = 0.1;                  %Desired Roll Rotational Speed        

gyro_latest_y           = 0.2;                  %Current Pitch Rotational Speed
rate_target_ang_vel_y   = 0.1;                  %Desired Pitch Rotational Speed

gyro_latest_z           = 0.2;                  %Current Yaw Rotational Speed
rate_target_ang_vel_z   = 0.1;                  %Desired Yaw Rotational Speed

roll_thrust_target_in   = 0.0;                  %Rate Controller Output Targets
pitch_thrust_target_in  = 0.0;
yaw_thrust_target_in    = 0.0;

roll_thrust_target   = roll_thrust_target_in;
pitch_thrust_target  = pitch_thrust_target_in;
yaw_thrust_target    = yaw_thrust_target_in;
    
for i = 1:dataSize    

    %% Attitude Controller
    
    
    
    
    
    %% Rate Controller
    update_throttle_rpy_mix();
    
    roll_thrust_target  = rate_target_to_motor_roll( gyro_latest_x, rate_target_ang_vel_x );
    pitch_thrust_target = rate_target_to_motor_pitch( gyro_latest_y, rate_target_ang_vel_y );
    yaw_thrust_target   = rate_target_to_motor_yaw( gyro_latest_z, rate_target_ang_vel_z );
    
    %% Motor Mixer
    update_throttle_filter(throttle_in);

    thrust_rpyt_out_plot = output_armed_stabilizing(roll_thrust_target, pitch_thrust_target, yaw_thrust_target);

    rcout_1(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(1));
    rcout_2(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(2));
    rcout_3(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(3));
    rcout_4(i) = pwm_min + (pwm_max-pwm_min)*(spin_min + (spin_max-spin_min)*thrust_rpyt_out_plot(4));

    
    %% Close the Rate loop
    if gyro_latest_x - rate_target_ang_vel_x > 0
        gyro_latest_x = gyro_latest_x - 0.002;
    elseif gyro_latest_x - rate_target_ang_vel_x < 0
        gyro_latest_x = gyro_latest_x + 0.002;
    else
    end

    if gyro_latest_y - rate_target_ang_vel_y > 0
        gyro_latest_y = gyro_latest_y - 0.002;
    elseif gyro_latest_y - rate_target_ang_vel_y < 0
        gyro_latest_y = gyro_latest_y + 0.002;
    else
    end

    if gyro_latest_z - rate_target_ang_vel_z > 0
        gyro_latest_z = gyro_latest_z - 0.002;
    elseif gyro_latest_z - rate_target_ang_vel_z < 0
        gyro_latest_z = gyro_latest_z + 0.002;
    else
    end 
end


if plotEnable == 1
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
    
    
    deltaRoll   = rcout_2 + rcout_3 - rcout_1 - rcout_4;
    deltaPitch  = rcout_1 + rcout_3 - rcout_2 - rcout_4;
    deltaYaw    = rcout_1 + rcout_2 - rcout_3 - rcout_4;
    
    maxDeltas   = [max(deltaRoll), max(deltaPitch), max(deltaYaw)];
    maxDelta    = max(maxDeltas) + 50;
    
    minDeltas   = [min(deltaRoll), min(deltaPitch), min(deltaYaw)];
    minDelta    = min(minDeltas) - 50;
    
    if(gyro_latest_x == rate_target_ang_vel_x) 
    else
        figure;
        title('Delta Roll Servo Values');
        hold on;
        xlabel('Seconds');
        ylabel('Delta Servo Values')
        ylim([minDelta, maxDelta])
        plot((1:length(rcout_4))*dt, (rcout_2 + rcout_3 - rcout_1 - rcout_4) );
        hold off;    
    end

    if(gyro_latest_y == rate_target_ang_vel_y) 
    else
        figure;
        title('Delta Pitch Servo Values');
        hold on;
        xlabel('Seconds');
        ylabel('Delta Servo Values')
        ylim([minDelta, maxDelta])
        plot((1:length(rcout_4))*dt, (rcout_1 + rcout_3 - rcout_2 - rcout_4) );
        hold off;    
    end
    
    if(gyro_latest_z == rate_target_ang_vel_z)
    else
        figure;
        title('Delta Yaw Servo Values');
        hold on;
        xlabel('Seconds');
        ylabel('Delta Servo Values')
        ylim([minDelta, maxDelta])
        plot((1:length(rcout_4))*dt, (rcout_1 + rcout_2 - rcout_3 - rcout_4) );
        hold off;    
    end    
end        
