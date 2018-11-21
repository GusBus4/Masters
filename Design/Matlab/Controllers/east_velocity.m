s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Roll
roll_rate_tf                       = (1/(motor_timing_constant*Ixx))/(s*(s + (1/motor_timing_constant)));
roll_rate_controller_tf            = 0.55857 * (s + 4.872) * (s + 1.123) / (s * (s + 27.86));

roll_angle_tf                      = feedback(roll_rate_tf*roll_rate_controller_tf, 1) * (1/s);

roll_angle_controller_tf           = 1.1;               % P

east_velocity_tf                   = (1/g) * feedback(roll_angle_controller_tf*roll_angle_tf, 1) * g * (1/s)

east_velocity_controller_tf        = 0.69106;
east_velocity_controller1_tf       = 0.53149 * (s + 0.3223) * (s + 4.824) / s;

east_velocity_controller_name      = 'P Controller'
east_velocity_controller1_name     = 'PID Controller'

transfer_function           = east_velocity_controller_tf*east_velocity_tf;
transfer_function1          = east_velocity_controller1_tf*east_velocity_tf;
transfer_function2          = 0;

%% Plot Step Responses
figure;
hold on;

step(feedback(east_velocity_tf, 1), 'b')
step(feedback(transfer_function, 1), 'r')
step(feedback(transfer_function1, 1), 'g')

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Unity Feedback', east_velocity_controller_name, east_velocity_controller1_name}, 'FontSize', 16);
title('East Velocity Controller', 'FontSize', 16)
grid on;

hold off;

figure;
%% Plot Bode Plot, Highlighting the crossover poles
[mag, phase, wout]    = bode(east_velocity_tf);
[Gm,Pm,Wgm,Wpm]       = margin(east_velocity_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);

[mag2, phase2, wout2]  = bode(transfer_function1);
[Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);

xl = [max([wout(1) wout1(1) wout2(1)]) min([wout(end) wout1(end) wout2(end)])];

subplot(2, 2, 2)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g')
hold on;
grid on;
yl = ylim;

plot(zeros(2001, 1)+Wgm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wgm2, -Gm, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wgm1, -Gm1, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% plot(Wgm, -Gm2, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
title('East Velocity Bode - Gain Plot', 'FontSize', 20)
legend({'Plant', east_velocity_controller_name, east_velocity_controller1_name, 'Crossover Frequencies'},'FontSize', 16);
hold off;

subplot(2, 2, 4)
semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r', wout2, squeeze(phase2), 'g')
hold on;
grid on;
yl = ylim;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm2, Pm2-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Phase (Deg)', 'FontSize', 20);
title('East Velocity Bode - Phase Plot', 'FontSize', 20)
legend({'Plant', east_velocity_controller_name, east_velocity_controller1_name, 'Crossover Frequencies'},'FontSize', 16);
hold off;


%% Plot Root Locus and highlight the closed loop poles
subplot(2,2,1)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function, 1)     ;      
plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function, 'c')   

title(['Root Locus - ' east_velocity_controller_name], 'FontSize', 20)
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles'}, 'FontSize', 16)

grid on;
hold off;

%% Plot Root Locus and highlight the closed loop poles
subplot(2,2,3)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function1, 1)     ;      
plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function1, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function1, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function1, 'c')   

title(['Root Locus - ' east_velocity_controller1_name], 'FontSize', 20)
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;