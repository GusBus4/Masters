function [ output_args ] = set_throttle_out( input_args )
%SET_THROTTLE_OUT Summary of this function goes here
%   Detailed explanation goes here
% void AC_AttitudeControl_Multi::set_throttle_out(float throttle_in, bool apply_angle_boost, float filter_cutoff)
% {
%     _throttle_in = throttle_in;
%     update_althold_lean_angle_max(throttle_in);
%     _motors.set_throttle_filter_cutoff(filter_cutoff);
%     if (apply_angle_boost) {
%         // Apply angle boost
%         throttle_in = get_throttle_boosted(throttle_in);
%     }else{
%         // Clear angle_boost for logging purposes
%         _angle_boost = 0.0f;
%     }
%     _motors.set_throttle(throttle_in);
%     _motors.set_throttle_avg_max(get_throttle_avg_max(MAX(throttle_in, _throttle_in)));
% }

end

