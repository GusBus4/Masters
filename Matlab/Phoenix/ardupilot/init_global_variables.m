%%  init_global_variables
%
%   Script that resets all global variables to zero.
%   Also handy to initialise the global workspace
%
%% #Defines

global AC_ATTITUDE_CONTROL_MAX
AC_ATTITUDE_CONTROL_MAX = 0.5;

%% System Check Flags

%% Throttle & Thrust Commands and Outputs
global throttle_in 
throttle_in = 0;                        %Last throttle input from set_throttle caller

global throttle_avg_max throttle_filter_output throttle_filter_cutoff_freq
throttle_avg_max = 0;                   %Last throttle input from set_throttle_avg_max
throttle_filter_output = 0;             %Throttle input filter, Low Pass Filter
throttle_filter_cutoff_freq = 0.5;      %Variable cut off frequency for the throttle filter

global throttle_thrust_max throttle_thrust throttle_thrust_best_rpy
throttle_thrust_max = 1;
throttle_thrust = 0;
throttle_thrust_best_rpy = 0;

global thrust_rpyt_out
thrust_rpyt_out(1) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 1 in 0~1 range
thrust_rpyt_out(2) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 2 in 0~1 range
thrust_rpyt_out(3) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 3 in 0~1 range
thrust_rpyt_out(4) = 0;                 %Combined roll, pitch, yaw and throttle outputs to motor 4 in 0~1 range

global throttle_rpy_mix throttle_rpy_mix_desired
throttle_rpy_mix = 0;
throttle_rpy_mix_desired = 0;

%% Roll Commands and Outputs
global roll_factor
roll_factor(1) = -sin(deg2rad(15));                     %Motor 1 roll contribution                    
roll_factor(2) = sin(deg2rad(15));                     %Motor 2 roll contribution
roll_factor(3) = sin(deg2rad(15));                     %Motor 3 roll contribution
roll_factor(4) = -sin(deg2rad(15));                     %Motor 4 roll contribution

global roll_rate_error_rads roll_rate_derivative roll_rate_last_input roll_rate_integrator roll_rate_proportional
roll_rate_error_rads = 0;
roll_rate_derivative = 0;
roll_rate_last_input = 0;
roll_rate_integrator = 0;
roll_rate_proportional = 0;

global roll_rate_imax roll_rate_kP roll_rate_kI roll_rate_kD roll_rate_filt_hz
roll_rate_kP = 0.2;
roll_rate_kI = 0.1;
roll_rate_kD = 5;
roll_rate_imax = 200;
roll_rate_filt_hz = 1/(2*pi);


%% Pitch Commands and Outputs
global pitch_factor
pitch_factor(1) = cos(deg2rad(15));                    %Motor 1 pitch contribution
pitch_factor(2) = -cos(deg2rad(15));                    %Motor 2 pitch contribution
pitch_factor(3) = cos(deg2rad(15));                    %Motor 3 pitch contribution
pitch_factor(4) = -cos(deg2rad(15));                    %Motor 4 pitch contribution

global pitch_rate_error_rads pitch_rate_derivative pitch_rate_last_input pitch_rate_integrator pitch_rate_proportional
pitch_rate_error_rads = 0;
pitch_rate_derivative = 0;
pitch_rate_last_input = 0;
pitch_rate_integrator = 0;
pitch_rate_proportional = 0;

global pitch_rate_imax pitch_rate_kP pitch_rate_kI pitch_rate_kD pitch_rate_filt_hz
pitch_rate_kP = 0.2;
pitch_rate_kI = 0.1;
pitch_rate_kD = 5;
pitch_rate_imax = 200;
pitch_rate_filt_hz = 1/(2*pi);

%% Yaw Commands and Outputs
global yaw_factor
yaw_factor(1) = 0.1;                      %Motor 1 yaw contribution
yaw_factor(2) = 0.1;                      %Motor 2 yaw contribution
yaw_factor(3) = -0.1;                     %Motor 3 yaw contribution
yaw_factor(4) = -0.1;                     %Motor 4 yaw contribution

global yaw_headroom yaw_allowed
yaw_headroom = 200;                     %Yaw control is given at least this pwm range
yaw_allowed = 1;

global yaw_rate_error_rads yaw_rate_derivative yaw_rate_last_input yaw_rate_integrator yaw_rate_proportional
yaw_rate_error_rads = 0;
yaw_rate_derivative = 0;
yaw_rate_last_input = 0;
yaw_rate_integrator = 0;
yaw_rate_proportional = 0;

global yaw_rate_imax yaw_rate_kP yaw_rate_kI yaw_rate_kD yaw_rate_filt_hz
yaw_rate_kP = 0.2;
yaw_rate_kI = 0.1;
yaw_rate_kD = 5;
yaw_rate_imax = 200;
yaw_rate_filt_hz = 1/(2*pi);

%% Limits
global limit_throttle_upper limit_roll_pitch limit_yaw
limit_throttle_upper = 0;
limit_roll_pitch = 0;
limit_yaw = 0;

%% PWM Limits
global pwm_min pwm_max spin_min spin_max
pwm_min = 1039;
pwm_max = 2000;
spin_min = 0.15;
spin_max = 0.95;

%% Sample and Timing Variables
global loop_rate dt
loop_rate = 100;                    %Hertz
dt = 0.01;                          %S
