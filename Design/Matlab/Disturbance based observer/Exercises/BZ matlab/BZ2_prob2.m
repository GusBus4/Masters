close all
clear all
clc

t=0:0.01:20;

m1 = 5;
m2 = 6;
I1 = 3;
I2 = 3;
l1 = 4;
l2 = 4;
g = 9.81;

r1 = sin(t)+5*cos(0.2*t);
r1d = cos(t)-sin(0.2*t);
r1dd = -sin(t)-0.2*cos(0.2*t);

r2 = sin(0.5*t);
r2d = 0.5*cos(0.5*t);
r2dd = -0.25*sin(0.5*t);

dx0 = [1; 2; 0.5; 1];
[t, output] = ode45(@sim_bz22, t, dx0);

q1 = output(:,1);
q2 = output(:,2);
q1d = output(:,3);
q2d = output(:,4);

subplot(2,2,1)
plot(t, q1, 'b');
hold on
plot(t,r1,'--r')

subplot(2,2,2)
plot(t, q2,'b');
hold on
plot(t,r2,'--r')

subplot(2,2,3)
plot(t, q1d, 'b');
hold on
plot(t,r1d,'--r')

subplot(2,2,4)
plot(t, q2d, 'b');
hold on
plot(t,r2d,'--r')