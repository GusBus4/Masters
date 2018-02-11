clear all; close all; clc;

t=0:0.01:20;
state0 = [1 -1 2 0.5 -0.5 5];
[t,output]=ode45(@Chuacoupled,t,state0);

subplot(3,1,1)
plot(t,output(:,1))
hold on
plot(t,output(:,4),'-.')
xlabel('t')
ylabel('x_1')

subplot(3,1,2)
plot(t,output(:,2))
hold on
plot(t,output(:,5),'-.')
xlabel('t')
ylabel('y_1')

subplot(3,1,3)
plot(t,output(:,3))
hold on
plot(t,output(:,6),'-.')
xlabel('t')
ylabel('z_1')



