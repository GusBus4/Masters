clear all; close all; clc;

s=tf('s');
kp=0.2;
kd=0.7;
tau=0.1;

theta=0:0.01:0.1;


G=1/(tau*s^3+s^2);
K=kp+kd*s;


for n=1:length(theta)
    h=1;
    L2=0;
    while L2< 1.0001 && h>0.01
        h=h-0.01;
        H=1+h*s;
        [num,den]=pade(theta(n),2);
        D=tf(num,den);
        Gamma=1/H*(D+G*K)/(1+G*K);
%         Gamma=pade(Gamma,2);
        L2=norm(Gamma,inf);
        
    end
    hmin(n)=h;
end
hmin

plot(theta,hmin)
xlabel('\theta')
ylabel('h_{min}')
