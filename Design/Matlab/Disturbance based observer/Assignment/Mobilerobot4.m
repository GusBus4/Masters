function statedot = Mobilerobot4(t,state)
x1=state(1); y1=state(2); theta1=state(3); v1=state(4); x2=state(5); y2=state(6); theta2=state(7); v2=state(8); x3=state(9); y3=state(10); theta3=state(11); v3=state(12);



kd=5;
kp=3;

d=1;
kD=2;
kP=2;


xr     = 3*t;
xrdot  = 3;
xrddot = 0;
yr     = 0;
yrdot  = 0;
yrddot = 0;



x1dot = v1*cos(theta1);
y1dot = v1*sin(theta1);
x2dot = v2*cos(theta2);
y2dot = v2*sin(theta2);
x3dot = v3*cos(theta3);
y3dot = v3*sin(theta3);

xr2=x1+d;
xr3=x2+d;
yr2=0;
yr3=0;
xr2dot=1;
xr3dot=1;
yr2dot=0;
yr3dot=0;
xr2ddot=0;
xr3ddot=0;
yr2ddot=0;
yr3ddot=0;

eta11 = xrddot+kd*(xrdot-x1dot)+kp*(xr-x1);
eta12 = yrddot+kd*(yrdot-y1dot)+kp*(yr-y1);
eta21 = xr2ddot+kD*(xr2dot-x2dot)+kP*(xr2-x2);
eta22 = yr2ddot+kD*(yr2dot-y2dot)+kP*(yr2-y2);
eta31 = xr3ddot+kD*(xr3dot-x3dot)+kP*(xr3-x3);
eta32 = yr3ddot+kD*(yr3dot-y3dot)+kP*(yr3-y3);



v1dot = eta11*cos(theta1) + eta12*sin(theta1);
v2dot = eta21*cos(theta2) + eta22*sin(theta2);
v3dot = eta31*cos(theta3) + eta32*sin(theta3);
theta1dot = -eta11*sin(theta1)/v1 + eta12*cos(theta1)/v1;
theta2dot = -eta21*sin(theta2)/v2 + eta22*cos(theta2)/v2;
theta3dot = -eta31*sin(theta3)/v3 + eta32*cos(theta3)/v3;

statedot=[x1dot y1dot theta1dot v1dot x2dot y2dot theta2dot v2dot x3dot y3dot theta3dot v3dot]';