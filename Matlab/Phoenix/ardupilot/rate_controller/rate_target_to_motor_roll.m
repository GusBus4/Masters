function [ roll_thrust_target ] = rate_target_to_motor_roll( gyro_latest_x, rate_target_ang_vel_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    global roll_rate_error_rads 
    global roll_rate_derivative roll_rate_derivative_last roll_rate_kD
    global roll_rate_integrator roll_rate_imax roll_rate_kI 
    global roll_rate_proportional roll_rate_kP
    global limit_roll_pitch roll_rate_filt_hz dt
    
    %% Calculate Error
    roll_rate_error_rads = rate_target_ang_vel_x - gyro_latest_x;

    %% Pass error to PID controller - get_rate_roll_pid().set_input_filter_d(roll_rate_error_rads);

    % Update filter and calculate derivative
    derivative = (roll_rate_error_rads - roll_rate_derivative_last) / dt;
    rc = 1/(2*pi*roll_rate_filt_hz);
    roll_rate_derivative = roll_rate_derivative + (dt / (dt + rc)) * (derivative - roll_rate_derivative);
    roll_rate_derivative_last = roll_rate_error_rads;
    
    %get_rate_roll_pid().set_desired_rate(rate_target_ang_vel_x) 
    %I think this is only for logging purposes
    
    %% Ensure that integrator can only be reduced if the output is saturated
   
    integrator = roll_rate_integrator;

    if limit_roll_pitch == 0 || (integrator > 0 && roll_rate_error_rads < 0) || (integrator < 0 && roll_rate_error_rads > 0) 
        
        %integrator = get_rate_roll_pid().get_i();  
        
        if (roll_rate_kI > 0 && dt > 0)
        
            roll_rate_integrator = roll_rate_integrator + ((roll_rate_derivative_last * roll_rate_kI) * dt);
            
            if (roll_rate_integrator < -roll_rate_imax) 
                
                roll_rate_integrator = -roll_rate_imax;
             
            elseif (roll_rate_integrator > roll_rate_imax) 
            
                roll_rate_integrator = roll_rate_imax;
            
            end
            
            integrator = roll_rate_integrator;
        
        else
            integrator = 0;
        end
    
    end
    
    %% Get Proportional Component
    roll_rate_proportional = roll_rate_kP * roll_rate_derivative_last;
    
    %% Compute output in range -1 ~ +1
    roll_thrust_target = roll_rate_proportional + integrator + roll_rate_derivative*roll_rate_kD;
    roll_thrust_target = math_constrain_value(roll_thrust_target, -1.0, 1.0);
    
end

