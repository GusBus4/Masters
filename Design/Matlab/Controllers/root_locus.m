s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Heave
heave_tf            = (1/(motor_timing_constant*m))/(s + (1/motor_timing_constant))

heave_controller_1 = 55.556 * (s + 0.900) / s;
heave_controller_2 = 3*(s+10)/s

% figure;
% hold on;
% 
% step(feedback(heave_tf, 1))
% step(feedback(heave_controller_1*heave_tf, 1))
% step(feedback(heave_controller_2*heave_tf, 1))
% % legend('Unity Feedback', 'P Dominant', 'I Dominant');
% title('Heave Controller')
% ylim([0 1.1])
% grid on;
% 
% hold off;

% figure;
% % Plot Bode Plot
% subplot(2,1,1)
% hold on;
% bode(heave_controller_2*heave_tf)
% grid on;
% hold off;

%Plot Root Locus and highlight the closed loop poles
subplot(2,1,2)
hold on;
rlocus(heave_controller_2*heave_tf)                     %Plot Open loop poles

cl_pole = rlocus(heave_controller_2*heave_tf, 1)           %Plot position of closed loop
plot(real(cl_pole),imag(cl_pole),'rs','Markersize',10, 'LineWidth', 2)

ol_pole = rlocus(heave_controller_2*heave_tf, 0)           %Plot position of open loop poles
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',10, 'LineWidth', 2)

[pole, zero] = pzmap(feedback(heave_controller_2*heave_tf, 1))   %Plot position of open loop poles
plot(real(zero),imag(zero),'bo','Markersize',7.5, 'LineWidth', 2)
grid on;
hold off;

%Plot Bode Plot, Highlighting the 
[mag, phase, wout] = bode(heave_controller_2*heave_tf);

subplot(4, 1, 1)

semilogx(wout, 20*log10(squeeze(mag)), '-b')
grid on;

xl = xlim;
yl = ylim;

hold on;

for i = 1:length(cl_pole)
    plot(zeros(201, 1)-real(cl_pole(i)), -100:100, 'k--'); %Mark Plot cross over point
end

xlim(xl)
ylim(yl)
title('Closed Heave Loop Bode - Gain Plot')
hold off;

subplot(4, 1, 2)

semilogx(wout, squeeze(phase), '-b', 'LineWidth', 2)

xl = xlim;
yl = ylim;

hold on;
grid on;

plot(-100:100, zeros(201, 1), 'k--'); %Mark Plot cross over point
plot(zeros(201, 1)-real(cl_pole(1)), -100:100, 'k--'); %Mark Plot cross over point

xlim(xl)
ylim(yl)
title('Closed Heave Loop Bode - Phase Plot')
hold off;


% %% Yaw
% 
% yaw_rate_tf         = (1/(motor_timing_constant*Izz))/(s*(s + (1/motor_timing_constant)))
% yaw_rate_controller_tf   = (0.6 * (s + 0.1)) / s;
% yaw_closed_loop_rate_tf = feedback(yaw_rate_controller_tf*yaw_rate_tf, 1)
% 
% yaw_angle_tf = (1/s)*yaw_closed_loop_rate_tf
% yaw_angle_controller_tf = 1.3
% yaw_closed_loop_angle_tf = feedback(yaw_angle_controller_tf*yaw_angle_tf, 1)
% 
% figure;
% hold on;
% 
% step(feedback(yaw_rate_tf, 1))
% step(feedback(yaw_rate_controller_tf*yaw_rate_tf, 1))
% 
% legend('Unity Feedback', 'PI Controller');
% title('Yaw Rate Controller')
% grid on;
% 
% hold off;
% 
% figure;
% hold on;
% 
% step(feedback(yaw_angle_tf, 1))
% step(feedback(yaw_angle_controller_tf*yaw_angle_tf, 1))
% 
% legend('Unity Feedback', 'P Controller');
% title('Yaw Angle Controller')
% grid on;
% 
% hold off;
% 
% %% Roll 
% roll_rate_tf        = (1/(motor_timing_constant*Iyy))/(s*(s + (1/motor_timing_constant)))
% roll_rate_controller_tf   = 0.11678*(((1 + 0.12*s) * (1 + 10*s)) / (s * (1 + 0.04*s)));
% roll_closed_loop_rate_tf = feedback(roll_rate_controller_tf*roll_rate_tf, 1)
% 
% roll_angle_tf = (1/s)*roll_closed_loop_rate_tf
% roll_angle_controller_tf = 2.2
% roll_closed_loop_angle_tf = feedback(roll_angle_controller_tf*roll_angle_tf, 1)
% 
% figure;
% hold on;
% 
% step(feedback(roll_rate_tf, 1))
% step(feedback(roll_rate_controller_tf*roll_rate_tf, 1))
% 
% legend('Unity Feedback', 'Lead - PI Controller');
% title('Roll Rate Controller')
% grid on;
% 
% hold off;
% 
% figure;
% hold on;
% 
% step(feedback(roll_angle_tf, 1))
% step(feedback(roll_angle_controller_tf*roll_angle_tf, 1))
% 
% legend('Unity Feedback', 'P Controller');
% title('Roll Angle Controller')
% grid on;
% 
% hold off;
% 
% %% Pitch 
% pitch_rate_tf       = (1/(motor_timing_constant*Ixx))/(s*(s + (1/motor_timing_constant)))
% pitch_rate_controller_tf   = 0.23514*(((1 + 0.12*s) * (1 + 2*s)) / (s * (1 + 0.017*s)))
% pitch_closed_loop_rate_tf = feedback(pitch_rate_controller_tf*pitch_rate_tf, 1)
% 
% pitch_angle_tf = (1/s)*pitch_closed_loop_rate_tf
% pitch_angle_controller_tf = 5
% pitch_closed_loop_angle_tf = feedback(pitch_angle_controller_tf*pitch_angle_tf, 1)
% 
% figure;
% hold on;
% 
% step(feedback(pitch_rate_tf, 1))
% step(feedback(pitch_rate_controller_tf*pitch_rate_tf, 1))
% 
% legend('Unity Feedback', 'Lead - PI Controller');
% title('Pitch Rate Controller')
% grid on;
% 
% hold off;
% 
% figure;
% hold on;
% 
% step(feedback(pitch_angle_tf, 1))
% step(feedback(pitch_angle_controller_tf*pitch_angle_tf, 1))
% 
% legend('Unity Feedback', 'P Controller');
% title('Pitch Angle Controller')
% grid on;
% 
% hold off;
% 
% 
% % %Based on decriped assumptions
% % north_velocity_tf = (1/s) * pitch_closed_loop_angle_tf
% % 
% % sisotool(yaw_rate_tf)
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
