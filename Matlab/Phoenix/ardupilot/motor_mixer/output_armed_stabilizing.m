function [ ] = output_armed_stabilizing(roll_target, pitch_target, yaw_target )
%%  OUTPUT_ARMED_STABILIZING Summary of this function goes here
%   Detailed explanation goes here
load('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\ardupilot\global.mat')
    
    %Reinitialise all these variables, just to make sure they are in a known state
    %roll_thrust = 0;                        %roll thrust input value, +/- 1.0
    %pitch_thrust = 0;                       %pitch thrust input value, +/- 1.0
    %yaw_thrust = 0;                         %yaw thrust input value, +/- 1.0
    %throttle_thrust = 0;                    %throttle thrust input value, 0.0 - 1.0
    throttle_thrust_best_rpy = 0;           %throttle providing maximum roll, pitch and yaw range without climbing
    rpy_scale = 1.0;                        %this is used to scale the roll, pitch and yaw to fit within the motor limits
    rpy_low = 0.0;                          %lowest motor value
    rpy_high = 0.0;                         %highest motor value
    yaw_allowed = 1.0;                      %amount of yaw we can fit in
    unused_range = 0;                       %amount of yaw we can fit in the current channel
    thr_adj = 0;                            %the difference between the pilot's desired throttle and throttle_thrust_best_rpy

    roll_thrust = roll_target;
    pitch_thrust = pitch_target;
    yaw_thrust = yaw_target;
    throttle_thrust = throttle_filter_output;
    
    math_constrain_value(throttle_avg_max, throttle_thrust, throttle_thrust_max);
    
    %% Calculate throttle that gives most possible room for yaw which is the lower of:
    %      1. 0.5f - (rpy_low+rpy_high)/2.0 - this would give the maximum possible margin above the highest motor and below the lowest
    %      2. the higher of:
    %            a) the pilot's throttle input
    %            b) the point _throttle_rpy_mix between the pilot's input throttle and hover-throttle
    %      Situation #2 ensure we never increase the throttle above hover throttle unless the pilot has commanded this.
    %      Situation #2b allows us to raise the throttle above what the pilot commanded but not so far that it would actually cause the copter to rise.
    %      We will choose #1 (the best throttle for yaw control) if that means reducing throttle to the motors (i.e. we favor reducing throttle *because* it provides better yaw control)
    %      We will choose #2 (a mix of pilot and hover throttle) only when the throttle is quite low.  We favor reducing throttle instead of better yaw control because the pilot has commanded it

    % calculate amount of yaw we can fit into the throttle range
    % this is always equal to or less than the requested yaw from the pilot or rate controller
    
    throttle_thrust_best_rpy = min(0.5, throttle_avg_max);
    
    
    %% Calculate Roll and Pitch for each motor & Calculate the amount of yaw input that each motor can accept
    for i = 4
        
        thrust_rpyt_out(i) = roll_thrust * roll_factor(i) + pitch_thrust * pitch_factor(i);

        if (yaw_thrust * yaw_factor(i) > 0.0)
            
            unused_range = fabsf((1.0 - (throttle_thrust_best_rpy + thrust_rpyt_out(i)))/yaw_factor(i));
            
            if (yaw_allowed > unused_range) 

                yaw_allowed = unused_range;

            end
            
        else
            unused_range = abs((throttle_thrust_best_rpy + thrust_rpyt_out(i))/yaw_factor(i));
            
            if (yaw_allowed > unused_range) 

                yaw_allowed = unused_range;

            end

        end
    end
    
    yaw_allowed = max(yaw_allowed, yaw_headroom/1000.0);
    
    if (abs(yaw_thrust) > yaw_allowed) 

        yaw_thrust = math_constrain_value(yaw_thrust, -yaw_allowed, yaw_allowed);
        %limit.yaw = true;
        
    end
    
    %% Add yaw to intermediate numbers for each motor
    rpy_low = 0.0;
    rpy_high = 0.0;
    
    for i=4
        thrust_rpyt_out(i) = thrust_rpyt_out(i) + yaw_thrust * yaw_factor(i);

        %record lowest roll+pitch+yaw command
        if (thrust_rpyt_out(i) < rpy_low)

            rpy_low = thrust_rpyt_out(i);

        end
        
        %record highest roll+pitch+yaw command
        if (thrust_rpyt_out(i) > rpy_high)

            rpy_high = thrust_rpyt_out(i);

        end
    end
      
    %% Check everything fits
    throttle_thrust_best_rpy = min(0.5 - (rpy_low+rpy_high)/2.0, throttle_avg_max);

    if rpy_low == 0
        rpy_scale = 1.0;
    else 
        rpy_scale = math_constrain_value(-throttle_thrust_best_rpy/rpy_low, 0.0, 1.0);
    end

    %% Calculate how close the motors can come to the desired throttle
    thr_adj = throttle_thrust - throttle_thrust_best_rpy;
    
    if (rpy_scale < 1.0)
        %Full range is being used by roll, pitch, and yaw.
        %limit.roll_pitch = true;
        %limit.yaw = true;
        
        if (thr_adj > 0.0) 
            %limit.throttle_upper = true;
        end
        
        thr_adj = 0.0;
    else 
        if thr_adj < -(throttle_thrust_best_rpy+rpy_low)
            %Throttle can't be reduced to desired value
            thr_adj = -(throttle_thrust_best_rpy+rpy_low);
        elseif (thr_adj > 1.0 - (throttle_thrust_best_rpy+rpy_high))
            %Throttle can't be increased to desired value
            thr_adj = 1.0 - (throttle_thrust_best_rpy+rpy_high);
            %limit.throttle_upper = true;
        end
    end

    %Add scaled roll, pitch, constrained yaw and throttle for each motor
    for i=4
            thrust_rpyt_out(i) = throttle_thrust_best_rpy + thr_adj + rpy_scale * thrust_rpyt_out(i);
    end

    %Constrain all outputs to 0.0f to 1.0f
    for i=4
            thrust_rpyt_out(i) = math_constrain_value(thrust_rpyt_out(i), 0.0, 1.0);
    end
    
save('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\ardupilot\global.mat')
end

