%%  init_global_variables
%
%   Script that resets all global variables to zero.
%   Also handy to initialise the global workspace
%

clear all;

%% #Defines


%% System Check Flags
global armed
armed = 1;                              %Flag to see if the Copter Armed

%% Throttle & Thrust Commands and Outputs
global throttle_in 
throttle_in = 0;                        %Last throttle input from set_throttle caller

global throttle_avg_max throttle_filter_output throttle_filter_cutoff_freq
throttle_avg_max = 0;                   %Last throttle input from set_throttle_avg_max
throttle_filter_output = 0;             %Throttle input filter, Low Pass Filter
throttle_filter_cutoff_freq = 0;        %Variable cut off frequency for the throttle filter

global throttle_thrust_max throttle_thrust throttle_thrust_best_rpy
throttle_thrust_max = 1;
throttle_thrust = 0;
throttle_thrust_best_rpy = 0;

global thrust_rpyt_out
thrust_rpyt_out(1) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 1 in 0~1 range
thrust_rpyt_out(2) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 2 in 0~1 range
thrust_rpyt_out(3) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 3 in 0~1 range
thrust_rpyt_out(4) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 4 in 0~1 range

%% Roll Commands and Outputs
global roll_in
roll_in = 0;                            %Desired roll control from attitude controllers, -1 ~ +1
%roll_thrust = 0;                       %Roll thrust input value, +/- 1.0

global roll_factor
roll_factor(1) = 0;                     %Motor 1 roll contribution                    
roll_factor(2) = 0;                     %Motor 2 roll contribution
roll_factor(3) = 0;                     %Motor 3 roll contribution
roll_factor(4) = 0;                     %Motor 4 roll contribution

global roll_rate_P roll_rate_I roll_rate_D
roll_rate_P = 0;
roll_rate_I = 0;
roll_rate_D = 0;

global roll_attitude_P roll_attitude_I roll_attitude_D
roll_attitude_P = 0;
roll_attitude_I = 0;
roll_attitude_D = 0;

%% Pitch Commands and Outputs
pitch_in = 0;                           %Desired pitch control from attitude controller, -1 ~ +1
%pitch_thrust = 0;

pitch_factor(1) = 0;                    %Motor 1 pitch contribution
pitch_factor(2) = 0;                    %Motor 2 pitch contribution
pitch_factor(3) = 0;                    %Motor 3 pitch contribution
pitch_factor(4) = 0;                    %Motor 4 pitch contribution

pitch_rate_P = 0;
pitch_rate_I = 0;
pitch_rate_D = 0;

pitch_attitude_P = 0;
pitch_attitude_I = 0;
pitch_attitude_D = 0;

%% Yaw Commands and Outputs
global yaw_in
yaw_in = 0;
%yaw_thrust = 0;

global yaw_factor
yaw_factor(1) = 0;                      %Motor 1 yaw contribution
yaw_factor(2) = 0;                      %Motor 2 yaw contribution
yaw_factor(3) = 0;                      %Motor 3 yaw contribution
yaw_factor(4) = 0;                      %Motor 4 yaw contribution

global yaw_headroom
yaw_headroom = 200;                     %Yaw control is given at least this pwm range

global yaw_rate_P yaw_rate_I yaw_rate_D
yaw_rate_P = 0;
yaw_rate_I = 0;
yaw_rate_D = 0;

global yaw_attitude_P yaw_attitude_I yaw_attitude_D
yaw_attitude_P = 0;
yaw_attitude_I = 0;
yaw_attitude_D = 0;

%% PWM Limits
global pwm_min pwm_max
pwm_min = 0;
pwm_max = 0;

%% Sample and Timing Variables
global loop_rate dt
loop_rate = 100;                    %Hertz
dt = 0;                          %S
