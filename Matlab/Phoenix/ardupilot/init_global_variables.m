%%  init_global_variables
%
%   Script that resets all global variables to zero.
%   Also handy to initialise the global workspace
%

clear all;

%load('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\global.mat')

%% #Defines


%% System Check Flags
armed = 1;                              %Flag to see if the Copter Armed

%% Throttle & Thrust Commands and Outputs
throttle_in = 0;                        %Last throttle input from set_throttle caller
throttle_avg_max = 0;                   %Last throttle input from set_throttle_avg_max
throttle_filter_output = 0;             %Throttle input filter, Low Pass Filter
throttle_filter_cutoff_freq = 0;        %Variable cut off frequency for the throttle filter

throttle_thrust_max = 1;
%throttle_thrust = 0;
%throttle_thrust_best_rpy = 0;

thrust_rpyt_out(1) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 1 in 0~1 range
thrust_rpyt_out(2) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 2 in 0~1 range
thrust_rpyt_out(3) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 3 in 0~1 range
thrust_rpyt_out(4) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 4 in 0~1 range

%% Roll Commands and Outputs
roll_in = 0;                            %Desired roll control from attitude controllers, -1 ~ +1
%roll_thrust = 0;                       %Roll thrust input value, +/- 1.0

roll_factor(1) = 0;                     %Motor 1 roll contribution                    
roll_factor(2) = 0;                     %Motor 2 roll contribution
roll_factor(3) = 0;                     %Motor 3 roll contribution
roll_factor(4) = 0;                     %Motor 4 roll contribution

%% Pitch Commands and Outputs
pitch_in = 0;                           %Desired pitch control from attitude controller, -1 ~ +1
%pitch_thrust = 0;

pitch_factor(1) = 0;                    %Motor 1 pitch contribution
pitch_factor(2) = 0;                    %Motor 2 pitch contribution
pitch_factor(3) = 0;                    %Motor 3 pitch contribution
pitch_factor(4) = 0;                    %Motor 4 pitch contribution

%% Yaw Commands and Outputs
yaw_in = 0;
%yaw_thrust = 0;

yaw_factor(1) = 0;                      %Motor 1 yaw contribution
yaw_factor(2) = 0;                      %Motor 2 yaw contribution
yaw_factor(3) = 0;                      %Motor 3 yaw contribution
yaw_factor(4) = 0;                      %Motor 4 yaw contribution

yaw_headroom = 200;                     %Yaw control is given at least this pwm range

%% PWM Limits
pwm_min = 0;
pwm_max = 0;

%% Sample and Timing Variables
loop_rate = 0;
dt = 0;

save('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\global.mat')