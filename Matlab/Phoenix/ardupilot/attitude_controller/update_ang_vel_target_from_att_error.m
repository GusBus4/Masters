function [ rate_target_ang_vel_x, rate_target_ang_vel_y, rate_target_ang_vel_z ] = update_ang_vel_target_from_att_error( attitude_error_vector_x, attitude_error_vector_y, attitude_error_vector_z )
%UPDATE_ANG_VEL_TARGET_FROM_ATT_ERROR Summary of this function goes here
%   Detailed explanation goes here
    
    global use_ff_and_input_shaping roll_attitude_kP pitch_attitude_kP yaw_attitude_kP
    
    %% Compute the roll angular velocity demand from the roll angle error
    if (use_ff_and_input_shaping) 
        rate_target_ang_vel_x = roll_attitude_kP * attitude_error_vector_x;
        
        %rate_target_ang_vel.x = sqrt_controller(attitude_error_rot_vec_rad.x, _p_angle_roll.kP(), constrain_float(get_accel_roll_max_radss()/2.0f,  AC_ATTITUDE_ACCEL_RP_CONTROLLER_MIN_RADSS, AC_ATTITUDE_ACCEL_RP_CONTROLLER_MAX_RADSS));
    else
        rate_target_ang_vel_x = roll_attitude_kP * attitude_error_vector_x;
        
    end

    %% Compute the pitch angular velocity demand from the roll angle error
    if (use_ff_and_input_shaping) 
        rate_target_ang_vel_y = pitch_attitude_kP * attitude_error_vector_y;
        %rate_target_ang_vel.y = sqrt_controller(attitude_error_rot_vec_rad.y, _p_angle_pitch.kP(), constrain_float(get_accel_pitch_max_radss()/2.0f,  AC_ATTITUDE_ACCEL_RP_CONTROLLER_MIN_RADSS, AC_ATTITUDE_ACCEL_RP_CONTROLLER_MAX_RADSS));
    else
        rate_target_ang_vel_y = pitch_attitude_kP * attitude_error_vector_y;
    end

    %% Compute the yaw angular velocity demand from the roll angle error
    if (use_ff_and_input_shaping) 
        rate_target_ang_vel_z = yaw_attitude_kP * attitude_error_vector_z;
        %rate_target_ang_vel.z = sqrt_controller(attitude_error_rot_vec_rad.z, _p_angle_yaw.kP(), constrain_float(get_accel_yaw_max_radss()/2.0f,  AC_ATTITUDE_ACCEL_Y_CONTROLLER_MIN_RADSS, AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS));
    else
        rate_target_ang_vel_z = yaw_attitude_kP * attitude_error_vector_z;
    end
        

end

