s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Roll
roll_rate_tf        = (1/(motor_timing_constant*Ixx))/(s*(s + (1/motor_timing_constant)))

% roll_rate_controller2_tf   = 0.94666 * (s + 5.629) * (s + 1.69649) / (s * (s + 33.76))

roll_rate_controller2_tf   = 0.55857 * (s + 4.872) * (s + 1.123) / (s * (s + 27.86))

transfer_function    = roll_rate_controller2_tf*roll_rate_tf;
% transfer_function1   = roll_rate_controller1_tf*roll_rate_tf;
% transfer_function2   = roll_rate_controller2_tf*roll_rate_tf;


%% Plot Step Responses

figure;
hold on;

roll_rate_unitleadpi.Data = roll_rate_leadpi.Data/max(desired_roll.Data);
desired_rollunit.Data = desired_roll.Data/max(desired_roll.Data);

plot(tout, desired_rollunit.Data, 'LineWidth', 2)
plot(tout, roll_rate_unitleadpi.Data, 'LineWidth', 2)
yl = ylim;
plot(zeros(2001, 1)+5, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% plot(tout, roll_rate_leadpi_nolimits.Data, 'LineWidth', 2)
% plot(tout, roll_rate_leadpi_limits.Data, 'LineWidth', 2)

ylim(yl);
xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Reference', 'Lead-Lag Controller', 'Disturbance Injection'}, 'FontSize', 16);
% title('Heave Controller - Step Responses', 'FontSize', 20)
grid on;

hold off;

figure;
hold on;

plot(tout, motor_thrust.Data(:, 1), 'LineWidth', 2)
plot(tout, motor_thrust.Data(:, 2), 'LineWidth', 2)
% plot(tout, roll_rate_unitleadpi.Data, 'LineWidth', 2)
yl = ylim
plot(zeros(2001, 1)+5, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% plot(tout, roll_rate_leadpi_nolimits.Data, 'LineWidth', 2)
% plot(tout, roll_rate_leadpi_limits.Data, 'LineWidth', 2)

ylim(yl);
xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude (Thrust)', 'FontSize', 20)
legend({'Motor 1 & 4', 'Motor 2 & 3', 'Disturbance Injection'}, 'FontSize', 16);
% title('Heave Controller - Step Responses', 'FontSize', 20)
grid on;

hold off;


%% Plot Bode Plot, Highlighting the crossover poles
figure;
[mag, phase, wout]    = bode(roll_rate_tf);
[Gm,Pm,Wgm,Wpm]       = margin(roll_rate_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);

% [mag2, phase2, wout2]  = bode(transfer_function1);
% [Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);
% 
% [mag3, phase3, wout3]  = bode(transfer_function2);
% [Gm3,Pm3,Wgm3,Wpm3]    = margin(transfer_function2);

xl = [max([wout(1) wout1(1)]) min([wout(end) wout1(end)])];

subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r')
hold on;
grid on;

% xl = xlim;
yl = ylim;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point

plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point

plot(Wgm, -10-Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wgm1, -10-Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

dim = [.2 .5 .3 .3];
str = ['Gain Margin = ' num2str(round(Gm1, 2)) newline 'Frequency = ' num2str(round(Wgm1, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

xlim(xl)
ylim(yl)

xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
% title('Closed Roll Rate Loop Bode - Gain Plot', 'FontSize', 20)
legend({'Unity Feedback', 'Lead-Lag Controller', 'Gain Crossover Frequencies'}, 'FontSize', 16)
hold off;

subplot(2, 1, 2)
semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r')
hold on;
grid on;

% xl = xlim;
yl = ylim;

%Plot first one so that legend is correct
plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point

%Mark and Plot Phase cross over points
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

%Plot Phase cross over points
plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point

%Annotation Boxes
dim = [.2 .5 .5 .5];
str = ['Phase Margin = ' num2str(round(Pm, 2)) newline 'Frequency = ' num2str(round(Wpm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

dim = [.2 .5 .3 .3];
str = ['Phase Margin = ' num2str(round(Pm1, 2)) newline 'Frequency = ' num2str(round(Wpm1, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);


xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Phase (Deg)', 'FontSize', 20);
% title('Closed Roll Rate Loop Bode - Phase Plot', 'FontSize', 20)
legend({'Unity Feedback', 'Lead-Lag Controller', 'Gain Crossover Frequencies'}, 'FontSize', 16)
hold off;
% 
%% Plot Root Locus and highlight the closed loop poles
figure;
hold on;
                 
%Plot position of closed loop poles
cl_pole = rlocus(transfer_function, 1)     ;      
plot(real(cl_pole()),imag(cl_pole()),'rs','Markersize',15, 'LineWidth', 5)

%Plot position of open loop poles
ol_pole = rlocus(transfer_function, 0)      ;    
plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)

%Plot position of open loop zeros
[pole, zero] = pzmap(feedback(transfer_function, 1))  ; 
plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)

%Plot Open loop root locus
rlocus(transfer_function, 'c')   

% title('Root Locus', 'FontSize', 20)
title('')
xlabel('Imaginary Axis', 'FontSize', 20);
ylabel('Real Axis', 'FontSize', 20);
legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)

grid on;
hold off;
% 
