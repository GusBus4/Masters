%% BZ1prob2

function xdot = Rossler(t,x)
x1=x(1); x2=x(2); x3=x(3);
% eta1=x(1); eta2=x(2); eta3=x(3);
a=0.2;
b=5.7;
c=0.2;


x1dot = -x2-x3;
x2dot = x1+a*x2;
x3dot = c+x3*(x1-b);

% eta1dot=-eta2-exp(eta3);
% eta2dot=eta1+a*eta2;
% eta3dot=c*exp(-eta3)+eta1-b;

xdot=[x1dot; x2dot; x3dot];
% xdot=[eta1dot; eta2dot; eta3dot];
