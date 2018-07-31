s = tf('s');

%% Define System Parameters
Izz = 0.170197;
Ixx = 0.025028;
Iyy = 0.16926;

m = 3.352;
g = 9.81;

motor_timing_constant = 0.125;

%% Roll
roll_rate_tf                = (1/(motor_timing_constant*Iyy))/(s*(s + (1/motor_timing_constant)))
roll_rate_controller_tf     = 2.0155 * (s + 5.713) * (s + 1.054) / (s * (s + 16))

roll_angle_tf               = feedback(roll_rate_tf*roll_rate_controller_tf, 1) * (1/s)

% roll_angle_controller_tf    = 0.18474 * (s + 10.11)                       %PD
roll_angle_controller_tf    = 1.006                                         %P

% roll_angle_controller_name  = 'PD Controller'
roll_angle_controller_name = 'P Controller'

transfer_function           = roll_angle_controller_tf*roll_angle_tf;
% transfer_function1          = roll_angle_controller1_tf*roll_angle_tf;
% transfer_function2          = 0;

% %% Plot Step Responses
% figure;
% hold on;
% 
% step(feedback(roll_angle_tf, 1), 'b')
% step(feedback(transfer_function, 1), 'r')
% % step(feedback(transfer_function1, 1), 'g')
% 
% xlabel('Time (seconds)', 'FontSize', 20)
% ylabel('Amplitude', 'FontSize', 20)
% legend({'Unity Feedback', roll_angle_controller_name, roll_angle_controller1_name}, 'FontSize', 16);
% title('Roll Angle Controller', 'FontSize', 16)
% grid on;
% 
% hold off;

figure;
%% Plot Bode Plot, Highlighting the crossover poles
[mag, phase, wout]    = bode(roll_angle_tf);
[Gm,Pm,Wgm,Wpm]       = margin(roll_angle_tf);

[mag1, phase1, wout1]  = bode(transfer_function);
[Gm1,Pm1,Wgm1,Wpm1]     = margin(transfer_function);

Gm = 25.1;
Gm1 = 25;
% [mag2, phase2, wout2]  = bode(transfer_function1);
% [Gm2,Pm2,Wgm2,Wpm2]    = margin(transfer_function1);

xl = [max([wout(1) wout1(1)]) min([wout(end) wout1(end)])];

subplot(2, 1, 1)
semilogx(wout, 20*log10(squeeze(mag)), 'b', wout1, 20*log10(squeeze(mag1)), 'r')
hold on;
yl = ylim;
grid on;

plot(zeros(2001, 1)+Wpm, -1000:1000, 'k--', 'LineWidth', 2);                                            %Plot phase margin plant
plot(zeros(2001, 1)+Wgm, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin

plot(zeros(2001, 1)+Wpm1, -1000:1000, 'k--', 'LineWidth', 2);                                           %Plot phase margin controller 1
plot(zeros(2001, 1)+Wgm1, -1000:1000, 'Color', [0.5 0.5 0.5], 'LineStyle', '--', 'LineWidth', 2);        %Plot gain margin

plot(Wgm, -Gm, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                        %Mark gain margin plant
plot(Wgm1, -Gm1, 'o', 'Color', [0.5 0.5 0.5], 'Markersize', 5, 'LineWidth', 5);                      %Mark gain margin controller 1

% Annotate Gain Margin
dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

% Annotate Gain Margin
dim = [.2 .5 .5 .5];
str = ['Gain Margin = ' num2str(round(Gm1, 2)) newline 'Frequency = ' num2str(round(Wgm, 2))];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 12);

xlim(xl)
ylim(yl)
xlabel('Frequency (Rad/s)', 'FontSize', 20);
ylabel('Magnitude (dB)', 'FontSize', 20);
% title('Closed Roll Angle Loop Bode - Gain Plot', 'FontSize', 20)
legend({'Unity Feedback', roll_angle_controller_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
hold off;

subplot(2, 1, 2)
semilogx(wout, squeeze(phase), 'b', wout1, squeeze(phase1), 'r')
hold on;
grid on;
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
% title('Closed Roll Angle Loop Bode - Phase Plot', 'FontSize', 20)
legend({'Unity Feedback', roll_angle_controller_name, 'Phase Crossover Frequencies', 'Gain Crossover Frequencies'},'FontSize', 16);
hold off;

%% Plot Root Locus and highlight the closed loop poles
% figure;
% % subplot(1,2,1)
% hold on;
%                  
% %Plot position of closed loop poles
% % test = 1
% cl_pole = rlocus(transfer_function, 1)           
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
% xlim([-15 1])
% ylim([-10 10])
% 
% % title(['Root Locus - ' roll_angle_controller_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;
% 
% % %% Plot Root Locus and highlight the closed loop poles
% subplot(1,2,2)
% hold on;
%                  
% %Plot position of closed loop poles
% cl_pole = rlocus(transfer_function1, 1)     ;
% cl_pole(2) = cl_pole(3)
% cl_pole(3) = cl_pole(4)
% plot(real(cl_pole(1:3)),imag(cl_pole(1:3)),'rs','Markersize',15, 'LineWidth', 5)
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
% xlim([-15 1])
% ylim([-15 15])
% 
% % title(['Root Locus - ' roll_angle_controller1_name], 'FontSize', 20)
% title('')
% xlabel('Imaginary Axis', 'FontSize', 20);
% ylabel('Real Axis', 'FontSize', 20);
% legend({'Closed Loop Poles', 'Open Loop Poles', 'Zeros'}, 'FontSize', 16)
% 
% grid on;
% hold off;