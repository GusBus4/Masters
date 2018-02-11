clear all; close all; clc;

t=0:0.01:20;

yr=sin(t);
yrdot=cos(t);
yrddot=-sin(t);


state0 = [0 0 0 0];
[t,output]=ode45(@Pendulum,t,state0);

subplot(3,1,1)
plot(t,output(:,1))
hold on
plot(t,output(:,3),'k')
plot(t,yr,'-.')
xlabel('t')
ylabel('x_1')


subplot(3,1,2)
plot(t,output(:,2))
hold on
plot(t,output(:,4),'k')
plot(t,yrdot,'-.')
xlabel('t')
ylabel('z_2')

subplot(3,1,3)
plot(t,yr'-output(:,1),'k')
hold on
plot(t,yr'-output(:,3),'r')

