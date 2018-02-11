clc;
close all;

alength = 6;
ax = 0:alength;
ay = [1 1 1 1 1 1 1];
az = [1 2 1 1 1 1 1];

blength = 6;
bx = 1:blength
by = 1:blength;
bz = 1:blength;

clength = 10;
cx = zeros(clength+1);
cy = zeros(clength+1);
cz = 0:clength;


figure;

plot3(ax,ay,az)
plot3(bx,by,bz)
% plot3(ax,ay,az,bx,by,bz,cx,cy,cz)
xlabel('X');
ylabel('Y');
zlabel('Z');
