clear all; clc;

t=0:0.01:10;
state0 = [1 1 2 1 1 1 2 1 1 1 2 1];
[t,output]=ode45(@Mobilerobot4,t,state0);

d=1;

xr     = 3*t;
xrdot  = 3;
xrddot = 0;
yr     = zeros(length(t),1)
yrdot  = 0;
yrddot = 0;
vr = sqrt(xrdot.^2+yrdot.^2);

xr2=output(:,1)+d;
xr3=output(:,5)+d;
yr2=0;
yr3=0;
xr2dot=3;
xr3dot=3;
yr2dot=0;
yr3dot=0;
xr2ddot=0;
xr3ddot=0;
yr2ddot=0;
yr3ddot=0;
vr2 = sqrt(xr2dot.^2+yr2dot.^2);
vr3 = sqrt(xr3dot.^2+yr3dot.^2);




%% plots robot 1
% subplot(3,1,1)
plot(t,output(:,2),t,output(:,6),'linewidth',1.1)
hold on
plot(t,yr,'-.','linewidth',1.5)
xlabel('t')
ylabel('y_1')
legend('robot 1','robot 2','robot 3','reference 1')
title('time response')


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

%% plot robot 2 and 3
% figure(2)
% subplot(3,1,1)
% plot(t,output(:,5),'linewidth',1.1)
% hold on
% plot(t,xr2,'-.','linewidth',1.5)
% xlabel('t')
% ylabel('x_2')
% 
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
% subplot(3,1,1)
% plot(t,output(:,9),'linewidth',1.1)
% hold on
% plot(t,xr3,'-.','linewidth',1.5)
% xlabel('t')
% ylabel('x_3')
% 
% 
% subplot(3,1,2)
% plot(t,output(:,10))
% hold on
% plot(t,yr3)
% xlabel('t')
% ylabel('y_3')
% 
% subplot(3,1,3)
% plot(t,output(:,12))
% hold on
% plot(t,vr3)
% xlabel('t')
% ylabel('v_3')


