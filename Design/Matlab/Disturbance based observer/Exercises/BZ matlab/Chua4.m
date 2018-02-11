%% BZ1PROB4

function statedot = Chua4(t,state);
x1=state(1); x2=state(2); x3=state(3); y1=state(4); y2=state(5); y3=state(6);

alpha=10;
beta=19.53;
m1=-0.783;
m2=-0.3247;
k=205;

phix1=m1*x1+m2*(abs(x1+1)-abs(x1-1));
phiy1=m1*y1+m2*(abs(y1+1)-abs(y1-1));

x1dot= alpha*(-x1+x2-phix1);
x2dot=x1-x2+x3;
x3dot=-beta*x2;

y1dot= alpha*(-y1+y2-phiy1)+k*(x1-y1);
y2dot=y1-y2+y3;
y3dot=-beta*y2;

statedot=[x1dot x2dot x3dot y1dot y2dot y3dot]';