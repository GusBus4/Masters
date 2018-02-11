function statedot = Manipulator(t,state)
q1=state(1); q2=state(2); q3=state(3); q4=state(4)

r1=sin(t);
r1dot=cos(t);
r2=sin(t);
r2dot=cos(t);


M11=[1/4*m1*l1^2+m2*(l1^2+0.25*l2^2+l1*l2*cos(q2)) + I1+I2;
M12 = [m2*(0.25*l2^2+0.5*l1*l2*cos(q2)+ I1;
M21 = M12;
M22 = 0.25*m2*l2^2+I2;
Mm=[M11 M12;
   M21 M22];

C = -0.5*m2*l1*l2*sin(q2);
gi= [(0.5*m1+m2)*l1*g*cos(q1)+0.5*m2*l2*g*cos(q(1)+q(2)); 0.5*m2*l2*g*cos(q(1)+q(2))];






q1d=q(2);

q2d=q(3);
q2dd = inv(Mi)*(Ci*[q1d; q2d]+gi-Ti);

r1=sin(t)+5*cos(0.2*t);
r1d=cos(t)-sin(0.2*t);
r1dd=-sin(t)-0.2*sin(0.2*t);

r2=sin(0.5*t);
r2d=0.5*cos(0.5*t);
r2dd = -0.25*sin(0.5*t);

dzeta = [r1dd; r2dd] - [q1d-r1d; q2d-r2d] - [q1-r1; q2-r2];
Tm= Mm*dzeta+C*[q1d; q2d] + gi;



kd=1;
kp=2;

u = x1+x2+yrddot-kd*(x2-yrdot)-kp*(x1-yr)+alpha*(x1-z1)+beta*(x2-z2);
v=z1+z2+yrddot-kd*(z2-yrdot)-kp*(z1-yr)+alpha*(x1-z1)+beta*(x2-z2);
e=0.5*sin(0.5*t);


x1dot = x2;
x2dot = -x1-x2+u;


z1dot = z2;
z2dot = -z1-z2+v+e;


statedot=[x1dot x2dot z1dot z2dot]';