s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Pitch
pitch_rate_tf                = (1/(motor_timing_constant*Ixx))/(s*(s + (1/motor_timing_constant)))
pitch_rate_controller_tf     = 0.24813 * (s + 8) / ((s + 16))

pitch_angle_tf               = feedback(pitch_rate_tf*pitch_rate_controller_tf, 1) * (1/s)

pitch_angle_controller_tf    = 1.8                                         % P
pitch_angle_controller1_tf   = 0.32715 * (s + 10.11)                       % PD

pitch_angle_controller_name  = 'P Controller'
pitch_angle_controller1_name = 'PD Controller'

transfer_function           = pitch_angle_controller_tf*pitch_angle_tf;
transfer_function1          = pitch_angle_controller1_tf*pitch_angle_tf;
transfer_function2          = 0;

%% Plot Step Responses
figure;
hold on;

step(feedback(pitch_angle_tf, 1), 'b')
step(feedback(transfer_function, 1), 'r')
step(feedback(transfer_function1, 1), 'g')

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Unity Feedback', pitch_angle_controller_name, pitch_angle_controller1_name}, 'FontSize', 16);
title('Pitch Angle Controller', 'FontSize', 16)
grid on;

hold off;

figure;
%% Plot Bode Plot, Highlighting the crossover poles
[mag, phase, wout]    = bode(pitch_angle_tf);
[Gm,Pm,Wgm,Wpm]       = margin(pitch_angle_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);

[mag2, phase2, wout2]  = bode(transfer_function1);
[Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);

xl = [max([wout(1) wout1(1) wout2(1)]) min([wout(end) wout1(end) wout2(end)])];

subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g')
hold on;
grid on;
yl = ylim;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm2, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
% title('Closed Pitch Angle Loop Bode - Gain Plot', 'FontSize', 20)
legend({'Unity Feedback', pitch_angle_controller_name, pitch_angle_controller1_name, 'Crossover Frequencies'},'FontSize', 16);
hold off;

subplot(2, 1, 2)
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
% title('Closed Pitch Angle Loop Bode - Phase Plot', 'FontSize', 20)
legend({'Unity Feedback', pitch_angle_controller_name, pitch_angle_controller1_name, 'Crossover Frequencies'},'FontSize', 16);
hold off;


%% Plot Root Locus and highlight the closed loop poles
figure;
subplot(1,2,2)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function, 1)
cl_pole(2) = cl_pole(3)
cl_pole(3) = cl_pole(4)
plot(real(cl_pole(1:3)),imag(cl_pole(1:3)),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function, 'c')

xlim([-15 1])
ylim([-15 15])

title('')
% title(['Root Locus - ' pitch_angle_controller_name], 'FontSize', 20)
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;

%% Plot Root Locus and highlight the closed loop poles
subplot(1,2,1)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function1, 1)
% cl_pole(2) = cl_pole(3)
cl_pole(3) = cl_pole(4)
plot(real(cl_pole(1:3)),imag(cl_pole(1:3)),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function1, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function1, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function1, 'c') 

xlim([-15 1])
ylim([-15 15])

title('')
% title(['Root Locus - ' pitch_angle_controller1_name], 'FontSize', 20)
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;