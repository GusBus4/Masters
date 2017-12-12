%%  init_global_variables
%
%   Script that resets all global variables to zero.
%   Also handy to initialise the global workspace
%
%% #Defines
true = 1;
false = 0;
% variableType = 'M';
variableType = 'S';

if variableType == 'M'
    global AC_ATTITUDE_CONTROL_MAX ROLL_PITCH_INPUT_MAX AC_ATTITUDE_THRUST_ERROR_ANGLE AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS
    AC_ATTITUDE_CONTROL_MAX     = 0.5;
    ROLL_PITCH_INPUT_MAX        = 3000;     %Max Roll/Pitch Input CentiDegrees
    AC_ATTITUDE_THRUST_ERROR_ANGLE = 1000;
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS = 0.5;

    %% Parameters
    global angle_max acro_yaw_p 
    angle_max                   = 3000;     %Max Lean Angles, CentiDegrees
    acro_yaw_p                  = 45;

    %% System Check Flags
    global rate_bf_ff_enabled use_ff_and_input_shaping
    rate_bf_ff_enabled          = false;
    use_ff_and_input_shaping    = false;

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
    roll_rate_kP = 0.15;
    roll_rate_kI = 0.1;
    roll_rate_kD = 0.004;
    roll_rate_imax = 200;
    roll_rate_filt_hz = 1/(2*pi);

    global roll_attitude_kP
    roll_attitude_kP = 4.5;

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
    pitch_rate_kP = 0.15;
    pitch_rate_kI = 0.1;
    pitch_rate_kD = 0.004;
    pitch_rate_imax = 200;
    pitch_rate_filt_hz = 1/(2*pi);

    global pitch_attitude_kP
    pitch_attitude_kP = 4.5;

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
    yaw_rate_kI = 0.02;
    yaw_rate_kD = 0.00;
    yaw_rate_imax = 100;
    yaw_rate_filt_hz = 1/(2*pi);

    global yaw_attitude_kP
    yaw_attitude_kP = 4.5;

    %% Vector and Correction Angle Representations
    global attitude_target_euler_angle_x attitude_target_euler_angle_y attitude_target_euler_angle_z attitude_target_euler_rate attitude_target_quat attitude_target_ang_vel rate_target_ang_vel thrust_error_angle attitude_vehicle_quat body_dcm_matrix
    attitude_target_euler_angle_x   = 0;                                  % This represents a 321-intrinsic rotation from NED frame to the target (setpoint) attitude used in the attitude controller, in radians
    attitude_target_euler_angle_y   = 0;
    attitude_target_euler_angle_z   = 0;
    attitude_target_euler_rate      = [0 0 0];                                  % This represents the angular velocity of the target (setpoint) attitude used in the attitude controller as 321-intrinsic euler angle derivatives, in radians per second.
    attitude_target_quat            = [1 0 0 0];                                % This represents a quaternion rotation from NED frame to the target (setpoint) attitude used in the attitude controller.
    attitude_target_ang_vel         = [0 0 0];                                  % This represents the angular velocity of the target (setpoint) attitude used in the attitude controller as an angular velocity vector, in radians per second in the target attitude frame.
    rate_target_ang_vel             = [0 0 0];
    thrust_error_angle              = 0;
    attitude_vehicle_quat           = [1 0 0 0];
    body_dcm_matrix                 = [ 0 0 0; 0 0 0; 0 0 0];

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

elseif variableType == 'S'
    thrust_rpyt_out = Simulink.Signal;
    thrust_rpyt_out.DataType = 'double';
    thrust_rpyt_out.Dimensions = 4;
    thrust_rpyt_out.Complexity = 'real';
    thrust_rpyt_out.SamplingMode = 'Sample based';
    thrust_rpyt_out.InitialValue = '[0 0 0 0]';

    AC_ATTITUDE_CONTROL_MAX = Simulink.Signal;
    AC_ATTITUDE_CONTROL_MAX.DataType = 'double';
    AC_ATTITUDE_CONTROL_MAX.Dimensions = 1;
    AC_ATTITUDE_CONTROL_MAX.Complexity = 'real';
    AC_ATTITUDE_CONTROL_MAX.SamplingMode = 'Sample based';
    AC_ATTITUDE_CONTROL_MAX.InitialValue = '0.5';

    dt = Simulink.Signal;
    dt.DataType = 'double';
    dt.Dimensions = 1;
    dt.Complexity = 'real';
    dt.SamplingMode = 'Sample based';
    dt.InitialValue = '0.01';

    loop_rate = Simulink.Signal;
    loop_rate.DataType = 'double';
    loop_rate.Dimensions = 1;
    loop_rate.Complexity = 'real';
    loop_rate.SamplingMode = 'Sample based';
    loop_rate.InitialValue = '100';

    pitch_factor = Simulink.Signal;
    pitch_factor.DataType = 'double';
    pitch_factor.Dimensions = 4;
    pitch_factor.Complexity = 'real';
    pitch_factor.SamplingMode = 'Sample based';
    pitch_factor.InitialValue = '[cos(deg2rad(15)) -cos(deg2rad(15)) cos(deg2rad(15)) -cos(deg2rad(15))]';

    pitch_rate_derivative = Simulink.Signal;
    pitch_rate_derivative.DataType = 'double';
    pitch_rate_derivative.Dimensions = 1;
    pitch_rate_derivative.Complexity = 'real';
    pitch_rate_derivative.SamplingMode = 'Sample based';
    pitch_rate_derivative.InitialValue = '0';

    pitch_rate_error_rads = Simulink.Signal;
    pitch_rate_error_rads.DataType = 'double';
    pitch_rate_error_rads.Dimensions = 1;
    pitch_rate_error_rads.Complexity = 'real';
    pitch_rate_error_rads.SamplingMode = 'Sample based';
    pitch_rate_error_rads.InitialValue = '0';

    pwm_max = Simulink.Signal;
    pwm_max.DataType = 'double';
    pwm_max.Dimensions = 1;
    pwm_max.Complexity = 'real';
    pwm_max.SamplingMode = 'Sample based';
    pwm_max.InitialValue = '2000';

    pwm_min = Simulink.Signal;
    pwm_min.DataType = 'double';
    pwm_min.Dimensions = 1;
    pwm_min.Complexity = 'real';
    pwm_min.SamplingMode = 'Sample based';
    pwm_min.InitialValue = '1039';

    roll_factor = Simulink.Signal;
    roll_factor.DataType = 'double';
    roll_factor.Dimensions = 4;
    roll_factor.Complexity = 'real';
    roll_factor.SamplingMode = 'Sample based';
    roll_factor.InitialValue = '[-sin(deg2rad(15)) sin(deg2rad(15)) sin(deg2rad(15)) -sin(deg2rad(15))]';

    roll_rate_derivative = Simulink.Signal;
    roll_rate_derivative.DataType = 'double';
    roll_rate_derivative.Dimensions = 1;
    roll_rate_derivative.Complexity = 'real';
    roll_rate_derivative.SamplingMode = 'Sample based';
    roll_rate_derivative.InitialValue = '0';

    roll_rate_error_rads = Simulink.Signal;
    roll_rate_error_rads.DataType = 'double';
    roll_rate_error_rads.Dimensions = 1;
    roll_rate_error_rads.Complexity = 'real';
    roll_rate_error_rads.SamplingMode = 'Sample based';
    roll_rate_error_rads.InitialValue = '0';

    spin_min = Simulink.Signal;
    spin_min.DataType = 'double';
    spin_min.Dimensions = 1;
    spin_min.Complexity = 'real';
    spin_min.SamplingMode = 'Sample based';
    spin_min.InitialValue = '0.15';

    spin_max = Simulink.Signal;
    spin_max.DataType = 'double';
    spin_max.Dimensions = 1;
    spin_max.Complexity = 'real';
    spin_max.SamplingMode = 'Sample based';
    spin_max.InitialValue = '0.95';

    throttle_avg_max =  Simulink.Signal;
    throttle_avg_max.DataType = 'double';
    throttle_avg_max.Dimensions = 1;
    throttle_avg_max.Complexity = 'real';
    throttle_avg_max.SamplingMode = 'Sample based';
    throttle_avg_max.InitialValue = '0';

    throttle_filter_cutoff_freq =  Simulink.Signal;
    throttle_filter_cutoff_freq.DataType = 'double';
    throttle_filter_cutoff_freq.Dimensions = 1;
    throttle_filter_cutoff_freq.Complexity = 'real';
    throttle_filter_cutoff_freq.SamplingMode = 'Sample based';
    throttle_filter_cutoff_freq.InitialValue = '0.5';

    throttle_filter_output =  Simulink.Signal;
    throttle_filter_output.DataType = 'double';
    throttle_filter_output.Dimensions = 1;
    throttle_filter_output.Complexity = 'real';
    throttle_filter_output.SamplingMode = 'Sample based';
    throttle_filter_output.InitialValue = '0';

    throttle_in =  Simulink.Signal;
    throttle_in.DataType = 'double';
    throttle_in.Dimensions = 1;
    throttle_in.Complexity = 'real';
    throttle_in.SamplingMode = 'Sample based';
    throttle_in.InitialValue = '0';

    throttle_rpy_mix =  Simulink.Signal;
    throttle_rpy_mix.DataType = 'double';
    throttle_rpy_mix.Dimensions = 1;
    throttle_rpy_mix.Complexity = 'real';
    throttle_rpy_mix.SamplingMode = 'Sample based';
    throttle_rpy_mix.InitialValue = '0';

    throttle_rpy_mix_desired =  Simulink.Signal;
    throttle_rpy_mix_desired.DataType = 'double';
    throttle_rpy_mix_desired.Dimensions = 1;
    throttle_rpy_mix_desired.Complexity = 'real';
    throttle_rpy_mix_desired.SamplingMode = 'Sample based';
    throttle_rpy_mix_desired.InitialValue = '0';

    throttle_thrust =  Simulink.Signal;
    throttle_thrust.DataType = 'double';
    throttle_thrust.Dimensions = 1;
    throttle_thrust.Complexity = 'real';
    throttle_thrust.SamplingMode = 'Sample based';
    throttle_thrust.InitialValue = '0';

    throttle_thrust_best_rpy =  Simulink.Signal;
    throttle_thrust_best_rpy.DataType = 'double';
    throttle_thrust_best_rpy.Dimensions = 1;
    throttle_thrust_best_rpy.Complexity = 'real';
    throttle_thrust_best_rpy.SamplingMode = 'Sample based';
    throttle_thrust_best_rpy.InitialValue = '0';

    throttle_thrust_max =  Simulink.Signal;
    throttle_thrust_max.DataType = 'double';
    throttle_thrust_max.Dimensions = 1;
    throttle_thrust_max.Complexity = 'real';
    throttle_thrust_max.SamplingMode = 'Sample based';
    throttle_thrust_max.InitialValue = '1';

    yaw_allowed =  Simulink.Signal;
    yaw_allowed.DataType = 'double';
    yaw_allowed.Dimensions = 1;
    yaw_allowed.Complexity = 'real';
    yaw_allowed.SamplingMode = 'Sample based';
    yaw_allowed.InitialValue = '1';

    yaw_factor =  Simulink.Signal;
    yaw_factor.DataType = 'double';
    yaw_factor.Dimensions = 4;
    yaw_factor.Complexity = 'real';
    yaw_factor.SamplingMode = 'Sample based';
    yaw_factor.InitialValue = '[0.1 0.1 -0.1 -0.1]';

    yaw_headroom = Simulink.Signal;
    yaw_headroom.DataType = 'double';
    yaw_headroom.Dimensions = 1;
    yaw_headroom.Complexity = 'real';
    yaw_headroom.SamplingMode = 'Sample based';
    yaw_headroom.InitialValue = '200';

    yaw_rate_derivative =  Simulink.Signal;
    yaw_rate_derivative.DataType = 'double';
    yaw_rate_derivative.Dimensions = 1;
    yaw_rate_derivative.Complexity = 'real';
    yaw_rate_derivative.SamplingMode = 'Sample based';
    yaw_rate_derivative.InitialValue = '0';

    yaw_rate_error_rads = Simulink.Signal;
    yaw_rate_error_rads.DataType = 'double';
    yaw_rate_error_rads.Dimensions = 1;
    yaw_rate_error_rads.Complexity = 'real';
    yaw_rate_error_rads.SamplingMode = 'Sample based';
    yaw_rate_error_rads.InitialValue = '0';

    pitch_rate_filt_hz = Simulink.Signal;
    pitch_rate_filt_hz.DataType = 'double';
    pitch_rate_filt_hz.Dimensions = 1;
    pitch_rate_filt_hz.Complexity = 'real';
    pitch_rate_filt_hz.SamplingMode = 'Sample based';
    pitch_rate_filt_hz.InitialValue = '1/(2*pi)';

    pitch_rate_imax = Simulink.Signal;
    pitch_rate_imax.DataType = 'double';
    pitch_rate_imax.Dimensions = 1;
    pitch_rate_imax.Complexity = 'real';
    pitch_rate_imax.SamplingMode = 'Sample based';
    pitch_rate_imax.InitialValue = '200';

    pitch_rate_integrator = Simulink.Signal;
    pitch_rate_integrator.DataType = 'double';
    pitch_rate_integrator.Dimensions = 1;
    pitch_rate_integrator.Complexity = 'real';
    pitch_rate_integrator.SamplingMode = 'Sample based';
    pitch_rate_integrator.InitialValue = '0';

    pitch_rate_kD = Simulink.Signal;
    pitch_rate_kD.DataType = 'double';
    pitch_rate_kD.Dimensions = 1;
    pitch_rate_kD.Complexity = 'real';
    pitch_rate_kD.SamplingMode = 'Sample based';
    pitch_rate_kD.InitialValue = '5';

    pitch_rate_kI = Simulink.Signal;
    pitch_rate_kI.DataType = 'double';
    pitch_rate_kI.Dimensions = 1;
    pitch_rate_kI.Complexity = 'real';
    pitch_rate_kI.SamplingMode = 'Sample based';
    pitch_rate_kI.InitialValue = '0.1';

    pitch_rate_kP = Simulink.Signal;
    pitch_rate_kP.DataType = 'double';
    pitch_rate_kP.Dimensions = 1;
    pitch_rate_kP.Complexity = 'real';
    pitch_rate_kP.SamplingMode = 'Sample based';
    pitch_rate_kP.InitialValue = '0.2';

    pitch_rate_last_input = Simulink.Signal;
    pitch_rate_last_input.DataType = 'double';
    pitch_rate_last_input.Dimensions = 1;
    pitch_rate_last_input.Complexity = 'real';
    pitch_rate_last_input.SamplingMode = 'Sample based';
    pitch_rate_last_input.InitialValue = '0';

    pitch_rate_proportional = Simulink.Signal;
    pitch_rate_proportional.DataType = 'double';
    pitch_rate_proportional.Dimensions = 1;
    pitch_rate_proportional.Complexity = 'real';
    pitch_rate_proportional.SamplingMode = 'Sample based';
    pitch_rate_proportional.InitialValue = '0';

    %
    yaw_rate_filt_hz = Simulink.Signal;
    yaw_rate_filt_hz.DataType = 'double';
    yaw_rate_filt_hz.Dimensions = 1;
    yaw_rate_filt_hz.Complexity = 'real';
    yaw_rate_filt_hz.SamplingMode = 'Sample based';
    yaw_rate_filt_hz.InitialValue = '1/(2*pi)';

    yaw_rate_imax = Simulink.Signal;
    yaw_rate_imax.DataType = 'double';
    yaw_rate_imax.Dimensions = 1;
    yaw_rate_imax.Complexity = 'real';
    yaw_rate_imax.SamplingMode = 'Sample based';
    yaw_rate_imax.InitialValue = '200';

    yaw_rate_integrator = Simulink.Signal;
    yaw_rate_integrator.DataType = 'double';
    yaw_rate_integrator.Dimensions = 1;
    yaw_rate_integrator.Complexity = 'real';
    yaw_rate_integrator.SamplingMode = 'Sample based';
    yaw_rate_integrator.InitialValue = '0';

    yaw_rate_kD = Simulink.Signal;
    yaw_rate_kD.DataType = 'double';
    yaw_rate_kD.Dimensions = 1;
    yaw_rate_kD.Complexity = 'real';
    yaw_rate_kD.SamplingMode = 'Sample based';
    yaw_rate_kD.InitialValue = '5';

    yaw_rate_kI = Simulink.Signal;
    yaw_rate_kI.DataType = 'double';
    yaw_rate_kI.Dimensions = 1;
    yaw_rate_kI.Complexity = 'real';
    yaw_rate_kI.SamplingMode = 'Sample based';
    yaw_rate_kI.InitialValue = '0.1';

    yaw_rate_kP = Simulink.Signal;
    yaw_rate_kP.DataType = 'double';
    yaw_rate_kP.Dimensions = 1;
    yaw_rate_kP.Complexity = 'real';
    yaw_rate_kP.SamplingMode = 'Sample based';
    yaw_rate_kP.InitialValue = '0.2';

    yaw_rate_last_input = Simulink.Signal;
    yaw_rate_last_input.DataType = 'double';
    yaw_rate_last_input.Dimensions = 1;
    yaw_rate_last_input.Complexity = 'real';
    yaw_rate_last_input.SamplingMode = 'Sample based';
    yaw_rate_last_input.InitialValue = '0';

    yaw_rate_proportional = Simulink.Signal;
    yaw_rate_proportional.DataType = 'double';
    yaw_rate_proportional.Dimensions = 1;
    yaw_rate_proportional.Complexity = 'real';
    yaw_rate_proportional.SamplingMode = 'Sample based';
    yaw_rate_proportional.InitialValue = '0';

    roll_rate_filt_hz = Simulink.Signal;
    roll_rate_filt_hz.DataType = 'double';
    roll_rate_filt_hz.Dimensions = 1;
    roll_rate_filt_hz.Complexity = 'real';
    roll_rate_filt_hz.SamplingMode = 'Sample based';
    roll_rate_filt_hz.InitialValue = '1/(2*pi)';

    roll_rate_imax = Simulink.Signal;
    roll_rate_imax.DataType = 'double';
    roll_rate_imax.Dimensions = 1;
    roll_rate_imax.Complexity = 'real';
    roll_rate_imax.SamplingMode = 'Sample based';
    roll_rate_imax.InitialValue = '200';

    roll_rate_integrator = Simulink.Signal;
    roll_rate_integrator.DataType = 'double';
    roll_rate_integrator.Dimensions = 1;
    roll_rate_integrator.Complexity = 'real';
    roll_rate_integrator.SamplingMode = 'Sample based';
    roll_rate_integrator.InitialValue = '0';

    roll_rate_kD = Simulink.Signal;
    roll_rate_kD.DataType = 'double';
    roll_rate_kD.Dimensions = 1;
    roll_rate_kD.Complexity = 'real';
    roll_rate_kD.SamplingMode = 'Sample based';
    roll_rate_kD.InitialValue = '5';

    roll_rate_kI = Simulink.Signal;
    roll_rate_kI.DataType = 'double';
    roll_rate_kI.Dimensions = 1;
    roll_rate_kI.Complexity = 'real';
    roll_rate_kI.SamplingMode = 'Sample based';
    roll_rate_kI.InitialValue = '0.1';

    roll_rate_kP = Simulink.Signal;
    roll_rate_kP.DataType = 'double';
    roll_rate_kP.Dimensions = 1;
    roll_rate_kP.Complexity = 'real';
    roll_rate_kP.SamplingMode = 'Sample based';
    roll_rate_kP.InitialValue = '0.2';

    roll_rate_last_input = Simulink.Signal;
    roll_rate_last_input.DataType = 'double';
    roll_rate_last_input.Dimensions = 1;
    roll_rate_last_input.Complexity = 'real';
    roll_rate_last_input.SamplingMode = 'Sample based';
    roll_rate_last_input.InitialValue = '0';

    roll_rate_proportional = Simulink.Signal;
    roll_rate_proportional.DataType = 'double';
    roll_rate_proportional.Dimensions = 1;
    roll_rate_proportional.Complexity = 'real';
    roll_rate_proportional.SamplingMode = 'Sample based';
    roll_rate_proportional.InitialValue = '0';

    angle_max = Simulink.Signal;
    angle_max.DataType = 'double';
    angle_max.Dimensions = 1;
    angle_max.Complexity = 'real';
    angle_max.SamplingMode = 'Sample based';
    angle_max.InitialValue = '3000';

    ROLL_PITCH_INPUT_MAX = Simulink.Signal;
    ROLL_PITCH_INPUT_MAX.DataType = 'double';
    ROLL_PITCH_INPUT_MAX.Dimensions = 1;
    ROLL_PITCH_INPUT_MAX.Complexity = 'real';
    ROLL_PITCH_INPUT_MAX.SamplingMode = 'Sample based';
    ROLL_PITCH_INPUT_MAX.InitialValue = '3000';

    AC_ATTITUDE_THRUST_ERROR_ANGLE = Simulink.Signal;
    AC_ATTITUDE_THRUST_ERROR_ANGLE.DataType = 'double';
    AC_ATTITUDE_THRUST_ERROR_ANGLE.Dimensions = 1;
    AC_ATTITUDE_THRUST_ERROR_ANGLE.Complexity = 'real';
    AC_ATTITUDE_THRUST_ERROR_ANGLE.SamplingMode = 'Sample based';
    AC_ATTITUDE_THRUST_ERROR_ANGLE.InitialValue = '1000';

    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS = Simulink.Signal;
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS.DataType = 'double';
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS.Dimensions = 1;
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS.Complexity = 'real';
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS.SamplingMode = 'Sample based';
    AC_ATTITUDE_ACCEL_Y_CONTROLLER_MAX_RADSS.InitialValue = '0.5';

    acro_yaw_p = Simulink.Signal;
    acro_yaw_p.DataType = 'double';
    acro_yaw_p.Dimensions = 1;
    acro_yaw_p.Complexity = 'real';
    acro_yaw_p.SamplingMode = 'Sample based';
    acro_yaw_p.InitialValue = '45';

    attitude_target_euler_angle_x = Simulink.Signal;
    attitude_target_euler_angle_x.DataType = 'double';
    attitude_target_euler_angle_x.Dimensions = 1;
    attitude_target_euler_angle_x.Complexity = 'real';
    attitude_target_euler_angle_x.SamplingMode = 'Sample based';
    attitude_target_euler_angle_x.InitialValue = '0';

    attitude_target_euler_angle_y = Simulink.Signal;
    attitude_target_euler_angle_y.DataType = 'double';
    attitude_target_euler_angle_y.Dimensions = 1;
    attitude_target_euler_angle_y.Complexity = 'real';
    attitude_target_euler_angle_y.SamplingMode = 'Sample based';
    attitude_target_euler_angle_y.InitialValue = '0';

    attitude_target_euler_angle_z = Simulink.Signal;
    attitude_target_euler_angle_z.DataType = 'double';
    attitude_target_euler_angle_z.Dimensions = 1;
    attitude_target_euler_angle_z.Complexity = 'real';
    attitude_target_euler_angle_z.SamplingMode = 'Sample based';
    attitude_target_euler_angle_z.InitialValue = '0';

    attitude_target_euler_rate = Simulink.Signal;
    attitude_target_euler_rate.DataType = 'double';
    attitude_target_euler_rate.Dimensions = 3;
    attitude_target_euler_rate.Complexity = 'real';
    attitude_target_euler_rate.SamplingMode = 'Sample based';
    attitude_target_euler_rate.InitialValue = '[0 0 0]';

    attitude_target_quat = Simulink.Signal;
    attitude_target_quat.DataType = 'double';
    attitude_target_quat.Dimensions = 4;
    attitude_target_quat.Complexity = 'real';
    attitude_target_quat.SamplingMode = 'Sample based';
    attitude_target_quat.InitialValue = '[1 0 0 0]';

    rate_bf_ff_enabled = Simulink.Signal;
    rate_bf_ff_enabled.DataType = 'double';
    rate_bf_ff_enabled.Dimensions = 1;
    rate_bf_ff_enabled.Complexity = 'real';
    rate_bf_ff_enabled.SamplingMode = 'Sample based';
    rate_bf_ff_enabled.InitialValue = '0';

    use_ff_and_input_shaping = Simulink.Signal;
    use_ff_and_input_shaping.DataType = 'double';
    use_ff_and_input_shaping.Dimensions = 1;
    use_ff_and_input_shaping.Complexity = 'real';
    use_ff_and_input_shaping.SamplingMode = 'Sample based';
    use_ff_and_input_shaping.InitialValue = '0';

    attitude_target_euler_rate = Simulink.Signal;
    attitude_target_euler_rate.DataType = 'double';
    attitude_target_euler_rate.Dimensions = 3;
    attitude_target_euler_rate.Complexity = 'real';
    attitude_target_euler_rate.SamplingMode = 'Sample based';
    attitude_target_euler_rate.InitialValue = '[0 0 0]';

    attitude_vehicle_quat = Simulink.Signal;
    attitude_vehicle_quat.DataType = 'double';
    attitude_vehicle_quat.Dimensions = 4;
    attitude_vehicle_quat.Complexity = 'real';
    attitude_vehicle_quat.SamplingMode = 'Sample based';
    attitude_vehicle_quat.InitialValue = '[1 0 0 0]';

    thrust_error_angle = Simulink.Signal;
    thrust_error_angle.DataType = 'double';
    thrust_error_angle.Dimensions = 1;
    thrust_error_angle.Complexity = 'real';
    thrust_error_angle.SamplingMode = 'Sample based';
    thrust_error_angle.InitialValue = '0';

    rate_target_ang_vel = Simulink.Signal;
    rate_target_ang_vel.DataType = 'double';
    rate_target_ang_vel.Dimensions = 3;
    rate_target_ang_vel.Complexity = 'real';
    rate_target_ang_vel.SamplingMode = 'Sample based';
    rate_target_ang_vel.InitialValue = '[0 0 0]';


    attitude_target_ang_vel = Simulink.Signal;
    attitude_target_ang_vel.DataType = 'double';
    attitude_target_ang_vel.Dimensions = 3;
    attitude_target_ang_vel.Complexity = 'real';
    attitude_target_ang_vel.SamplingMode = 'Sample based';
    attitude_target_ang_vel.InitialValue = '[0 0 0]';

    yaw_attitude_kP = Simulink.Signal;
    yaw_attitude_kP.DataType = 'double';
    yaw_attitude_kP.Dimensions = 1;
    yaw_attitude_kP.Complexity = 'real';
    yaw_attitude_kP.SamplingMode = 'Sample based';
    yaw_attitude_kP.InitialValue = '4.5';

    roll_attitude_kP = Simulink.Signal;
    roll_attitude_kP.DataType = 'double';
    roll_attitude_kP.Dimensions = 1;
    roll_attitude_kP.Complexity = 'real';
    roll_attitude_kP.SamplingMode = 'Sample based';
    roll_attitude_kP.InitialValue = '4.5';

    pitch_attitude_kP = Simulink.Signal;
    pitch_attitude_kP.DataType = 'double';
    pitch_attitude_kP.Dimensions = 1;
    pitch_attitude_kP.Complexity = 'real';
    pitch_attitude_kP.SamplingMode = 'Sample based';
    pitch_attitude_kP.InitialValue = '4.5';
    
    %% Extra Variables



    %% Unnecessary simulink signals
    limit_roll_pitch = Simulink.Signal;
    limit_roll_pitch.DataType = 'double';
    limit_roll_pitch.Dimensions = 1;
    limit_roll_pitch.Complexity = 'real';
    limit_roll_pitch.SamplingMode = 'Sample based';
    limit_roll_pitch.InitialValue = '0.0';

    limit_throttle_upper = Simulink.Signal;
    limit_throttle_upper.DataType = 'logical';
    limit_throttle_upper.Dimensions = 1;
    limit_throttle_upper.Complexity = 'real';
    limit_throttle_upper.SamplingMode = 'Sample based';
    limit_throttle_upper.InitialValue = '0';

    limit_yaw = Simulink.Signal;
    limit_yaw.DataType = 'double';
    limit_yaw.Dimensions = 1;
    limit_yaw.Complexity = 'real';
    limit_yaw.SamplingMode = 'Sample based';
    limit_yaw.InitialValue = '0';

    save('globalizevariables.mat')  
end