clear all; close all; clc;

t     = linspace(0,20,1000);
x_0   = [0.1 -0.1 0.1 0.1 -0.1 0.1];
[t,x] = ode45(@DOBC,t,x_0);

figure
subplot(3,1,1)
plot(t,x(:,1),t,x(:,4)); 
subplot(3,1,2)
plot(t,x(:,2),t,x(:,5)); 
subplot(3,1,3)
plot(t,x(:,3),t,x(:,6)); 
legend('1')
% figure
% subplot(3,1,1)
% plot(t,x(:,1)); 
% subplot(3,1,2)
% plot(t,x(:,2)); 
% subplot(3,1,3)
% plot(t,x(:,3));






%% Links
% % http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=7265050
% % http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8091439
% % http://ieeexplore.ieee.org/document/1372532/?part=undefined%7Cdeqn1#deqn1
% %% Robust DBOC
% % http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=679007

%% exp fits
% arx = -0.03908;
% brx = -28.74;
% ary = 0.0644;
% bry = -28.54;
% 
% Ar = [1.1232*exp(-28.74*xs) 0                      0;
%       0                     -1.838*exp(-28.54*xs)  0
%       0                     0                      0];