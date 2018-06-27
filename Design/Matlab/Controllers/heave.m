s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Heave
heave_tf                    = (1/(motor_timing_constant*m))/(s + (1/motor_timing_constant))
heave_controller_tf         = 2.9782*(s+9.895)/s

transfer_function           = heave_controller_tf*heave_tf
%% Plot Step Responses
% figure;
% hold on;
% 
% step(feedback(heave_tf, 1))
% step(feedback(heave_controller_tf*heave_tf, 1))
% % impulse(feedback(heave_tf, 1))
% % impulse(feedback(heave_controller_tf*heave_tf, 1))
% info = stepinfo(feedback(heave_controller_tf*heave_tf, 1));
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Unity Feedback', 'PI Controller'}, 'FontSize', 16);
% % title('Heave Controller - Step Response', 'FontSize', 20)
% % ylim([0 1.1])
% grid on;
% 
% hold off;

% figure;
% hold on;
% 
% plot(tout, a.Data, 'LineWidth', 2)
% plot(tout, a1.Data, 'LineWidth', 2)
% yl = ylim;
% plot(zeros(2001, 1)+2.5, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% 
% info = stepinfo(feedback(heave_controller_tf*heave_tf, 1));
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Reference', 'Actual', 'Disturbance Injection'}, 'FontSize', 16);
% % title('Heave Controller - Step Responses', 'FontSize', 20)
% ylim(yl)
% grid on;
% 
% hold off;

% figure;
% hold on;
% 
% impulse(feedback(heave_tf, 1))
% impulse(feedback(heave_controller_tf*heave_tf, 1))
% 
% [y t] = impulse(feedback(heave_controller_tf*heave_tf, 1))
% % info = impulseinfo(feedback(heave_controller_tf*heave_tf, 1));
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Unity Feedback', 'PI Controller'}, 'FontSize', 16);
% title('Heave Controller', 'FontSize', 20)
% % ylim([0 1.1])
% grid on;
% 
% hold off;

%% Plot Root Locus and highlight the closed loop poles
figure;
% subplot(1,2,1)
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function, 1)           
plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function, 0)          
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function, 1))   
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function, 'c')   

% title(['Heave Root Locus - PI Controller' ], 'FontSize', 20)
title('')
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;

%% Plot Bode Plot, Highlighting the cl poles
[mag, phase, wout]  = bode(heave_tf);
[Gm,Pm,Wgm,Wpm]     = margin(heave_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]    = margin(transfer_function)

% xl = [max([wout(1) wout1(1)]) max([wout(end) wout1(end)])];
% yl = [min([min(20*log10(squeeze(mag))) min(20*log10(squeeze(mag1)))]) max([max(20*log10(squeeze(mag))) max(20*log10(squeeze(mag1)))])];
figure;
subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), '-b', wout1, 20*log10(squeeze(mag1)), '-r')
hold on;
grid on;
plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(Wpm, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% plot(Wpm1, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

xlim([1 100])
ylim([-40 30])
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
% title('Open Loop Heave Bode Plot - Gain', 'FontSize', 20)
legend({'Plant', 'PI Controller', 'Crossover Frequencies'}, 'FontSize', 16)
hold off;

subplot(2, 1, 2)
semilogx(wout, squeeze(phase), '-b', wout1, squeeze(phase1), '-r')
hold on;
grid on;
xl = [1 100];
yl = [-100 -10];
plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point


% figure
% plot(1:10)
dim = [.2 .5 .3 .3];
str = ['Phase Margin = ' num2str(round(Pm1, 2)) newline 'Frequency = ' num2str(round(Wpm1, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Phase (Deg)', 'FontSize', 20);
% title('Open Loop Heave Bode Plot - Phase', 'FontSize', 20)
legend({'Plant', 'PI Controller', 'Crossover Frequencies'}, 'FontSize', 16)
hold off;