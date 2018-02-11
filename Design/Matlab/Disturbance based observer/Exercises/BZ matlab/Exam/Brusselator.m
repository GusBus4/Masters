%% Exam

function etadot = Brusselator(t,x)
% Parameters
a=1;
b=3;


% System
eta_real = [1/x(1); x(1)+x(2)];
A = [0 -1
     0  0];

alpha = [-a*eta_real(1)^2+(b+1)*eta_real(1)+1/eta_real(1);
         a-1/eta_real(1)];
      
etadot(1:2,1) = A*eta_real+alpha;

% Observer gain
C = [1 0];
L = acker(A.',C.',[-0.5 -0.9]).';
eta_hat = [1/x(3); x(3)+x(4)];

etadot(3:4,1) = A*eta_hat+alpha+L*(eta_real(1)-eta_hat(1));

