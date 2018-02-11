%% BZ2PROB1

function statedot = Pendulum(t,state)
x1=state(1); x2=state(2); z1=state(3); z2=state(4);

yr=sin(t);
yrdot=cos(t);
yrddot=-sin(t);

alpha=10;
beta=3;

kd=2;
kp=2;

u = x1+x2+yrddot-kd*(x2-yrdot)-kp*(x1-yr)+alpha*(x1-z1)+beta*(x2-z2);
v=z1+z2+yrddot-kd*(z2-yrdot)-kp*(z1-yr)+alpha*(x1-z1)+beta*(x2-z2);
e=0.5*sin(0.5*t);


x1dot = x2;
x2dot = -x1-x2+u;


z1dot = z2;
z2dot = -z1-z2+v+e;


statedot=[x1dot x2dot z1dot z2dot]';