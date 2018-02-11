% DOBC
function eta_dot = DOBC(t,x)

 eta_real = [x(1); x(2); x(3)];                                             %state vector for own statespace
 m=3.352;                                                                   % mass
 g=9.81;                                                                    %gravitational acceleration
 
 xs = 6*0.014;                                                              % distance from wall
 A_d = [1.1232*exp(-28.74*xs) 1e-9                   1e-9;                 % State matrix obtained with Taylor expansion
       1e-9                   -1.838*exp(-28.54*xs)  1e-9;
       1e-9                   1e-9                   1e-9];

Ixx = 0.0250;
Iyy = 0.1693;
Izz = 0.1702;
% C_d = [1 0 0;
%        0 1 0
%        0 0 1];
 
 C_d = [1 1 1];                                                             % State matrix: every state is observable??
 
 Controllability = [C_d;C_d*A_d;C_d*A_d*A_d]                                %Check if observable

 expfx = -0.03908*exp(-28.74*xs);                                           %Calculate moment on propeller at distance from wall.
 expfy = 0.0644*exp(-28.54*xs);                                             %Calculate moment on propeller at distance from wall.
%% Matrices for own dynamics
x = [x(1); x(2); x(3)];                                              % States

Ax = [0 0 0;                                                                % state matrix of attitude dynamics at hovering
      0 0 0;
      0 0 0];
 

g1 = [1/Ixx 0 0;                                                            % State matrix of dynamics
      0 1/Iyy 0;
      0 0 1/Izz];

g2 = [1/Ixx 0 0;                                                            % State matrix of dynamics
      0 1/Iyy 0;
      0 0 1/Izz];

u  = [0;                                                                    %Inputs in plant
      0;
      0];
 
d  = [expfx;                                                                %disturbance moments on system
      expfy;
      0];

x_dot(1:3,:) = (Ax * x + g1 * u + g2 * d);                         % attitude dynamics

 dhat = [expfx+0.00001;                                                             % estimated disturbance
         expfy+0.00001;
         0    ];
 L = acker(A_d.',C_d.',[-0.1 -1 -1]).';                                   % place poles in negative Complex plane
%      L                                                                       % should converge error to zero if (A-L*g2*C) is in negative comp plane
%  poles = eig(A_d-L*C_d)                                                                          
 eta_hat = [x(4); x(5); x(6)];                                              % new states
 eta_dot(4:6,:) = A_d*eta_hat + L.*(x_dot(1:3,:) - Ax * x - g1 * u - g2 * dhat); %basic disturbance observer


 %% link for the paper where this is based upon.
%  ieeexplore.ieee.org/document/6842357/

% derivation of the DOBC:
% ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1372532

 
 
 
 
 
 
 
 
 
 %% 2nd option nonlinear Not fully worked out
% z = [x(4); x(5); x(6)];
% 
% A = [1 0 0;
%      0 1 -2;
%      0 2 1];
% C = [1 1 1];
% 
% L = acker(A.',C.',[-1 -2 -3]).';
% 
% px = [x(1)*L(1);
%      x(2)*L(2);
%      x(3)*L(3)];
% 
% zdot = -g1*L * z -  L * (px * g1 + fx + g1 * u);
% 
% eta_dot(4:6,:) = zdot;



