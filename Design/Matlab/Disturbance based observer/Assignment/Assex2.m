clear all; clc;

t=0:0.01:20;
state0 = [0 1 2 1 0 1 2 1 0 1 2 1];
[t,output]=ode45(@Mobilerobot2,t,state0);

dphi=0.1;

xr     = 10*cos(0.1*t);
xrdot  = -sin(0.1*t);
xrddot = -0.1*cos(0.1*t);
yr     = 10*sin(0.1*t);
yrdot  = cos(0.1*t);
yrddot = -0.1*sin(0.1*t);
vr = sqrt(xrdot.^2+yrdot.^2);

% xr2     = 10*cos(0.1*t+dphi);
% xr2dot  = -sin(0.1*t+dphi);
% xr2ddot = -0.1*cos(0.1*t+dphi);
% yr2     = 10*sin(0.1*t+dphi);
% yr2dot  = cos(0.1*t+dphi);
% yr2ddot = -0.1*sin(0.1*t+dphi);
% 
% xr3     = 10*cos(0.1*t+dphi);
% xr3dot  = -sin(0.1*t+dphi);
% xr3ddot = -0.1*cos(0.1*t+dphi);
% yr3     = 10*sin(0.1*t+dphi);
% yr3dot  = cos(0.1*t+dphi);
% yr3ddot = -0.1*sin(0.1*t+dphi);

xr2=output(:,1)*cos(dphi)+output(:,2)*sin(dphi);
xr3=output(:,5)*cos(dphi)+output(:,6)*sin(dphi);
yr2=-output(:,1)*sin(dphi)+output(:,2)*cos(dphi);
yr3=-output(:,5)*sin(dphi)+output(:,6)*cos(dphi);
xr2dot=-dphi*output(:,1)*sin(dphi)+output(:,2)*dphi*cos(dphi);
xr3dot=-dphi*output(:,5)*sin(dphi)+output(:,6)*dphi*cos(dphi);
yr2dot=-output(:,1)*dphi*cos(dphi)-output(:,2)*dphi*sin(dphi);
yr3dot=-output(:,5)*dphi*cos(dphi)-output(:,6)*dphi*sin(dphi);
xr2ddot=-dphi^2*output(:,1)*cos(dphi)-output(:,2)*dphi^2*sin(dphi);
xr3ddot=-dphi^2*output(:,5)*cos(dphi)-output(:,6)*dphi^2*sin(dphi);
yr2ddot=output(:,1)*dphi^2*sin(dphi)-output(:,2)*dphi^2*cos(dphi);
yr3ddot=output(:,5)*dphi^2*sin(dphi)-output(:,6)*dphi^2*cos(dphi);
vr2 = sqrt(xr2dot.^2+yr2dot.^2);
vr3 = sqrt(xr3dot.^2+yr3dot.^2);




%% plots robot 1
% subplot(3,1,1)
% plot(t,output(:,1))
% hold on
% plot(t,xr)
% xlabel('t')
% ylabel('x_1')
% legend('s','d')
% 
% subplot(3,1,2)
% plot(t,output(:,2))
% hold on
% plot(t,yr)
% xlabel('t')
% ylabel('y_1')
% 
% subplot(3,1,3)
% plot(t,output(:,8))
% hold on
% plot(t,vr)
% xlabel('t')
% ylabel('v_1')
% 
% %% plot robot 2 and 3
% figure(2)
% subplot(3,1,1)
% plot(t,output(:,5))
% hold on
% plot(t,xr2)
% xlabel('t')
% ylabel('x_2')
% legend('s','d')
% 
% subplot(3,1,2)
% plot(t,output(:,6))
% hold on
% plot(t,yr2)
% xlabel('t')
% ylabel('y_2')
% 
% subplot(3,1,3)
% plot(t,output(:,8))
% hold on
% plot(t,vr2)
% xlabel('t')
% ylabel('v_2')
% 
% figure(3)
subplot(3,1,1)
plot(t,output(:,9),'linewidth',1.1)
% hold on
% plot(t,xr3,'-.','linewidth',1.5)
xlabel('t')
ylabel('x_3')
legend('kP=1,kD=1','reference','kP=1,kD=3','kP=3,kD=1','kP=3,kD=3')

subplot(3,1,2)
plot(t,output(:,10),'linewidth',1.1)
% hold on
% plot(t,yr3,'-.','linewidth',1.5)
xlabel('t')
ylabel('y_3')

subplot(3,1,3)
plot(t,output(:,12),'linewidth',1.1)
% hold on
% plot(t,vr3,'-.','linewidth',1.5)
xlabel('t')
ylabel('v_3')


%% plots all robots
% subplot(3,1,1)
% plot(t,output(:,1),t,output(:,5),t,output(:,9),'linewidth',1.1)
% hold on
% plot(t,xr,'-.','linewidth',1.5)
% xlabel('t')
% ylabel('x_1')
% legend('robot 1','robot 2','robot 3','reference')
% 
% subplot(3,1,2)
% plot(t,output(:,2),t,output(:,6),t,output(:,10),'linewidth',1.1)
% hold on
% plot(t,yr,'-.','linewidth',1.5)
% xlabel('t')
% ylabel('y_1')
% 
% subplot(3,1,3)
% plot(t,output(:,4),t,output(:,8),t,output(:,12),'linewidth',1.1)
% hold on
% plot(t,vr,'-.','linewidth',1.5)
% xlabel('t')
% ylabel('v_1')
