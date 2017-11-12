function [ ] = update_throttle_filter()
%%   UPDATE_THROTTLE_FILTER Summary of this function goes here
%   Detailed explanation goes here
    
    file = load('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\ardupilot\global.mat');                                         
    
    if armed == 1 

        if throttle_filter_cutoff_freq <= 0.0 || 1.0/loop_rate <= 0.0 
            
            throttle_filter_output = throttle_in;
        else
            
            rc = 1.0/(2 * pi * throttle_filter_cutoff_freq);
            alpha = math_constrain_value(dt/(dt+rc), 0.0, 1.0);
            throttle_filter_output = throttle_filter_output + (throttle_in - throttle_filter_output) * alpha;
        end

        %Constrain the filtered throttle
        if (throttle_filter_output < 0.0) 

            throttle_filter_output = 0.0;
        end

        if (throttle_filter_output > 1.0) 

            throttle_filter_output = 1.0;
        end
        
    %If Not Armed, then set the filtered throttle to 0
    else
        throttle_filter_output = 0.0;
    end

    save('C:\Users\GusBus\Documents\Masters\Matlab\Phoenix\ardupilot\global.mat');
end

