function [ pilot_throttle_scaled ] = get_pilot_desired_throttle( pilot_throttle_in )
%GET_PILOT_DESIRED_THROTTLE Summary of this function goes here
%   Detailed explanation goes here
% pilot_throttle_scaled = get_pilot_desired_throttle(channel_throttle->get_control_in());
% float Copter::get_pilot_desired_throttle(int16_t pilot_throttle_in)
% {
%     float pilot_throttle_scaled;
% 
%     int16_t mid_stick = channel_throttle->get_control_mid();
% 
%     // protect against unlikely divide by zero
%     if (mid_stick <= 0) {
%         mid_stick = 500;
%     }
% 
%     // ensure reasonable throttle values
%     pilot_throttle_in = constrain_int16(pilot_throttle_in,0,1000);
% 
%     // ensure mid throttle is set within a reasonable range
%     float thr_mid = constrain_float(motors.get_throttle_hover(), 0.1f, 0.9f);
% 
%     // check throttle is above, below or in the deadband
%     if (pilot_throttle_in < mid_stick) {
%         // below the deadband
%         pilot_throttle_scaled = ((float)pilot_throttle_in)*thr_mid/(float)mid_stick;
%     }else if(pilot_throttle_in > mid_stick) {
%         // above the deadband
%         pilot_throttle_scaled = (thr_mid) + ((float)(pilot_throttle_in-mid_stick)) * (1.0f - thr_mid) / (float)(1000-mid_stick);
%     }else{
%         // must be in the deadband
%         pilot_throttle_scaled = thr_mid;
%     }
% 
%     return pilot_throttle_scaled;
% }
    
    throttle_mid_stick = 1500;
    
    %pilot_throttle_in = math_constrain_value(pilot_throttle_in, 0, 1000);
    
    thr_mid = 0.5;
    
    if (pilot_throttle_in < throttle_mid_stick) 
%       below the deadband
        pilot_throttle_scaled = pilot_throttle_in * thr_mid / throttle_mid_stick;
    
    elseif(pilot_throttle_in > throttle_mid_stick)    
%       above the deadband
        pilot_throttle_scaled = thr_mid + ((pilot_throttle_in - throttle_mid_stick) * (1.0 - thr_mid) / (2000 - throttle_mid_stick));
    
    else
%       must be in the deadband
        pilot_throttle_scaled = thr_mid;
    end

end

