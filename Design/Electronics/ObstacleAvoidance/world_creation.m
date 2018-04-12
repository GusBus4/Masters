%% Create a world
%
%   First generate the roof
%   Then the floor
%   Finally any walls or obstancles

%   Resolution  : 0.1
%   Roof        : 2
%   Floor       : 0
%   Size        : 15x3
%   Units       : m

resolution          = 1;              
roof_height         = 5;
floor_height        = 0;
x_size              = 4;
y_size              = 4;
z_size              = roof_height - floor_height;

%% Create the empty world
world = zeros(x_size/resolution, y_size/resolution, z_size/resolution);

%% Create the roof
xcount = 1;
ycount = 1;
zcount = 1;

for i=1:x_size/resolution
    for j=1:y_size/resolution
        world(xcount, ycount, z_size/resolution) = 1;
        ycount = ycount + 1;
    end
    xcount = xcount + 1;
    ycount = 1;
end

%% Create the floor
xcount = 1;
ycount = 1;
zcount = 1;

for i=1:x_size/resolution
    for j=1:y_size/resolution
        world(xcount, ycount, 1) = 1;
        ycount = ycount + 1;
    end
    xcount = xcount + 1;
    ycount = 1;
end

%% Create the west wall
xcount = 1;
ycount = 1;
zcount = 1;

for i=1:x_size/resolution
    for k=1:z_size/resolution
        world(xcount, 1, zcount) = 1;
        zcount = zcount + 1;
    end
    xcount = xcount + 1;
    zcount = 1;
end

%% Create the east wall
xcount = 1;
ycount = 1;
zcount = 1;

for i=1:x_size/resolution
    for k=1:z_size/resolution
        world(xcount, y_size/resolution, zcount) = 1;
        zcount = zcount + 1;
    end
    xcount = xcount + 1;
    zcount = 1;
end

%% Create the south wall
xcount = 1;
ycount = 1;
zcount = 1;

for j=1:y_size/resolution
    for k=1:z_size/resolution
        world(1, ycount, zcount) = 1;
        zcount = zcount + 1;
    end
    ycount = ycount + 1;
    zcount = 1;
end

%% Create the north wall
xcount = 1;
ycount = 1;
zcount = 1;

for j=1:y_size/resolution
    for k=1:z_size/resolution
        world(x_size/resolution, ycount, zcount) = 1;
        zcount = zcount + 1;
    end
    ycount = ycount + 1;
    zcount = 1;
end