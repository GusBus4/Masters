clear all; close all; clc;
syms c1
k=3;
c2=1;
c1=0.5;
A21=[-2*c1-k^2 c1 c1; c1 -2*c1 c1; c1 c1 -2*c2];
A22=[-2*c2-2*k c2 c2; c2 -2*c2 c2; c2 c2 -2*c2];
A=[zeros(3,3) eye(3);
    A21 A22];

eig(A)
min(real(abs((eig(A)))))