function [ output_args ] = get_pilot_desired_lean_angles( input_args )
%GET_PILOT_DESIRED_LEAN_ANGLES Summary of this function goes here
%   Detailed explanation goes here
% void Copter::get_pilot_desired_lean_angles(float roll_in, float pitch_in, float &roll_out, float &pitch_out, float angle_max)
% {
%     // sanity check angle max parameter
%     aparm.angle_max = constrain_int16(aparm.angle_max,1000,8000);
% 
%     // limit max lean angle
%     angle_max = constrain_float(angle_max, 1000, aparm.angle_max);
% 
%     // scale roll_in, pitch_in to ANGLE_MAX parameter range
%     float scaler = aparm.angle_max/(float)ROLL_PITCH_INPUT_MAX;
%     roll_in *= scaler;
%     pitch_in *= scaler;
% 
%     // do circular limit
%     float total_in = norm(pitch_in, roll_in);
%     if (total_in > angle_max) {
%         float ratio = angle_max / total_in;
%         roll_in *= ratio;
%         pitch_in *= ratio;
%     }
% 
%     // do lateral tilt to euler roll conversion
%     roll_in = (18000/M_PI) * atanf(cosf(pitch_in*(M_PI/18000))*tanf(roll_in*(M_PI/18000)));
% 
%     // return
%     roll_out = roll_in;
%     pitch_out = pitch_in;
% }

end

