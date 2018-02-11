%% BZ1prob1

function statedot=Lorenz(t,state)
x=state(1); y=state(2); z=state(3); x1=state(4); y1=state(5); z1=state(6);

sigma=10;
r=28;
b=8/3;

xdot=sigma*(y-x);
ydot=-x*z+r*x-y;
zdot=x*y-b*z;

xdot1=sigma*(y1-x1);
ydot1=-x*z1+r*x-y1;
zdot1=x*y1-b*z1;



statedot=[xdot ydot zdot xdot1 ydot1 zdot1]';

