%% experiment
close all; clear all; clc;
x=[0;1;2;3;4;5;0;1;2;3;4;5];
lb=[0.51;0.59;0.65;0.73;0.78;0.84];
ub=[10;9.7;5.86;4.7;4.0;3.5];

gl=lb(6);

G=[2*gl -gl -gl 0 0;
   -gl 2*gl -gl 0 0
   -gl -gl 4*gl -gl -gl
   0  0 -gl 2*gl -gl
   0 0 -gl -gl 2*gl];

lambda=eig(G)

sigma2=lambda(2)*gl/2;
% sigma3=lambda(3)*0.51/2;
% sigma4=lambda(4)*0.51/2;
sigmaN=lambda(5)*gl/2;

gu=ub(6);

G=[2*gu -gu -gu 0 0;
   -gu 2*gu -gu 0 0
   -gu -gu 4*gu -gu -gu
   0  0 -gu 2*gu -gu
   0 0 -gu -gu 2*gu];

lambda2=eig(G);

sigma2u=lambda2(2)*gu/2;
% sigma3u=lambda2(3)*0.51/2;
% sigma4u=lambda2(4)*0.51/2;
sigmaNu=lambda2(5)*gu/2;




