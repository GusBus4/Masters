clear all; close all; clc;

t=0:0.01:100;

x0=[1 -1 -10];
[t,y]=ode45(@Chua,t,x0);
figure(1)
plot(t,y)


%% Observer system

x0=[1 -1 -10 -1 -2 -1];
[t,y]=ode45(@Chuaobserver,t,x0);

figure(2)
subplot(3,1,1)
plot(t,y(:,1))
subplot(3,1,2)
plot(t,y(:,2))
subplot(3,1,3)
plot(t,y(:,3))

figure(3)
plot3(y(:,1),y(:,2),y(:,3))