clear; close all; clc
options = odeset('RelTol',1e-7,'AbsTol',1e-9);

t=linspace(0,20,1000);
x0 = [10 8 9];
[t,x]=ode45(@Rossler,t,x0,options);

plot(t,x)

% Transformed system
% options = odeset('RelTol',1e-7,'AbsTol',1e-9);
x0 = [10 -10 10 8 -4 1];
[t,x] = ode45(@Rossler_eta,t,x0,options);
figure
subplot(3,1,1)
plot(t,x(:,1),t,x(:,4)); 
subplot(3,1,2)
plot(t,x(:,2),t,x(:,5)); 
subplot(3,1,3)
plot(t,x(:,3),t,x(:,6)); 