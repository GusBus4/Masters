function [ output_args ] = attitude_controller_run_quat( input_args )
%ATTITUDE_CONTROLLER_RUN_QUAT Summary of this function goes here
%   Detailed explanation goes here
% void AC_AttitudeControl::attitude_controller_run_quat()
% {
%     // Retrieve quaternion vehicle attitude
%     // TODO add _ahrs.get_quaternion()
%     Quaternion attitude_vehicle_quat;
%     attitude_vehicle_quat.from_rotation_matrix(_ahrs.get_rotation_body_to_ned());
% 
%     // Compute attitude error
%     Vector3f attitude_error_vector;
%     thrust_heading_rotation_angles(_attitude_target_quat, attitude_vehicle_quat, attitude_error_vector, _thrust_error_angle);
% 
%     // Compute the angular velocity target from the attitude error
%     _rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_vector);
% 
%     // Add feedforward term that attempts to ensure that roll and pitch errors rotate with the body frame rather than the reference frame.
%     _rate_target_ang_vel.x += attitude_error_vector.y * _ahrs.get_gyro().z;
%     _rate_target_ang_vel.y += -attitude_error_vector.x * _ahrs.get_gyro().z;
% 
%     // Add the angular velocity feedforward, rotated into vehicle frame
%     Quaternion attitude_target_ang_vel_quat = Quaternion(0.0f, _attitude_target_ang_vel.x, _attitude_target_ang_vel.y, _attitude_target_ang_vel.z);
%     Quaternion attitude_error_quat = attitude_vehicle_quat.inverse() * _attitude_target_quat;
%     Quaternion target_ang_vel_quat = attitude_error_quat.inverse()*attitude_target_ang_vel_quat*attitude_error_quat;
% 
%     // Correct the thrust vector and smoothly add feedforward and yaw input
%     if(_thrust_error_angle > AC_ATTITUDE_THRUST_ERROR_ANGLE*2.0f){
%         _rate_target_ang_vel.z = _ahrs.get_gyro().z;
%     }else if(_thrust_error_angle > AC_ATTITUDE_THRUST_ERROR_ANGLE){
%         float flip_scalar = (1.0f - (_thrust_error_angle-AC_ATTITUDE_THRUST_ERROR_ANGLE)/AC_ATTITUDE_THRUST_ERROR_ANGLE);
%         _rate_target_ang_vel.x += target_ang_vel_quat.q2*flip_scalar;
%         _rate_target_ang_vel.y += target_ang_vel_quat.q3*flip_scalar;
%         _rate_target_ang_vel.z += target_ang_vel_quat.q4;
%         _rate_target_ang_vel.z = _ahrs.get_gyro().z*(1.0-flip_scalar) + _rate_target_ang_vel.z*flip_scalar;
%     } else {
%         _rate_target_ang_vel.x += target_ang_vel_quat.q2;
%         _rate_target_ang_vel.y += target_ang_vel_quat.q3;
%         _rate_target_ang_vel.z += target_ang_vel_quat.q4;
%     }
% 
%     if (_rate_bf_ff_enabled & _use_ff_and_input_shaping) {
%         // rotate target and normalize
%         Quaternion attitude_target_update_quat;
%         attitude_target_update_quat.from_axis_angle(Vector3f(_attitude_target_ang_vel.x * _dt, _attitude_target_ang_vel.y * _dt, _attitude_target_ang_vel.z * _dt));
%         _attitude_target_quat = _attitude_target_quat * attitude_target_update_quat;
%         _attitude_target_quat.normalize();
%     }
% }

end

