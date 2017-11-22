function [ pitch_thrust_target ] = rate_target_to_motor_pitch( gyro_latest_y, rate_target_ang_vel_y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    global pitch_rate_error_rads 
    global pitch_rate_derivative pitch_rate_derivative_last pitch_rate_kD
    global pitch_rate_integrator pitch_rate_imax pitch_rate_kI 
    global pitch_rate_proportional pitch_rate_kP
    global limit_roll_pitch pitch_rate_filt_hz dt
    
    %% Calculate Error
    pitch_rate_error_rads = rate_target_ang_vel_y - gyro_latest_y;

    %% Pass error to PID controller - get_rate_pitch_pid().set_input_filter_d(pitch_rate_error_rads);

    % Update filter and calculate derivative
    derivative = (pitch_rate_error_rads - pitch_rate_derivative_last) / dt;
    rc = 1/(2*pi*pitch_rate_filt_hz);
    pitch_rate_derivative = pitch_rate_derivative + (dt / (dt + rc)) * (derivative - pitch_rate_derivative);
    pitch_rate_derivative_last = pitch_rate_error_rads;
    
    %get_rate_pitch_pid().set_desired_rate(rate_target_ang_vel_x) 
    %I think this is only for logging purposes
    
    %% Ensure that integrator can only be reduced if the output is saturated
   
    integrator = pitch_rate_integrator;

    if limit_roll_pitch == 0 || (integrator > 0 && pitch_rate_error_rads < 0) || (integrator < 0 && pitch_rate_error_rads > 0) 
        
        %integrator = get_rate_pitch_pid().get_i();  
        
        if (pitch_rate_kI > 0 && dt > 0)
        
            pitch_rate_integrator = pitch_rate_integrator + ((pitch_rate_derivative_last * pitch_rate_kI) * dt);
            
            if (pitch_rate_integrator < -pitch_rate_imax) 
                
                pitch_rate_integrator = -pitch_rate_imax;
             
            elseif (pitch_rate_integrator > pitch_rate_imax) 
            
                pitch_rate_integrator = pitch_rate_imax;
            
            end
            
            integrator = pitch_rate_integrator;
        
        else
            integrator = 0;
        end
    
    end
    
    %% Get Proportional Component
    pitch_rate_proportional = pitch_rate_kP * pitch_rate_derivative_last;
    
    %% Compute output in range -1 ~ +1
    pitch_thrust_target = pitch_rate_proportional + integrator; + pitch_rate_derivative*pitch_rate_kD;
    pitch_thrust_target = math_constrain_value(pitch_thrust_target, -1.0, 1.0);
    
end

