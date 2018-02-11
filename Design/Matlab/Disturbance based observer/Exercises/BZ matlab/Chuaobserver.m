%% BZ1prob3

function etadot = Chuaobserver(t,x)
% x1=x(1); x2=x(2); x3=x(3);
eta_real = [x(1); x(2); x(3)];

alpha=10;
beta=19.53;
m1=-0.783;
m2=-0.3247;

phi=m1*eta_real(1)+m2*(abs(eta_real(1)+1)-abs(eta_real(1)-1));

% x1dot = alpha*(-x1+x2-phi);
% x2dot = x1-x2+x3;
% x3dot = -beta*x2;

A = [-alpha alpha 0
     1  -1 1
     0  -beta 0];

gamma = [phi
         0
         0];

etadot(1:3,1) = A*eta_real+gamma;

% Observer gain
C = [0 0 1];
L = acker(A.',C.',[-1 -2 -3]).';
eta_hat = [x(4); x(5); log(x(6))];

etadot(4:6,1) = A*eta_hat+gamma+L*(eta_real(3)-eta_hat(3));


% 
% xdot=[x1dot; x2dot; x3dot];
