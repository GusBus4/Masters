%% BZ3PROB3

function xdot = ChuaBZ3(t,x)

N=5;
alpha=10;
beta=19.53;
m1=10;
m2=-0.3247;
m3=-10.783/2;
gamma=1;

for n=1:3:3*N-2;
    u=0;
    for j=1:3:3*N-2
        u=u+gamma*(x(j)-x(n));
    end
    phi= m1*x(n) + m2*(abs(x(n)+1)-abs(x(n)-1))+m3*(abs(x(n)+10)-abs(x(n)-10));
    xdot(n,1)   = alpha*(-x(n)+x(n+1)-phi)+u;
    xdot(n+1,1) = x(n)-x(n+1)+x(n+2);
    xdot(n+2,1) = -beta*x(n+1);
end

    





