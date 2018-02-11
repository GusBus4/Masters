clear all; close all; clc;

t=0:0.01:50;
N=5;
% x0=rand(1,3*N);
x0=ones(1,3*N)-0.01*rand(1,3*N);
% x0=[1 10 1];

[t,x] = ode45(@ChuaBZ3,t,x0);

% plot(t,x)

figure
for n=1:3:N*3-2
    plot3(x(:,n),x(:,n+1),x(:,n+2))
    hold on 
end
grid on;


figure;
for n=1:3:N*3-2
    plot(t,x(:,n))
    hold on
end