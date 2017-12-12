function [ roll_rate_target, pitch_rate_target, yaw_rate_target ] = input_euler_angle_roll_pitch_euler_rate_yaw( roll_attitude_target, pitch_attitude_target, yaw_rate_target, roll_angle_latest, pitch_angle_latest, yaw_angle_latest, gyro_latest_z )
%     INPUT_EULER_ANGLE_ROLL_PITCH_EULER_RATE_YAW Summary of this function goes here
%     Detailed explanation goes here
%     attitude_control.input_euler_angle_roll_pitch_euler_rate_yaw(target_roll, target_pitch, target_yaw_rate, get_smoothing_gain());        
%     input_euler_angle_roll_pitch_euler_rate_yaw(float euler_roll_angle_cd, float euler_pitch_angle_cd, float euler_yaw_rate_cds, float smoothing_gain)

%     Convert from centidegrees on public interface to radians
%     float euler_roll_angle = radians(euler_roll_angle_cd*0.01f);
%     float euler_pitch_angle = radians(euler_pitch_angle_cd*0.01f);
%     float euler_yaw_rate = radians(euler_yaw_rate_cds*0.01f);
% 
%     // calculate the attitude target euler angles
%     _attitude_target_quat.to_euler(_attitude_target_euler_angle.x, _attitude_target_euler_angle.y, _attitude_target_euler_angle.z);
% 
%     // ensure smoothing gain can not cause overshoot
%     smoothing_gain = constrain_float(smoothing_gain,1.0f,1/_dt);
% 
%     // Add roll trim to compensate tail rotor thrust in heli (will return zero on multirotors)
%     euler_roll_angle += get_roll_trim_rad();
% 
%     if (_rate_bf_ff_enabled & _use_ff_and_input_shaping) {
%         // translate the roll pitch and yaw acceleration limits to the euler axis
%         Vector3f euler_accel = euler_accel_limit(_attitude_target_euler_angle, Vector3f(get_accel_roll_max_radss(), get_accel_pitch_max_radss(), get_accel_yaw_max_radss()));
% 
%         // When acceleration limiting and feedforward are enabled, the sqrt controller is used to compute an euler
%         // angular velocity that will cause the euler angle to smoothly stop at the input angle with limited deceleration
%         // and an exponential decay specified by smoothing_gain at the end.
%         _attitude_target_euler_rate.x = input_shaping_angle(euler_roll_angle-_attitude_target_euler_angle.x, smoothing_gain, euler_accel.x, _attitude_target_euler_rate.x);
%         _attitude_target_euler_rate.y = input_shaping_angle(euler_pitch_angle-_attitude_target_euler_angle.y, smoothing_gain, euler_accel.y, _attitude_target_euler_rate.y);
% 
%         // When yaw acceleration limiting is enabled, the yaw input shaper constrains angular acceleration about the yaw axis, slewing
%         // the output rate towards the input rate.
%         _attitude_target_euler_rate.z = input_shaping_ang_vel(_attitude_target_euler_rate.z, euler_yaw_rate, euler_accel.z);
% 
%         // Convert euler angle derivative of desired attitude into a body-frame angular velocity vector for feedforward
%         euler_rate_to_ang_vel(_attitude_target_euler_angle, _attitude_target_euler_rate, _attitude_target_ang_vel);
%     } else {
%         // When feedforward is not enabled, the target euler angle is input into the target and the feedforward rate is zeroed.
%         _attitude_target_euler_angle.x = euler_roll_angle;
%         _attitude_target_euler_angle.y = euler_pitch_angle;
%         _attitude_target_euler_angle.z += euler_yaw_rate*_dt;
%         // Compute quaternion target attitude
%         _attitude_target_quat.from_euler(_attitude_target_euler_angle.x, _attitude_target_euler_angle.y, _attitude_target_euler_angle.z);
% 
%         // Set rate feedforward requests to zero
%         _attitude_target_euler_rate = Vector3f(0.0f, 0.0f, 0.0f);
%         _attitude_target_ang_vel = Vector3f(0.0f, 0.0f, 0.0f);
%     }
% 
%     // Call quaternion attitude controller
%     attitude_controller_run_quat();
    
    global attitude_target_quat attitude_target_euler_rate attitude_target_euler_angle_x attitude_target_euler_angle_y attitude_target_euler_angle_z rate_bf_ff_enabled use_ff_and_input_shaping dt

    %% Convert from centidegrees on public interface to radians
% 	euler_roll_angle    = deg2rad(roll_attitude_target * 0.01);
%     euler_pitch_angle   = deg2rad(pitch_attitude_target * 0.01);
%     euler_yaw_rate      = deg2rad(yaw_rate_target * 0.01);
	  euler_roll_angle    = roll_attitude_target;
      euler_pitch_angle   = pitch_attitude_target;
      euler_yaw_rate      = yaw_rate_target;   

    
    coder.extrinsic('-sync:on', 'quat2angle')
    coder.extrinsic('-sync:on', 'angle2quat')   
    
    [attitude_target_euler_angle_x, attitude_target_euler_angle_y, attitude_target_euler_angle_z] = quat2angle(attitude_target_quat','XYZ');
    
    if (rate_bf_ff_enabled == 1) & (use_ff_and_input_shaping == 1)
    else 
        %% When feedforward is not enabled, the target euler angle is input into the target and the feedforward rate is zeroed.
        attitude_target_euler_angle_x = euler_roll_angle;
        attitude_target_euler_angle_y = euler_pitch_angle;
        attitude_target_euler_angle_z = attitude_target_euler_angle_z + euler_yaw_rate * dt;

        %% Compute quaternion target attitude
        attitude_target_quat = angle2quat(attitude_target_euler_angle_x, attitude_target_euler_angle_y, attitude_target_euler_angle_z,'XYZ');

        %Set rate feedforward requests to zero
        attitude_target_euler_rate     = [0.0, 0.0, 0.0]';
        attitude_target_ang_vel        = [0.0, 0.0, 0.0];
    end
    
    [ roll_rate_target, pitch_rate_target, yaw_rate_target ] = attitude_controller_run_quat(roll_angle_latest, pitch_angle_latest, yaw_angle_latest, gyro_latest_z);
    
end

