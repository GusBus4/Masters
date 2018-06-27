s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Roll
roll_rate_tf        = (1/(motor_timing_constant*Iyy))/(s*(s + (1/motor_timing_constant)))

roll_rate_controller_tf    = 0.40935;
roll_rate_controller1_tf   = 1.7 * (s + 8) / (s + 16)
roll_rate_controller2_tf   = 0.67294 * (s + 8) * (s + 0.5) / (s * (s + 16))


transfer_function    = roll_rate_controller_tf*roll_rate_tf;
transfer_function1   = roll_rate_controller1_tf*roll_rate_tf;
transfer_function2   = roll_rate_controller2_tf*roll_rate_tf;


%% Plot Step Responses
figure;
hold on;

step(feedback(roll_rate_tf, 1), 'b')
step(feedback(transfer_function, 1), 'r')
step(feedback(transfer_function1, 1), 'g')
step(feedback(transfer_function2, 1), 'm' )

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Unity Feedback', 'P Controller', 'Lead-P Controller', 'Lead-PI Controller'}, 'FontSize', 16);
title('Roll Rate Controller', 'FontSize', 16)
grid on;

hold off;

figure;
%% Plot Bode Plot, Highlighting the crossover poles
[mag, phase, wout]    = bode(roll_rate_tf);
[Gm,Pm,Wgm,Wpm]       = margin(roll_rate_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);

[mag2, phase2, wout2]  = bode(transfer_function1);
[Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);

[mag3, phase3, wout3]  = bode(transfer_function2);
[Gm3,Pm3,Wgm3,Wpm3]    = margin(transfer_function2);

xl = [max([wout(1) wout1(1) wout2(1) wout3(1)]) min([wout(end) wout1(end) wout2(end) wout3(end)])];

subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g', wout3, 20*log10(squeeze(mag3)), 'm')
hold on;
grid on;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm3, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm3, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm2, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim(xl)
ylim([min(20*log10(squeeze(mag1))) max(20*log10(squeeze(mag1)))])
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
% title('Closed Roll Rate Loop Bode - Gain Plot', 'FontSize', 20)
legend({'Unity Feedback', 'P Controller', 'Lead-P Controller', 'Lead-PI Controller', 'Crossover Frequencies'}, 'FontSize', 16)
hold off;



subplot(2, 1, 2)
semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r', wout2, squeeze(phase2), 'g', wout3, squeeze(phase3), 'm')
hold on;
grid on;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm3, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm3, Pm3-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm2, Pm2-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim(xl)
ylim([min(phase)-10 max(phase)+10])
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Phase (Deg)', 'FontSize', 20);
% title('Closed Roll Rate Loop Bode - Phase Plot', 'FontSize', 20)
legend({'Unity Feedback', 'P Controller', 'Lead-P Controller', 'Lead-PI Controller', 'Crossover Frequencies'}, 'FontSize', 16)
hold off;

%% Plot Root Locus and highlight the closed loop poles
figure;
% subplot(1,2,1)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function1, 1)     ;      
plot(real(cl_pole(1:2)),imag(cl_pole(1:2)),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function1, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function1, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function1, 'c')   

% title('Root Locus', 'FontSize', 20)
title('')
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;

