function [ yaw_thrust_target ] = rate_target_to_motor_yaw( gyro_latest_z, rate_target_ang_vel_z )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    global yaw_rate_error_rads 
    global yaw_rate_derivative yaw_rate_derivative_last yaw_rate_kD
    global yaw_rate_integrator yaw_rate_imax yaw_rate_kI 
    global yaw_rate_proportional yaw_rate_kP
    global limit_yaw yaw_rate_filt_hz dt
    
    %% Calculate Error
    yaw_rate_error_rads = rate_target_ang_vel_z - gyro_latest_z;

    %% Pass error to PID contyawer - get_rate_yaw_pid().set_input_filter_d(yaw_rate_error_rads);

    % Update filter and calculate derivative
    derivative = (yaw_rate_error_rads - yaw_rate_derivative_last) / dt;
    rc = 1/(2*pi*yaw_rate_filt_hz);
    yaw_rate_derivative = yaw_rate_derivative + (dt / (dt + rc)) * (derivative - yaw_rate_derivative);
    yaw_rate_derivative_last = yaw_rate_error_rads;
    
    %get_rate_yaw_pid().set_desired_rate(rate_target_ang_vel_x) 
    %I think this is only for logging purposes
    
    %% Ensure that integrator can only be reduced if the output is saturated
   
    integrator = yaw_rate_integrator;

    if limit_yaw == 0 || (integrator > 0 && yaw_rate_error_rads < 0) || (integrator < 0 && yaw_rate_error_rads > 0) 
        
        %integrator = get_rate_yaw_pid().get_i();  
        
        if (yaw_rate_kI > 0 && dt > 0)
        
            yaw_rate_integrator = yaw_rate_integrator + ((yaw_rate_derivative_last * yaw_rate_kI) * dt);
            
            if (yaw_rate_integrator < -yaw_rate_imax) 
                
                yaw_rate_integrator = -yaw_rate_imax;
             
            elseif (yaw_rate_integrator > yaw_rate_imax) 
            
                yaw_rate_integrator = yaw_rate_imax;
            
            end
            
            integrator = yaw_rate_integrator;
        
        else
            integrator = 0;
        end
    
    end
    
    %% Get Proportional Component
    yaw_rate_proportional = yaw_rate_kP * yaw_rate_derivative_last;
    
    %% Compute output in range -1 ~ +1
    yaw_thrust_target = yaw_rate_proportional + integrator + yaw_rate_derivative*yaw_rate_kD;
    yaw_thrust_target = math_constrain_value(yaw_thrust_target, -1.0, 1.0);
    
end

