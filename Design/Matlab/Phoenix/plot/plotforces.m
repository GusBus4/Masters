% close all;


%% plot forces
% figure(1)
% subplot(3,1,1)
% plot(tout,Frotor(:,1))
% 
% subplot(3,1,2)
% plot(tout,Frotor(:,2))
% 
% subplot(3,1,3)
% plot(tout,Frotor(:,3))

% figure(2)
% subplot(3,1,1)
% plot(tout,Fgravity(:,1))
% 
% subplot(3,1,2)
% plot(tout,Fgravity(:,2))
% 
% subplot(3,1,3)
% plot(tout,Fgravity(:,3))
% 
% figure(3)
% subplot(3,1,1)
% plot(tout,Fdrag(:,1))
% 
% subplot(3,1,2)
% plot(tout,Fdrag(:,2))
% 
% subplot(3,1,3)
% plot(tout,Fdrag(:,3))


figure(4)
subplot(3,1,1)
plot(tout,Ftotal(:,1))

subplot(3,1,2)
plot(tout,Ftotal(:,2))

subplot(3,1,3)
plot(tout,Ftotal(:,3))

figure(5)
subplot(3,1,1)
plot(tout,Moments(:,1))

subplot(3,1,2)
plot(tout,Moments(:,2))

subplot(3,1,3)
plot(tout,Moments(:,3))