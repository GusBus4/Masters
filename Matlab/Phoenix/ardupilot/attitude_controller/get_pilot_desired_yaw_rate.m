function [ yaw_rate_target ] = get_pilot_desired_yaw_rate( pilot_yaw_in )
%GET_PILOT_DESIRED_YAW_RATE Summary of this function goes here
%   Returns as CentiDegree/Second, no clue what the input is though...

% // get_pilot_desired_heading - transform pilot's yaw input into a
% // desired yaw rate
% // returns desired yaw rate in centi-degrees per second
% target_yaw_rate = get_pilot_desired_yaw_rate(channel_yaw->get_control_in);
% float Copter::get_pilot_desired_yaw_rate(int16_t stick_angle)
% {
%     // convert pilot input to the desired yaw rate
%     return stick_angle * g.acro_yaw_p;
% }
    global acro_yaw_p
    
    yaw_rate_target = pilot_yaw_in * acro_yaw_p;
end

