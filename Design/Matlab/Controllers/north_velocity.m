s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Pitch
pitch_rate_tf                       = (1/(motor_timing_constant*Iyy))/(s*(s + (1/motor_timing_constant)));
pitch_rate_controller_tf            = 2.9568 * (s + 4.162) * (s + 1.054) / (s * (s + 19.99))

pitch_angle_tf                      = feedback(pitch_rate_tf*pitch_rate_controller_tf, 1) * (1/s);

pitch_angle_controller_tf           = 1.1                                  % P
% pitch_angle_controller_tf         = 0.32715 * (s + 10.11);               % PD

north_velocity_tf                   = feedback(pitch_angle_controller_tf*pitch_angle_tf, 1) * 1/s

north_velocity_controller_tf        = 0.445;                                %P
north_velocity_controller1_tf       = 0.37744 * (s+0.09229) / s;            %PI
north_velocity_controller2_tf       = 0.2225 * (s+0.042) / (s + 0.021);     %Lag
north_velocity_controller3_tf       = 0.4425 * (s+0.042) / (s + 0.0105);     %Lag1

north_velocity_controller_name      = 'P Controller'
north_velocity_controller1_name     = 'PI Controller'
north_velocity_controller2_name     = 'Lag Controller'
north_velocity_controller3_name     = 'Lag1 Controller'

transfer_function           = north_velocity_controller_tf*north_velocity_tf;
transfer_function1          = north_velocity_controller1_tf*north_velocity_tf;
transfer_function2          = north_velocity_controller2_tf*north_velocity_tf;
transfer_function3          = north_velocity_controller3_tf*north_velocity_tf;

%% Plot Step Responses
figure;
hold on;

desired_north_velocity_unit.Data = desired_velocity_x.Data/max(desired_velocity_x.Data);
north_vel_unit_p.Data = actual_velocity_x_p.Data/max(desired_velocity_x.Data);
north_vel_unit_pi.Data = actual_velocity_x_pi.Data/max(desired_velocity_x.Data);
north_vel_unit_lag.Data = actual_velocity_x_lag.Data/max(desired_velocity_x.Data);

plot(toutlag, desired_north_velocity_unit.Data, 'LineWidth', 2)
plot(toutp, north_vel_unit_p.Data, 'LineWidth', 2)
plot(toutpi, north_vel_unit_pi.Data, 'LineWidth', 2)
plot(toutlag, north_vel_unit_lag.Data, 'LineWidth', 2)

yl = ylim;
% plot(zeros(2001, 1)+10, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% plot(tout, roll_rate_leadpi_nolimits.Data, 'LineWidth', 2)
% plot(tout, roll_rate_leadpi_limits.Data, 'LineWidth', 2)
ylim(yl);

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Reference', 'P Controller', 'PI Controller', 'Lag Controller'}, 'FontSize', 16);
% title('Heave Controller - Step Responses', 'FontSize', 20)
grid on;

hold off;

% figure;
% hold on;
% 
% desired_north_velocity_unit.Data = desired_velocity_x.Data/max(desired_velocity_x.Data);
% north_vel_unit_pd.Data = actual_velocity_x_pd.Data/max(desired_velocity_x.Data);
% north_vel_unit_pid.Data = actual_velocity_x_pid.Data/max(desired_velocity_x.Data);
% north_vel_unit_lagd.Data = actual_velocity_x_lagd.Data/max(desired_velocity_x.Data);
% 
% plot(toutpid, desired_north_velocity_unit.Data, 'LineWidth', 2)
% plot(toutpd, north_vel_unit_pd.Data, 'LineWidth', 2)
% plot(toutpid, north_vel_unit_pid.Data, 'LineWidth', 2)
% plot(toutlagd, north_vel_unit_lagd.Data, 'LineWidth', 2)
% 
% yl = ylim;
% % plot(zeros(2001, 1)+10, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% % plot(tout, roll_rate_leadpi_nolimits.Data, 'LineWidth', 2)
% % plot(tout, roll_rate_leadpi_limits.Data, 'LineWidth', 2)
% ylim(yl);
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Reference', 'P Controller', 'PI Controller', 'Lag Controller'}, 'FontSize', 16);
% % title('Heave Controller - Step Responses', 'FontSize', 20)
% grid on;
% 
% hold off;

figure;
%% Plot Bode Plot, Highlighting the crossover poles
[mag, phase, wout]    = bode(transfer_function);
[Gm,Pm,Wgm,Wpm]       = margin(transfer_function);

[mag1, phase1, wout1]  = bode(transfer_function1);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function1);

[mag2, phase2, wout2]  = bode(transfer_function3);
[Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function3);

% [mag3, phase3, wout3]  = bode(transfer_function3);
% [Gm3,Pm3,Wgm3,Wpm3]    = margin(transfer_function3);

Gm  = 20*log10(Gm)
Gm1 = 20*log10(Gm1)
Gm2 = 20*log10(Gm2)
% Gm3 = 20*log10(Gm3)

xl = [max([wout(1) wout1(1) wout2(1)]) min([wout(end) wout1(end) wout2(end)])];

subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g')
hold on;
grid on;
% xl = xlim;
yl = ylim;
grid on;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2);                                            %Plot phase margin plant
plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin

plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2);                                           %Plot phase margin controller 1
plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin

plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2);                                           %Plot phase margin controller 1
plot(zeros(2001, 1)+Wgm2, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin

plot(Wgm, -Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                        %Mark gain margin plant
plot(Wgm1, -Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                      %Mark gain margin controller 1
plot(Wgm2, -Gm2, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                      %Mark gain margin controller 1

% Annotate Gain Margin
dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

% Annotate Gain Margin
dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm1, 2)) newline 'Frequency = ' num2str(round(Wgm1, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

% Annotate Gain Margin
dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm2, 2)) newline 'Frequency = ' num2str(round(Wgm2, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

xl = [0.01 20]
yl = [-60 60]
xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
title('Closed Pitch Angle Loop Bode - Gain Plot', 'FontSize', 20)
legend({north_velocity_controller_name, north_velocity_controller1_name, north_velocity_controller2_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
hold off;

subplot(2, 1, 2)
semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r', wout2, squeeze(phase2), 'g')
hold on;
grid on;
yl = ylim;

%Plot first one so that legend is correct
plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point

%Plot Phase cross over points
plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point

%Mark Phase cross over points
plot(Wpm2, Pm2-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point

%Plot Phase cross over points
plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
plot(zeros(2001, 1)+Wgm2, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point

%Annotation Boxes
dim = [.2 .5 .5 .5];
str = ['Phase Margin = ' num2str(round(Pm, 2)) newline 'Frequency = ' num2str(round(Wpm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

dim = [.2 .5 .3 .3];
str = ['Phase Margin = ' num2str(round(Pm1, 2)) newline 'Frequency = ' num2str(round(Wpm1, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

dim = [.2 .5 .3 .3];
str = ['Phase Margin = ' num2str(round(Pm2, 2)) newline 'Frequency = ' num2str(round(Wpm2, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Phase (Deg)', 'FontSize', 20);
title('Closed Pitch Angle Loop Bode - Phase Plot', 'FontSize', 20)
legend({north_velocity_controller_name, north_velocity_controller1_name, north_velocity_controller2_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
hold off;
% % 
% % 
% %% Plot Root Locus and highlight the closed loop poles
% figure;
% hold on;
%                  
% %Plot position of closed loop poles
% cl_pole = rlocus(transfer_function2, 1)     ;      
% plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% 
% %Plot position of open loop poles
% ol_pole = rlocus(transfer_function2, 0)      ;    
% plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% 
% %Plot position of open loop zeros
% [pole, zero] = pzmap(feedback(transfer_function2, 1))  ; 
% plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% 
% %Plot Open loop root locus
% rlocus(transfer_function, 'c')   
% 
% title(['Root Locus - ' north_velocity_controller2_name], 'FontSize', 20)
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;
% 
% %% Plot Root Locus and highlight the closed loop poles
% figure;
% hold on;
%                  
% %Plot position of closed loop poles
% cl_pole = rlocus(transfer_function3, 1)     ;      
% plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% 
% %Plot position of open loop poles
% ol_pole = rlocus(transfer_function3, 0)      ;    
% plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% 
% %Plot position of open loop zeros
% [pole, zero] = pzmap(feedback(transfer_function3, 1))  ; 
% plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% 
% %Plot Open loop root locus
% rlocus(transfer_function3, 'c')   
% 
% % title(['Root Locus - ' north_velocity_controller1_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;