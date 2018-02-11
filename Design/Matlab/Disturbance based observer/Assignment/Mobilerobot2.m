function statedot = Mobilerobot2(t,state)
x1=state(1); y1=state(2); theta1=state(3); v1=state(4); x2=state(5); y2=state(6); theta2=state(7); v2=state(8); x3=state(9); y3=state(10); theta3=state(11); v3=state(12);



kd=3;
kp=3;

dphi=0.1;
R=10;
kD=1;
kP=2;


xr     = 10*cos(0.1*t);
xrdot  = -sin(0.1*t);
xrddot = -0.1*cos(0.1*t);
yr     = 10*sin(0.1*t);
yrdot  = cos(0.1*t);
yrddot = -0.1*sin(0.1*t);



x1dot = v1*cos(theta1);
y1dot = v1*sin(theta1);
x2dot = v2*cos(theta2);
y2dot = v2*sin(theta2);
x3dot = v3*cos(theta3);
y3dot = v3*sin(theta3);

xr2=x1*cos(dphi)+y1*sin(dphi);
xr3=x2*cos(dphi)+y2*sin(dphi);
yr2=-x1*sin(dphi)+y1*cos(dphi);
yr3=-x2*sin(dphi)+y2*cos(dphi);
xr2dot=-dphi*x1*sin(dphi)+y1*dphi*cos(dphi);
xr3dot=-dphi*x2*sin(dphi)+y2*dphi*cos(dphi);
yr2dot=-x1*dphi*cos(dphi)-y1*dphi*sin(dphi);
yr3dot=-x2*dphi*cos(dphi)-y2*dphi*sin(dphi);
xr2ddot=-dphi^2*x1*cos(dphi)-y1*dphi^2*sin(dphi);
xr3ddot=-dphi^2*x2*cos(dphi)-y2*dphi^2*sin(dphi);
yr2ddot=x1*dphi^2*sin(dphi)-y1*dphi^2*cos(dphi);
yr3ddot=x2*dphi^2*sin(dphi)-y2*dphi^2*cos(dphi);

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