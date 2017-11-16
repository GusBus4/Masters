function [ roll_thrust_target ] = rate_target_to_motor_roll( gyro_latest_x, rate_target_ang_vel_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %% Calculate Error
    rate_target_error_rads = rate_target_ang_vel_x - gyro_latest_x;

    %% Pass error to PID controller (void AC_PID::set_input_filter_d(float input))
    
    %get_rate_roll_pid().set_input_filter_d(rate_target_error_rads);

    %update filter and calculate derivative
    if (dt > 0.0) 
        
        derivative = (input - _input) / dt;
        derivative = _derivative + get_filt_alpha() * (derivative-_derivative);
    
    end

    _input = input;

    %get_rate_roll_pid().set_desired_rate(rate_target_ang_vel_x);
   
    roll_rate_I = get_rate_roll_pid().get_integrator();

    %% Ensure that integrator can only be reduced if the output is saturated
    if (motors.limit.roll_pitch == 0 || ((roll_rate_I > 0 && rate_error_rads < 0) || (roll_rate_I < 0 && rate_error_rads > 0))) 

        roll_rate_I = get_rate_roll_pid().get_i();
        
    end

    %% Compute output in range -1 ~ +1
    roll_thrust_target = roll_rate_P + roll_rate_I + roll_rate_D;
    
    roll_thrust_target = math_constrain_value(roll_thrust_target, -1.0, 1.0);
    
end

