close all;


%% plot angles
figure
subplot(3,1,1)
plot(tout,euler_angles_deg(:,1))

subplot(3,1,2)
plot(tout,euler_angles_deg(:,2))

subplot(3,1,3)
plot(tout,euler_angles_deg(:,3))

% figure
% subplot(3,1,1)
% plot(tout,body_rotational_velocity(:,1))
% 
% subplot(3,1,2)
% plot(tout,body_rotational_velocity(:,2))
% 
% subplot(3,1,3)
% plot(tout,body_rotational_velocity(:,3))
% 
% figure
% subplot(3,1,1)
% plot(tout,body_rotational_acceleration(:,1))
% 
% subplot(3,1,2)
% plot(tout,body_rotational_acceleration(:,2))
% 
% subplot(3,1,3)
% plot(tout,body_rotational_acceleration(:,3))
