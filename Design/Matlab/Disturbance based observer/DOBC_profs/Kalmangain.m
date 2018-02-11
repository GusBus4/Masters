%% KalmanGainDerivation
% Constants
Ix = 0.025028;
Iy = 0.169;
Iz = 0.17;

% Dynamics
A = [0 0 0;
     0 0 0;
     0 0 0];
B = [1/Ix 0     0;
     0    1/Iy  0;
     0    0     1/Iz];
C = [1 0 0;
     0 1 0;
     0 0 1];
D = [0 0 0;
     0 0 0;
     0 0 0]; 
H = [1    0 0;
     0    1 0;
     0    0 1];
SYS = ss(A,[B B],C,[D H])

QN = diag([0.0000000001 0.01 0.01])
RN = diag([1 1 1]);

[KEST,L,P] =  kalman(SYS,QN,RN);
KEST
L
