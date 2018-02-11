function statedot = Lorenz(t,state)
x=state(1); y=state(2); z=state(3); x1=state(4); y1=state(5); z1=state(6);

sigma=10;
r=28;
b=8/3;

xdot = sigma*(y-x);
ydot = -x*z+r*x-y;
zdot = x*y-b*z;

x1dot = sigma*(y1-x1);
y1dot = -x*z1+r*x-y1;
z1dot = x*y1-b*z1;

statedot=[xdot ydot zdot x1dot y1dot z1dot]';