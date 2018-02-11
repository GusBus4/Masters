clear all; clc;

t=0:0.01:10;
state0 = [0 1 2 1];
[t,output]=ode45(@Mobilerobot,t,state0);

global kd;
global kp;

xr     = 10*cos(0.1*t);
xrdot  = -sin(0.1*t);
xrddot = -0.1*cos(0.1*t);
yr     = 10*sin(0.1*t);
yrdot  = cos(0.1*t);
yrddot = -0.1*sin(0.1*t);
vr = sqrt(xrdot.^2+yrdot.^2);



subplot(3,1,1)
plot(t,output(:,1),'linewidth',1.1)
% hold on
% plot(t,xr,'-.','linewidth',1.5)
xlabel('t')
ylabel('x_1')
legend('kd=1,kp=1','reference','kd=3,kp=1','kd=1,kp=3','kd=3,kp=3')

subplot(3,1,2)
plot(t,output(:,2),'linewidth',1.1)
% hold on
% plot(t,yr,'-.','linewidth',1.5)
xlabel('t')
ylabel('y_1')




subplot(3,1,3)
plot(t,output(:,4),'linewidth',1.1)
% hold on
% plot(t,vr,'-.','linewidth',1.5)
xlabel('t')
ylabel('v_1')



