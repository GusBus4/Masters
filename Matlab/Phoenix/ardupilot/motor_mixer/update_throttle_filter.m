function [output] = update_throttle_filter(throttle_in)
%%   UPDATE_THROTTLE_FILTER Summary of this function goes here
%   Detailed explanation goes here
    
    %Declare Global Variales
    global throttle_filter_output throttle_filter_cutoff_freq dt
    
    if throttle_filter_cutoff_freq <= 0.0 %|| 1.0/loop_rate <= 0.0 
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
    
    output = throttle_filter_output;
end

