%% BZ2PROB3

function xdot = Manipulator(t,x)
x1=x(1); x2=x(2); x3=x(3);

r     = 10*cos(0.1*t);
rdot  = -sin(0.1*t);
rddot = -0.1*cos(0.1*t);

xr1=r-k*(x1-x2);
xr2=r-k*(x2-x1);
s1=x1-xr1;
s2=x2-xr2;
