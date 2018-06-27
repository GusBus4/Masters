s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Yaw
yaw_rate_tf                = (1/(motor_timing_constant*Izz))/(s*(s + (1/motor_timing_constant)))
yaw_rate_controller_tf     = 0.420;

yaw_angle_tf               = feedback(yaw_rate_tf*yaw_rate_controller_tf, 1) * (1/s)

yaw_angle_controller2_tf      = 0.86952                                     % P
yaw_angle_controller_tf     = 0.78433 * (s + 0.2905) / s                   % PI
yaw_angle_controller1_tf     = 0.3333 * (s+0.5) * (s+3) / s        % PID

yaw_angle_controller_name       = 'PI Controller'
yaw_angle_controller1_name      = 'PID Controller'

transfer_function           = yaw_angle_controller_tf*yaw_angle_tf;
transfer_function1          = yaw_angle_controller1_tf*yaw_angle_tf;
transfer_function2          = 0;

%% Plot Step Responses
% figure;
% hold on;
% 
% step(feedback(yaw_angle_tf, 1), 'b')
% step(feedback(transfer_function, 1), 'r')
% step(feedback(transfer_function1, 1), 'g')
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Unity Feedback', yaw_angle_controller_name, yaw_angle_controller1_name}, 'FontSize', 16);
% title('Yaw Angle Controller', 'FontSize', 16)
% grid on;
% 
% hold off;

figure;
hold on;

plot(tout, desired_yaw_angle.Data, 'LineWidth', 2)
plot(tout, yaw_angle_pi_control.Data, 'LineWidth', 2)
plot(tout, yaw_angle_pi_control_offset.Data, 'LineWidth', 2)
plot(tout, yaw_angle_pid_control.Data, 'LineWidth', 2)
plot(tout, yaw_angle_pid_control_offset.Data, 'LineWidth', 2)
% plot(tout, yaw_angle_pid_control.Data, 'LineWidth', 2)
yl = ylim;
% plot(zeros(2001, 1)+20, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Reference', 'PI Controller excl. offset', 'PI Controller incl. offset', 'PID Controller excl. offset', 'PID Controller incl. offset'}, 'FontSize', 16);
% title('Heave Controller - Step Responses', 'FontSize', 20)
ylim(yl)
grid on;

hold off;

%% Plot Impulse
% figure;
% hold on;
% plot(desired_yaw.Data, 'LineWidth', 2)
% plot(desired_yaw_pid.Data, 'LineWidth', 2)
% grid on;
% legend({'Impulse PI Controller', 'Impulse PID Controller'}, 'FontSize', 16);
% set(gca,'xticklabel',[])
% xlim([0 6000])
% hold off;

% % Plot Yaw RCOUTs
% figure;
% hold on;
% subplot(2, 2, 2)
% plot(motor_thrust.Data(:, 1), 'LineWidth', 2)
% grid on;
% legend({'Motor 1'}, 'FontSize', 16);
% set(gca,'xticklabel',[])
% xlim([0 6000])
% 
% subplot(2, 2, 3)
% plot(motor_thrust.Data(:, 2), 'LineWidth', 2)
% grid on;
% legend({'Motor 2'}, 'FontSize', 16);
% set(gca,'xticklabel',[])
% xlim([0 6000])
% 
% subplot(2, 2, 1)
% plot(motor_thrust.Data(:, 3), 'LineWidth', 2)
% grid on;
% legend({'Motor 3'}, 'FontSize', 16);
% set(gca,'xticklabel',[])
% xlim([0 6000])
% 
% subplot(2, 2, 4)
% plot(motor_thrust.Data(:, 4), 'LineWidth', 2)
% grid on;
% legend({'Motor 4'}, 'FontSize', 16);
% set(gca,'xticklabel',[])
% xlim([0 6000])
% 
% hold off;

% %% Plot Bode Plot, Highlighting the crossover poles
% [mag, phase, wout]    = bode(yaw_angle_tf);
% [Gm,Pm,Wgm,Wpm]       = margin(yaw_angle_tf);
% 
% [mag1, phase1, wout1]  = bode(transfer_function);
% [Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);
% 
% [mag2, phase2, wout2]  = bode(transfer_function1);
% [Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);
% 
% xl = [max([wout(1) wout1(1) wout2(1)]) min([wout(end) wout1(end) wout2(end)])];
% 
% figure;
% subplot(2, 1, 1)
% semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g')
% hold on;
% grid on;
% yl = ylim;
% 
% plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% % plot(Wpm2, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% % plot(Wpm1, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% % plot(Wpm, 0, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% plot(Wgm, -10-Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% plot(Wgm1, -10-Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wgm2, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% plot(Wgm2, -10-Gm2, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% dim = [.2 .5 .3 .3];
% str = ['Gain Margin = ' num2str(round(Gm1, 2)) newline 'Frequency = ' num2str(round(Wgm1, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% dim = [.2 .5 .5 .5];
% str = ['Gain Margin = ' num2str(round(Gm, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% xlim(xl)
% ylim(yl)
% xlabel('Frequency (Rad/s)', 'FontSize', 20);
% ylabel('Magnitude (dB)', 'FontSize', 20);
% % title('Closed Yaw Angle Loop Bode - Gain Plot', 'FontSize', 20)
% legend({'Unity Feedback', yaw_angle_controller_name, yaw_angle_controller1_name, 'Gain Crossover Frequencies','Phase Crossover Frequencies'},'FontSize', 16);
% hold off;
% 
% subplot(2, 1, 2)
% semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r', wout2, squeeze(phase2), 'g')
% hold on;
% grid on;
% yl = ylim;
% 
% plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(zeros(2001, 1)+Wpm2, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(Wpm2, Pm2-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% % plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% % plot(Wgm, -10-Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% % plot(Wgm1, -10-Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% plot(zeros(2001, 1)+Wgm2, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% % plot(Wgm2, -10-Gm2, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% dim = [.2 .5 .3 .3];
% str = ['Phase Margin = ' num2str(round(Pm1, 2)) newline 'Frequency = ' num2str(round(Wpm1, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% dim = [.2 .5 .5 .5];
% str = ['Phase Margin = ' num2str(round(Pm, 2)) newline 'Frequency = ' num2str(round(Wpm, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% dim = [.2 .5 0 0];
% str = ['Phase Margin = ' num2str(round(Pm2, 2)) newline 'Frequency = ' num2str(round(Wpm2, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% xlim(xl)
% ylim(yl)
% xlabel('Frequency (Rad/s)', 'FontSize', 20);
% ylabel('Phase (Deg)', 'FontSize', 20);
% % title('Closed Yaw Angle Loop Bode - Phase Plot', 'FontSize', 20)
% legend({'Unity Feedback', yaw_angle_controller_name, yaw_angle_controller1_name, 'Gain Crossover Frequencies','Phase Crossover Frequencies'},'FontSize', 16);
% hold off;
% 
% %% Plot Root Locus and highlight the closed loop poles
% figure;
% subplot(1,2,2)
% hold on;
%                  
% %Plot position of closed loop poles
% cl_pole = rlocus(transfer_function1, 1)     ;      
% plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% 
% %Plot position of open loop poles
% ol_pole = rlocus(transfer_function1, 0)      ;    
% plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% 
% %Plot position of open loop zeros
% [pole, zero] = pzmap(feedback(transfer_function1, 1))  ; 
% plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% 
% %Plot Open loop root locus
% rlocus(transfer_function1, 'c')   
% 
% xlim([-6 1])
% ylim([-10 10])
% % title(['Root Locus - ' yaw_angle_controller1_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles'}, 'FontSize', 16)
% 
% grid on;
% hold off;
% 
% subplot(1,2,1)
% hold on;
%                  
% %Plot position of closed loop poles
% cl_pole = rlocus(transfer_function, 1)     ;      
% plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% 
% %Plot position of open loop poles
% ol_pole = rlocus(transfer_function, 0)      ;    
% plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% 
% %Plot position of open loop zeros
% [pole, zero] = pzmap(feedback(transfer_function, 1))  ; 
% plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% 
% %Plot Open loop root locus
% rlocus(transfer_function, 'c')   
% 
% xlim([-6 1])
% ylim([-10 10])
% % title(['Root Locus - ' yaw_angle_controller_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;