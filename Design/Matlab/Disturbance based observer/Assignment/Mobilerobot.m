function statedot = Mobilerobot(t,state)
x1=state(1); y1=state(2); theta1=state(3); v1=state(4);



kd=3;
kp=3;


xr     = 10*cos(0.1*t);
xrdot  = -sin(0.1*t);
xrddot = -0.1*cos(0.1*t);
yr     = 10*sin(0.1*t);
yrdot  = cos(0.1*t);
yrddot = -0.1*sin(0.1*t);



x1dot = v1*cos(theta1);
y1dot = v1*sin(theta1);


eta11 = xrddot+kd*(xrdot-x1dot)+kp*(xr-x1);
eta12 = yrddot+kd*(yrdot-y1dot)+kp*(yr-y1);

v1dot = eta11*cos(theta1) + eta12*sin(theta1);
theta1dot = -eta11*sin(theta1)/v1 + eta12*cos(theta1)/v1;



statedot=[x1dot y1dot theta1dot v1dot]';