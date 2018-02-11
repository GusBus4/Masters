clear all; close all; clc;

%% 


sigma = 10;
r=28;
b=8/3;

t=0:0.01:10;
x0=[2 1 1 2 2 1];


[t,x]=ode45(@Lorenz,t,x0);

plot(t,x)


