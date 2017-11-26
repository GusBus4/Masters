function [ output_args ] = get_pilot_desired_throttle( input_args )
%GET_PILOT_DESIRED_THROTTLE Summary of this function goes here
%   Detailed explanation goes here
% pilot_throttle_scaled = get_pilot_desired_throttle(channel_throttle->get_control_in());
% float Copter::get_pilot_desired_throttle(int16_t throttle_control)
% {
%     float throttle_out;
% 
%     int16_t mid_stick = channel_throttle->get_control_mid();
% 
%     // protect against unlikely divide by zero
%     if (mid_stick <= 0) {
%         mid_stick = 500;
%     }
% 
%     // ensure reasonable throttle values
%     throttle_control = constrain_int16(throttle_control,0,1000);
% 
%     // ensure mid throttle is set within a reasonable range
%     float thr_mid = constrain_float(motors.get_throttle_hover(), 0.1f, 0.9f);
% 
%     // check throttle is above, below or in the deadband
%     if (throttle_control < mid_stick) {
%         // below the deadband
%         throttle_out = ((float)throttle_control)*thr_mid/(float)mid_stick;
%     }else if(throttle_control > mid_stick) {
%         // above the deadband
%         throttle_out = (thr_mid) + ((float)(throttle_control-mid_stick)) * (1.0f - thr_mid) / (float)(1000-mid_stick);
%     }else{
%         // must be in the deadband
%         throttle_out = thr_mid;
%     }
% 
%     return throttle_out;
% }

end

