s = tf('s')
% GH = 1/ (s* (s+4) * (s^2 + 4*s + 20))
% 
% 
% % k = 2
% % 
% % k*GH
% 
% num = 1
% den = [1 8 36 80 0]
% 
% GH = tf(num, den)
% 
% p = pole(GH)
% z = zero(GH)
% 
% % pzmap(GH)
% 
% rlocus(GH)
% grid on;

Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;

motor_timing_constant = 0.125

yaw_tf      = (1/(motor_timing_constant*Izz))/(s*(s + (1/motor_timing_constant)))
roll_tf     = (1/(motor_timing_constant*Iyy))/(s*(s + (1/motor_timing_constant)))
pitch_tf    = (1/(motor_timing_constant*Ixx))/(s*(s + (1/motor_timing_constant)))


sisotool(yaw_tf)