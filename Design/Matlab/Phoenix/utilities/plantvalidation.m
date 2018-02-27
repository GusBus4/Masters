clc;
close all;

%% variables
fs=4096;                            %sample frequency
Ts=0.0025;                          %sample time - 400Hz
Outer_Ts = Ts;

%% FRF settings
nfft = 2*fs;                        %number of windows
window = hann(nfft);
Ntrans = 1;                         %setting time (frame)
Nrep = 2;                           %repeats
% t = 0:Ts:(Nrep+Ntrans)*nfft/fs-Ts;  %time in simulink
% t=0:Ts:nfft/fs-Ts;

dtzoh = 0.01;

plotEnableroll = 0;
plotEnablepitch = 0;
plotEnableyaw = 0;
plotEnablePosition = 0;
plotEnableall = 1;

plotEnableForces = 0;
plotEnableRotationalVelocity = 0;
plotEnableLeanAngles = 0;
plotEnableGlobalAcceleration = 0;
plotEnableBodyAcceleration = 0;
plotEnableLinearVelocity = 1;
plotEnableGlobalPosition = 1;

p = bodeoptions;
p.Phasewrapping = 'on';
t = linspace(0,tout(end),length(euler_angles_rad))';

%% Plot Moments and Forces
if plotEnableForces == 1
    figure
    subplot(5,1,1)
    plot(tout,moments(:,1))
    xlabel('tout in seconds')
    ylabel('Roll Moment')
    title('Moments and Forces')
    subplot(5,1,2)
    plot(tout,moments(:,2))
    xlabel('tout in seconds')
    ylabel('Pitch moment')
    subplot(5,1,3)
    plot(tout,moments(:,3))
    xlabel('tout in seconds')
    ylabel('Yaw Moment')
    subplot(5,1,4)
    plot(t,forces(:,3))
    xlabel('tout in seconds')
    ylabel('Z Body Force Total')
    subplot(5,1,5)
    plot(tout,forces1(:,3))
    xlabel('tout in seconds')
    ylabel('Z Rotor Force')
end
%% Plot Rotational Velocity
if plotEnableRotationalVelocity == 1
    figure
    subplot(3,1,1)
    plot(t,body_rotational_velocity(:,1),t,refrollrate)
    xlabel('tout in seconds')
    ylabel('Roll Angular Rate in rad/s')
    legend('roll','reference roll')
    title('Lean Rates')
    subplot(3,1,2)
    plot(t,body_rotational_velocity(:,2),t,refpitchrate)
    xlabel('tout in seconds')
    ylabel('Pitch Angular Rate in rad/s')
    legend('pitch','reference pitch')
    subplot(3,1,3)
    plot(t,body_rotational_velocity(:,3),t,refyawrate)
    xlabel('tout in seconds')
    ylabel('Yaw Angular Rate in rad/s')
    legend('yaw','reference yaw')
end
  %% Plot Lean Angles
if plotEnableLeanAngles == 1
    figure
    subplot(3,1,1)
    plot(t,euler_angles_rad(:,1))
    xlabel('tout in seconds')
    ylabel('Roll in rad')
    legend('roll')
    title('Lean angles')
    subplot(3,1,2)
    plot(t,euler_angles_rad(:,2))
    xlabel('tout in seconds')
    ylabel('Pitch in rad')
    legend('pitch')
    subplot(3,1,3)
    plot(t,euler_angles_rad(:,3))
    xlabel('tout in seconds')
    ylabel('Yaw in rad')
    legend('yaw')
end
  %% Plot Linear Acceleration
if plotEnableGlobalAcceleration == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t, earth_linear_acceleration(:,1), t, refxaccel);
    legend('x', 'xref');
    xlabel('tout in seconds');
    ylabel('Earth linear Accel X');
    title('Linear Acceleration');
    subplot(3,1,2);
    plot(t, earth_linear_acceleration(:,2), t, refyaccel);
    legend('y', 'yref')
    xlabel('tout in seconds');
    ylabel('Earth linear Accel Y');
    subplot(3,1,3);
    plot(t, earth_linear_acceleration(:,3), t, refzaccel);
    legend('z', 'zref')
    xlabel('tout in seconds');
    ylabel('Earth linear Accel Z');
    hold off;
end
  %% Plot Body Acceleration
if plotEnableBodyAcceleration == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t, body_linear_acceleration(:,1), t, refxaccel);
    legend('x', 'xref');
    xlabel('tout in seconds');
    ylabel('Body linear Accel X');
    title('Body Linear Acceleration');
    subplot(3,1,2);
    plot(t, body_linear_acceleration(:,2), t, refyaccel);
    legend('y', 'yref')
    xlabel('tout in seconds');
    ylabel('Body linear Accel Y');
    subplot(3,1,3);
    plot(t, body_linear_acceleration(:,3), t, refzaccel);
    legend('z', 'zref')
    xlabel('tout in seconds');
    ylabel('Body linear Accel Z');
    hold off;
end
if plotEnableLinearVelocity == 1
    %% Plot Linear Velocity
    figure;
    hold on;
    subplot(3,1,1);
    plot(t,earth_linear_velocity(:,1),t, refxvel_e);
    legend('x', 'xref');
    xlabel('tout in seconds');
    ylabel('Earth linear Velocity X');
    title('Linear Velocity');
    subplot(3,1,2);
    plot(t,earth_linear_velocity(:,2), t, refyvel_e);
    legend('y', 'yref')
    xlabel('tout in seconds');
    ylabel('Earth linear Velocity Y');
    subplot(3,1,3);
    plot(t,earth_linear_velocity(:,3), t, refzvel_e);
    legend('z', 'zref')
    xlabel('tout in seconds');
    ylabel('Earth linear Velocity Z');
    hold off;
end
    %% Plot Global Position
if plotEnableGlobalPosition == 1
    figure;
    hold on;
    subplot(3,1,1);
    plot(t,earth_linear_position(:,1),t, refxpos, 'Linewidth', 1.5);
    legend('N', 'Nref');
    xlabel('tout in seconds');
    ylabel('Earth linear position North');
    title('Global Position');
    subplot(3,1,2);
    plot(t,earth_linear_position(:,2), t, refypos, 'Linewidth', 1.5);
    legend('E', 'Eref')
    xlabel('tout in seconds');
    ylabel('Earth linear position East');
    subplot(3,1,3);
    plot(t,earth_linear_position(:,3), t, refzpos, 'Linewidth', 1.5);
    legend('D', 'Dref')
    xlabel('tout in seconds');
    ylabel('Earth linear position Down');
    hold off;
end





















%% FRF load
% load data
% load u
% u=ans(2,:);
% 
% load d
% d=ans(2,:);
% 
% load y
% y=ans(2,:);


% removes first repetition
% d1_frf = d(Ntrans*nfft+1:end,1);
% u1_frf = u(Ntrans*nfft+1:end,1);
% y1_frf = y(Ntrans*nfft+1:end,1);
% d1_frf = d(:,1);
% u1_frf = u(:,1);
% y1_frf = y(:,1);

%% 3 points method FRF
% % sensitivity
% [S1_frf,F] = tfestimate(d1_frf,u1_frf,window,[],nfft,fs);                   %F equals frequency
% Ms1 = mag2db(abs(S1_frf));                                                  %magnitude of the complex numbers
% Ps1 = angle(S1_frf)*(180/pi);                                               %phase of the complex numbers
% [CohS,F]=mscohere(d1_frf,u1_frf,window,[],nfft,fs);                           %Coherence
% 
% % Process sensitivity
% [PS1_frf,F] = tfestimate(d1_frf,y1_frf,window,[],nfft,fs);                  %F equals frequency
% Mps1 = mag2db(abs(PS1_frf));
% Pps1 = angle(PS1_frf)*(180/pi);
% [CohPS,F]=mscohere(d1_frf,y1_frf,window,[],nfft,fs);                           %Coherence
% 
% %Plant
% P1_frf = PS1_frf./S1_frf;
% Mp1 = mag2db(abs(P1_frf));
% Pp1 = angle(P1_frf)*(180/pi);
% 
% %% Open loop estimation
% % P1_frf = tfestimate(y1_frf,u1_frf,window,[],nfft,fs);
% % Mp1 = mag2db(abs(P1_frf));
% % Pp1 = angle(P1_frf)*(180/pi);
% 
% 
% %% plots
% % plant
% figure
% subplot(2,1,1)
% semilogx(F*2*pi,Mp1);
% title('Bode diagram Plant')
% xlabel('Frequency [rad/s]')
% ylabel('Magnitude [DB]')
% subplot(2,1,2)
% semilogx(F*2*pi,Pp1);
% xlabel('Frequency [rad/s]')
% ylabel('Phase [degrees]')
% 
% %Sensitivity
% figure
% subplot(3,1,1)
% semilogx(F,Ms1);
% title('Sensitivity')
% xlabel('Frequency [rad/s]')
% ylabel('Magnitude [DB]')
% subplot(3,1,2)
% semilogx(F,Ps1);
% xlabel('Frequency [rad/s]')
% ylabel('Phase [degrees]')
% subplot(3,1,3)
% semilogx(F,CohS)
% xlabel('Frequency [rad/s]')
% ylabel('Coherence [-]')
% 
% %Process Sensitivity
% figure
% subplot(3,1,1)
% semilogx(F*2*pi,Mps1);
% title('Process Sensitivity')
% xlabel('Frequency [rad/s]')
% ylabel('Magnitude [DB]')
% subplot(3,1,2)
% semilogx(F*2*pi,Pps1);
% xlabel('Frequency [rad/s]')
% ylabel('Phase [degrees]')
% subplot(3,1,3)
% semilogx(F*2*pi,CohPS)
% xlabel('Frequency [rad/s]')
% ylabel('Coherence [-]')


%% Extra plots
if plotEnableall == 1
%     figure;
%     plot(tout,RCOUT_limit_check)
%     xlabel('tout in seconds')
%     ylabel('PWM')
%     legend('RCOUT1','RCOUT2','RCOUT3','RCOUT4')
%     title('RCOUT_limit_check')
%     
%     figure;
%     plot(tout,moment)
%     xlabel('tout in seconds')
%     ylabel('Moments in Nm')
%     legend('roll','pitch','yaw')
%     title('Moments')
%     
%     figure;
%     plot(tout,force)
%     xlabel('tout in seconds')
%     ylabel('Forces in N')
%     legend('x','y','z')
%     title('Forces')
    
%     figure
%     subplot(2,1,1)
%     plot(tout,d)
%     xlabel('tout')
%     ylabel('d')
%     legend('roll','pitch','yaw')
%     subplot(2,1,2)
%     plot(tout,dhat)
%     xlabel('tout')
%     ylabel('dhat')
%     legend('roll','pitch','yaw')
    
%     figure;
%     plot(tout,earth_linear_position(:,3),tout,zref)
%     xlabel('tout in seconds')
%     ylabel('z in meters')
%     legend('z','reference')
   
%       figure;
%       subplot(3,1,1)
%       plot(t,body_rotational_velocity_est(:,1),tout,refroll,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('Roll rate in centideg/s')
%       legend('Roll rate','reference')
%       title('Angular rates')
%       subplot(3,1,2)
%       plot(t,body_rotational_velocity_est(:,2),tout,refpitch,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('pitch rate in centideg/s')
%       legend('Pitch rate','reference')
%       subplot(3,1,3)
%       plot(t,body_rotational_velocity_est(:,3),tout,refyawrate,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('yaw rate in centideg/s')
%       legend('Yaw rate','reference')
%       
%       figure;
%       subplot(3,1,1)
%       plot(t,body_rotational_velocity_est(:,1)-refroll1,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('Error')
%       title('Error Rotational Rates')
%       subplot(3,1,2)
%       plot(t,body_rotational_velocity_est(:,2)-refpitch1,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('Error')
%       subplot(3,1,3)
%       plot(t,body_rotational_velocity_est(:,3)-refyawrate1,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('Error')
%       
%       
%       figure;
%       subplot(2,1,1)
%       plot(tout,euler_angles_rad_est(:,1),tout,refroll,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('Roll in rad')
%       legend('Roll','reference')
%       title('Lean Angles')
%       subplot(2,1,2)
%       plot(tout,euler_angles_rad_est(:,2),tout,refpitch,'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('pitch in rad')
%       legend('Pitch','reference')

% figure; plot(t,z3,t,dNW(:,1),'linewidth',1.5)
% legend('dhat','dNW')
% title('Estimating disturbance estimation')
% figure; plot(t,z1(:,1),t,refroll1,t,euler_angles_rad(:,1),'linewidth',1.5)
% title('Estimated Roll')
% legend('Estimated Roll','ref','Raw roll')
% figure; plot(t,z2(:,1),t,refroll,t,body_rotational_velocity(:,1),'linewidth',1.5)
% title('Estimated roll rate')
% legend('Estimated Roll Rate','ref','Raw Roll rate')
% 
% figure; plot(t,z3,t,dNW(:,2),'linewidth',1.5)
% legend('dhat','dNW')
% title('Estimating disturbance estimation')
% figure; plot(t,z1(:,2),t,refpitch1,t,euler_angles_rad(:,2),'linewidth',1.5)
% title('Estimated Pitch')
% legend('Estimated Pitch','ref','Raw Pitch')
% figure; plot(t,z2(:,2),t,refpitch,t,body_rotational_velocity(:,2),'linewidth',1.5)
% title('Estimated Pitch rate')
% legend('Estimated Pitch Rate','ref','Raw Pitch rate')

% figure; plot(t,z3,t,dNW(:,1),'linewidth',1.5)
% legend('dhat','dNW')
% title('Estimating disturbance estimation')
% figure; plot(t,z1(:,1),t,refyaw1,t,euler_angles_rad(:,e),'linewidth',1.5)
% title('Estimated Roll')
% legend('Estimated Roll','ref','Raw roll')
% figure; plot(t,z2(:,1),t,refroll,t,body_rotational_velocity(:,1),'linewidth',1.5)
% title('estimated roll rate')
% legend('Estimated Roll Rate','ref','Raw Roll rate')
%% plot kalmanestimations

%       figure;
%       subplot(3,1,1)
%       plot(t,earth_linear_velocity(:,1),t,earth_linear_velocity_est(:,1),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('U in m/s')
%       legend('Raw u','ref')
%       title('Earth-frame velocity')
%       subplot(3,1,2)
%       plot(t,earth_linear_velocity(:,2),t,earth_linear_velocity_est(:,2),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('V in m/s')
%       legend('Raw v','State estimate')
%       subplot(3,1,3)
%       plot(t,earth_linear_velocity(:,3),t,earth_linear_velocity_est(:,3),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('W in m/s')
%       legend('Raw W','Kalman estimation')
%            
%       figure;
%       subplot(3,1,1)
%       plot(t,earth_linear_position(:,1),t,earth_linear_position_est(:,1),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('x in m')
%       legend('Raw x','State estimate')
%       title('Earth-frame position')
%       subplot(3,1,2)
%       plot(t,earth_linear_position(:,2),t,earth_linear_position_est(:,2),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('y in m')
%       legend('Raw y','State estimate')
%       subplot(3,1,3)
%       plot(t,earth_linear_position(:,3),t,earth_linear_position_est(:,3),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('z in m')
%       legend('Raw z','Kalman estimation')
%     
%       figure;
%       subplot(3,1,1)
%       plot(t,euler_angles_rad(:,1),t,euler_angles_rad_est(:,1),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('roll in rad')
%       legend('Raw roll','State estimate')
%       title('Lean angles')
%       subplot(3,1,2)
%       plot(t,euler_angles_rad(:,2),t,euler_angles_rad_est(:,2),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('pitch in rad')
%       legend('Raw pitch','State estimate')
%       subplot(3,1,3)
%       plot(t,euler_angles_rad(:,3),t,euler_angles_rad_est(:,3),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('yaw in rad')
%       legend('Raw yaw','Kalman estimation')
%       
%       figure;
%       subplot(3,1,1)
%       plot(t,body_rotational_velocity(:,1),t,body_rotational_velocity_est(:,1),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('roll in rad/s')
%       legend('Raw roll rate','State estimate')
%       title('Rotational Rates')
%       subplot(3,1,2)
%       plot(t,body_rotational_velocity(:,2),t,body_rotational_velocity_est(:,2),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('pitch in rad/s')
%       legend('Raw pitch rate','ref')
%       subplot(3,1,3)
%       plot(t,body_rotational_velocity(:,3),t,body_rotational_velocity_est(:,3),'linewidth',1.5)
%       xlabel('tout in seconds')
%       ylabel('yaw in rad/s')
%       legend('raw yaw rate','Kalman estimation')      



end

% % save('pitchstepcontinuous.mat')

