clear all; close all; clc;

t=0:0.01:100;
x0=[1 2 3 3 2 1];


[t,x]=ode45(@Chua4,t,x0);
figure
plot(t,x)


figure
plot3(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6))
grid on;
