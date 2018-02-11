%% BZ1PROB2c

function etadot = Rossler_eta(t,x)
% Parameters
a=0.2;
b=5.7;
c=0.2;

% System
eta_real = [x(1); x(2); log(x(3))];
A = [0 -1 0
     1  a 0
     1  0 0];

alpha = [-exp(eta_real(3))
          0
          c*exp(-eta_real(3))-b];
      
etadot(1:3,1) = A*eta_real+alpha;

% Observer gain
C = [0 0 1];
L = acker(A.',C.',[-1 -2 -3]).';
eta_hat = [x(4); x(5); log(x(6))];

etadot(4:6,1) = A*eta_hat+alpha+L*(eta_real(3)-eta_hat(3));

