%thrust_heading_rotation_angles(Quaternion& att_to_quat, const Quaternion& att_from_quat, Vector3f& att_diff_angle, float& thrust_vec_dot)
%thrust_heading_rotation_angles(attitude_target_quat, attitude_vehicle_quat, attitude_error_vector, thrust_error_angle);
    
    
function [ attitude_error_vector, thrust_error_angle, attitude_target_quat ] = thrust_heading_rotation_angles( attitude_target_quat, attitude_vehicle_quat)
%THRUST_HEADING_ROTATION_ANGLES Summary of this function goes here
%   Detailed explanation goes here
    
    

%% Generate rotation dcm and vector
	coder.extrinsic('-sync:on', 'quat2dcm'); 
    
    
    att_to_rot_matrix = quat2dcm(attitude_target_quat');                     %earth frame to target frame
    att_to_thrust_vec = att_to_rot_matrix * [0.0; 0.0; 1.0];

    att_from_rot_matrix = quat2dcm(attitude_vehicle_quat');                  %earth frame to target frame
    att_from_thrust_vec = att_from_rot_matrix * [0.0; 0.0; 1.0];

    %% The cross product of the desired and target thrust vector defines the rotation vector
    thrust_vec_cross = cross(att_from_thrust_vec, att_to_thrust_vec);

    %% The dot product is used to calculate the angle between the target and desired thrust vectors
    dotfrom2to=0;
    dotfrom2to = dot(att_from_thrust_vec, att_to_thrust_vec);
    thrust_error_angle = math_constrain_value(dotfrom2to, -1, 1);

    %% Normalize the thrust rotation vector
    thrust_vector_length=0;
    thrust_vector_length = length(thrust_vec_cross);
 
    if( (thrust_vector_length == 0) || (thrust_error_angle == 0))

        thrust_vec_cross = [0, 0, 1];
        thrust_error_angle = 0.0;
    
    else
        thrust_vec_cross = thrust_vec_cross'/thrust_vector_length;
    end
   
    thrust_vec_correction_quat = [0 0 0 0];
    st2 = sin(thrust_error_angle/2);

    thrust_vec_correction_quat(1) = cos(thrust_error_angle/2);
    thrust_vec_correction_quat(2) = thrust_vec_cross(1)*st2;
    thrust_vec_correction_quat(3) = thrust_vec_cross(2)*st2;
    thrust_vec_correction_quat(4) = thrust_vec_cross(3)*st2;


	coder.extrinsic('-sync:on','quatmultiply')
	coder.extrinsic('-sync:on','quatinv')

    thrust_vec_correction_quat = quatmultiply(quatinv(attitude_vehicle_quat'), quatmultiply(thrust_vec_correction_quat, attitude_vehicle_quat'));

    %% Calculate the remaining rotation required after thrust vector is rotated   
    heading_quat = [0 0 0 0];
    heading_quat = quatmultiply(quatinv(thrust_vec_correction_quat), quatmultiply(quatinv(attitude_vehicle_quat'), attitude_target_quat'));
    
    l = sqrt( norm(thrust_vec_correction_quat(2)) + norm(thrust_vec_correction_quat(3)) + norm(thrust_vec_correction_quat(4)) );
    rotation = [thrust_vec_correction_quat(2), thrust_vec_correction_quat(3), thrust_vec_correction_quat(4)];
    if l ~= 0
        rotation = rotation / l;
        rotation = rotation * math_wrap_pi(2.0 * atan2(l , thrust_vec_correction_quat(1)));
    end
   
    attitude_error_vector = [0 0 0]; 
    attitude_error_vector(1) = rotation(1);
    attitude_error_vector(2) = rotation(2);
    
    l = sqrt( norm(heading_quat(2)) + norm(heading_quat(3)) + norm(heading_quat(4)) );
    rotation = [heading_quat(2), heading_quat(3), heading_quat(4)];
    if l ~= 0
        rotation = rotation / l;
        rotation = rotation * math_wrap_pi(2.0 * atan2(l , heading_quat(1)));
    end
    
    attitude_error_vector(3) = rotation(3);
   
    global yaw_attitude_kP AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS
   
    if (yaw_attitude_kP ~= 0) & (abs( attitude_error_vector(3)) > AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS/yaw_attitude_kP)
     
        attitude_error_vector(3) = math_constrain_value(math_wrap_pi(attitude_error_vector(3)), -AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS/yaw_attitude_kP, AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS/yaw_attitude_kP);
        
        v = [0.0, 0.0, attitude_error_vector(3)];
        theta = length(v);
        v = v/theta;
        st2 = sin(theta/2);
    
        heading_quat(1) = cos(theta/2);
        heading_quat(2) = v(1)*st2;
        heading_quat(3) = v(2)*st2;
        heading_quat(4) = v(3)*st2;
    
        attitude_target_quat = quatmultiply(attitude_vehicle_quat', quatmultiply(thrust_vec_correction_quat, heading_quat));

    end
    
end

