s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Yaw
heave_tf                    = (1/(motor_timing_constant*m))/(s + (1/motor_timing_constant));
heave_controller_tf         = 2.9782*(s+9.895)/s;

climb_rate_tf               = feedback(heave_tf*heave_controller_tf, 1)*(1/s);

climb_rate_controller_tf    = 2.8;                                          %P

altitude_tf                 = feedback(climb_rate_controller_tf*climb_rate_tf, 1)*(1/s);

altitude_controller_tf      = 0.92657;                                      %P - This One
altitude_controller1_tf     = 0.70562 * (s + 2.062) * (s + 0.5651) / s;     %PID

transfer_function           = altitude_controller_tf*altitude_tf;
transfer_function1          = altitude_controller1_tf*altitude_tf;

altitude_controller_name    = 'P Controller';
altitude_controller1_name   = 'PID Controller';


%% Plot Step Responses
% figure;
% hold on;
% 
% step(feedback(altitude_tf, 1), 'b')
% step(feedback(transfer_function, 1), 'r')
% step(feedback(transfer_function1, 1), 'g')
% step(feedback(transfer_function2, 1), 'c')
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Unity Feedback', altitude_controller_name, altitude_controller1_name, altitude_controller2_name}, 'FontSize', 16);
% % title('Altitude Controller', 'FontSize', 16)
% grid on;
% 
% hold off;

for i = 1:length(earth_linear_position_no_noise(:,3))
    if earth_linear_position_no_noise(i,3) > 0
        earth_linear_position_no_noise(i,3) = 0;
    end
end

for i = 1:length(dnoise)
    if dnoise(i) > 0
        dnoise(i) = 0;
    end
end

figure;
hold on;

plot(tout, dref, 'LineWidth', 2)
plot(tout, earth_linear_position_no_noise(:, 3), 'LineWidth', 2)
plot(tout_noise, dnoise, 'LineWidth', 2)

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

% figure;
% %% Plot Bode Plot, Highlighting the crossover poles
% [mag, phase, wout]    = bode(altitude_tf);
% [Gm,Pm,Wgm,Wpm]       = margin(altitude_tf);
% 
% [mag1, phase1, wout1]  = bode(transfer_function);
% [Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function)
% 
% [mag2, phase2, wout2]  = bode(transfer_function1);
% [Gm2,Pm2,Wgm2,Wpm2]     = margin(transfer_function1)
% 
% xl = [max([wout(1) wout1(1)]) min([wout(end) wout1(end)])];
% 
% subplot(2, 1, 1)
% semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r', wout2, 20*log10(squeeze(mag2)), 'g')
% hold on;
% grid on;
% % xl = xlim;
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
% % title('Altitude Bode - Gain Plot', 'FontSize', 20)
% legend({'Plant', altitude_controller_name, altitude_controller1_name, 'Gain Crossover Frequencies','Phase Crossover Frequencies'},'FontSize', 16);
% hold off;
% 
% subplot(2, 1, 2)
% semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r', wout2, squeeze(phase2), 'g')
% hold on;
% grid on;
% % xl = xlim;
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
% % title('Altitude Bode - Phase Plot', 'FontSize', 20)
% legend({'Plant', altitude_controller_name, altitude_controller1_name, 'Gain Crossover Frequencies','Phase Crossover Frequencies'},'FontSize', 16);
% hold off;
% % 
% % %% Plot Root Locus and highlight the closed loop poles
% % figure;
% % subplot(1, 2, 1)
% % hold on;             
% % %Plot position of closed loop poles
% % cl_pole = rlocus(transfer_function, 1)           
% % plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% % 
% % %Plot position of open loop poles
% % ol_pole = rlocus(transfer_function, 0)      ;    
% % plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% % 
% % %Plot position of open loop zeros
% % [pole, zero] = pzmap(feedback(transfer_function, 1))  ; 
% % plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% % 
% % %Plot Open loop root locus
% % rlocus(transfer_function, 'c')   
% % 
% % xlim([-15, 1])
% % 
% % % title(['Root Locus - ' altitude_controller_name], 'FontSize', 20)
% % title('P Controller', 'FontSize', 20)
% % xlabel('Imaginary Axis', 'FontSize', 20);
% % ylabel('Real Axis', 'FontSize', 20);
% % legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% % 
% % grid on;
% % hold off;
% % 
% % subplot(1, 2, 2)
% % hold on;             
% % %Plot position of closed loop poles
% % cl_pole = rlocus(transfer_function1, 1)           
% % plot(real(cl_pole),imag(cl_pole),'rs','Markersize',15, 'LineWidth', 5)
% % 
% % %Plot position of open loop poles
% % ol_pole = rlocus(transfer_function1, 0)      ;    
% % plot(real(ol_pole),imag(ol_pole),'bx','Markersize',15, 'LineWidth', 3)
% % 
% % %Plot position of open loop zeros
% % [pole, zero] = pzmap(feedback(transfer_function1, 1))  ; 
% % plot(real(zero),imag(zero),'go','Markersize',10, 'LineWidth', 3)
% % 
% % %Plot Open loop root locus
% % rlocus(transfer_function1, 'c')   
% % 
% % xlim([-15, 1])
% % % title(['Root Locus - ' altitude_controller1_name], 'FontSize', 20)
% % title('PID Controller', 'FontSize', 20)
% % xlabel('Imaginary Axis', 'FontSize', 20);
% % ylabel('Real Axis', 'FontSize', 20);
% % legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% % 
% % grid on;
% % hold off;