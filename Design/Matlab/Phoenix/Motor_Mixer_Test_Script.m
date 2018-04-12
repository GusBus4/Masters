%       ccw       cw            
%N         3    1
%           \  /
%            \/
%            /\
%           /  \
%          2    4       
%       cw        ccw   E
%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inputs
Z       = 100;
psi     = 1;
theta   = 1;
phi     = 1;

thrust_min      = 10;                  %Minimum thrust value @ pwm_min
thrust_max      = 110;                 %Maximum thrust value @ pwm_max
pwm_min         = 1039;                %Minimum RCOUT value
pwm_max         = 2000;                %Maximum RCOUT Value 
spin_min        = 0.15;                %Minimum allowed spin, percentage
spin_max        = 0.95;                %Maximum allowed spin, percentage

armLength           = 0.41;            %Meters
alpha               = deg2rad(15);     %Rad
chordLength         = 0.040;           %Meters
liftDragRatio       = 0.1;

roll_arm    = armLength * sin(alpha);
pitch_arm   = armLength * cos(alpha);
yaw_arm     = chordLength/liftDragRatio;
%% 

roll_contribution   = [-roll_arm roll_arm roll_arm -roll_arm];
pitch_contribution  = [pitch_arm -pitch_arm pitch_arm -pitch_arm];
yaw_contribution    = [-yaw_arm -yaw_arm yaw_arm yaw_arm];

contribution_matrix = [1 1 1 1; roll_contribution; pitch_contribution; yaw_contribution];

thrust_matrix = inv(contribution_matrix)*[Z;psi;theta;phi]


T1 = thrust_matrix(1,1)
T2 = thrust_matrix(2,1)
T3 = thrust_matrix(3,1)
T4 = thrust_matrix(4,1)

moment_matrix = (contribution_matrix)*[T1;T2;T3;T4];

Z = moment_matrix(1,1)
L = moment_matrix(2,1)
M = moment_matrix(3,1)
N = moment_matrix(4,1)



