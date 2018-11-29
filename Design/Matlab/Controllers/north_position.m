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

north_velocity_controller_tf       = 0.4425 * (s+0.042) / (s + 0.0105);   %Lag

north_position_tf                   = feedback(north_velocity_controller_tf*north_velocity_tf, 1) * 1/s

north_position_controller_tf        = 0.151

north_position_controller_name      = 'P Controller'

transfer_function                   = north_position_controller_tf*north_position_tf;

% for i = 1:length(earth_linear_position_no_noise(:,1))
%     if earth_linear_position_no_noise(i,1) > 0
%         earth_linear_position_no_noise(i,1) = 0;
%     end
% end
% 
% for i = 1:length(dnoise)
%     if dnoise(i) > 0
%         dnoise(i) = 0;
%     end
% end

figure;
hold on;

plot(tout, nref, 'LineWidth', 2)
plot(toutnonoise, nnonoise, 'LineWidth', 2)
plot(tout, earth_linear_position_no_noise(:, 1), 'LineWidth', 2)

% plot(tout, a5.Data, 'LineWidth', 2)
yl = ylim;
% plot(zeros(2001, 1)+20, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection

% info = stepinfo(feedback(heave_controller_tf*heave_tf, 1));

xlabel('Time (seconds)', 'FontSize', 20)
ylabel('Amplitude', 'FontSize', 20)
legend({'Reference', 'Simulated Dynamics', 'Simulated Model with Noise'}, 'FontSize', 16);
% title('Heave Controller - Step Responses', 'FontSize', 20)
ylim(yl)
grid on;

hold off;

% %% Plot Step Responses
% figure;
% hold on;
% 
% desired_n_unit.Data = desired_n.Data%/max(desired_n.Data);
% north_pos_unit_p.Data = actual_n.Data%/max(desired_n.Data);
% north_pos_unit_pl.Data = actual_n_limits.Data%/max(desired_n.Data);
% 
% plot(toutlagp, desired_n_unit.Data, 'LineWidth', 2)
% plot(toutlagp, north_pos_unit_p.Data, 'LineWidth', 2)
% plot(toutlag, north_pos_unit_pl.Data, 'LineWidth', 2)
% 
% yl = ylim;
% % plot(zeros(2001, 1)+10, -1000:1000, 'k--', 'LineWidth', 2);               %Plot Disturbance injection
% % plot(tout, roll_rate_leadpi_nolimits.Data, 'LineWidth', 2)
% % plot(tout, roll_rate_leadpi_limits.Data, 'LineWidth', 2)
% ylim(yl);
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Reference', 'Unlimited System', 'Limited System'}, 'FontSize', 16);
% % title('Heave Controller - Step Responses', 'FontSize', 20)
% grid on;
% 
% hold off;

% figure;
% %% Plot Bode Plot, Highlighting the crossover poles
% [mag, phase, wout]    = bode(north_position_tf);
% [Gm,Pm,Wgm,Wpm]       = margin(north_position_tf);
% 
% [mag1, phase1, wout1]  = bode(transfer_function);
% [Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);
% 
% Gm  = 20*log10(Gm)
% Gm1 = 20*log10(Gm1)
% 
% xl = [max([wout(1) wout1(1)]) min([wout(end) wout1(end)])];
% 
% subplot(2, 1, 1)
% semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r')
% hold on;
% grid on;
% % xl = xlim;
% yl = ylim;
% grid on;
% 
% plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2);                                            %Plot phase margin plant
% plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin
% 
% plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2);                                           %Plot phase margin controller 1
% plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin
% 
% plot(Wgm, -Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                        %Mark gain margin plant
% plot(Wgm1, -Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                      %Mark gain margin controller 1
% 
% % Annotate Gain Margin
% dim = [.2 .5 .5 .5];
% str = ['Gain Margin = ' num2str(round(Gm, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% % Annotate Gain Margin
% dim = [.2 .5 .5 .5];
% str = ['Gain Margin = ' num2str(round(Gm1, 2)) newline 'Frequency = ' num2str(round(Wgm1, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% xl = [0.01 20]
% yl = [-60 60]
% xlim(xl)
% ylim(yl)
% xlabel('Frequency (Rad/s)', 'FontSize', 20);
% ylabel('Magnitude (dB)', 'FontSize', 20);
% % title('Closed Pitch Angle Loop Bode - Gain Plot', 'FontSize', 20)
% legend({'Plant', north_position_controller_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
% hold off;
% 
% subplot(2, 1, 2)
% semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r')
% hold on;
% grid on;
% yl = ylim;
% 
% %Plot first one so that legend is correct
% plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% 
% %Plot Phase cross over points
% plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2); %Mark Plot cross over point
% 
% %Mark Phase cross over points
% plot(Wpm1, Pm1-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% plot(Wpm, Pm-180, 'ko', 'Markersize', 5, 'LineWidth', 5); %Mark Plot cross over point
% 
% %Plot Phase cross over points
% plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2); %Mark Plot cross over point
% 
% %Annotation Boxes
% dim = [.2 .5 .5 .5];
% str = ['Phase Margin = ' num2str(round(Pm, 2)) newline 'Frequency = ' num2str(round(Wpm, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% dim = [.2 .5 .3 .3];
% str = ['Phase Margin = ' num2str(round(Pm1, 2)) newline 'Frequency = ' num2str(round(Wpm1, 2))];
% annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);
% 
% 
% xlim(xl)
% ylim(yl)
% xlabel('Frequency (Rad/s)', 'FontSize', 20);
% ylabel('Phase (Deg)', 'FontSize', 20);
% % title('Closed Pitch Angle Loop Bode - Phase Plot', 'FontSize', 20)
% legend({'Plant', north_position_controller_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
% hold off;
% % % 
% % % 
% %% Plot Root Locus and highlight the closed loop poles
% figure;
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
% title(['Root Locus - ' north_position_controller_name], 'FontSize', 20)
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;

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
% % title(['Root Locus - ' north_position_controller1_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;