%%BZ2PROB2

function dq =sim_bz22(t,q)

q1 = q(1);
q2 = q(2);
q1d = q(3);
q2d = q(4);


m1 = 5;
m2 = 6;
I1 = 3;
I2 = 3;
l1 = 4;
l2 = 4;
g = 9.81;

r1 = sin(t)+5*cos(0.2*t);
r1d = cos(t)-sin(0.2*t);
r1dd = -sin(t)-0.2*cos(0.2*t);

r2 = sin(0.5*t);
r2d = 0.5*cos(0.5*t);
r2dd = -0.25*sin(0.5*t);

M11 = 0.25*m1*l1^2+m2*(l1^2+0.25*l2^2+l1*l2*cos(q2))+I1+I2;
M21 = m2*(0.25*l2^2+0.5*l1*l2*cos(q2))+I2;
M12 = M21;
M22 = 0.25*m2*l2^2+I2;

C = -0.5*m2*l1*l2*sin(q2);

qd = [q1d; q2d];

Mm = [M11 M12; M21 M22];
Cm = [C*q2d C*(q1d+q2d); -C*q1d 0];
gm = [(0.5*m1+m2)*l1*g*cos(q1)+0.5*m2*l2*g*cos(q1+q2); 0.5*m2*l2*g*cos(q1+q2)];
L = [r1dd-(q1d-r1d)-(q1-r1); r2dd-(q2d-r2d)-(q2-r2)];
Tm = Mm*L+Cm*qd+gm;





qdd = inv(Mm)*(Tm-Cm*qd-gm);

dq = [q1d q2d qdd(1,:)' qdd(2,:)']';

