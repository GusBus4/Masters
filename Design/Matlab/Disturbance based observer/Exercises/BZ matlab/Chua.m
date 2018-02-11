%% BZ1prob3

function xdot = Chua(t,x)
x1=x(1); x2=x(2); x3=x(3);

alpha=10;
beta=19.53;
m1=-0.783;
m2=-0.3247;

phi=m1*x1+m2*(abs(x1+1)-abs(x1-1));

x1dot = alpha*(-x1+x2-phi);
x2dot = x1-x2+x3;
x3dot = -beta*x2;



xdot=[x1dot; x2dot; x3dot];
