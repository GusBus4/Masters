function [ new_value ] = math_constrain_value( old_value, lower_limit, upper_limit )
%MATH_CONSTRAIN_VALUE Summary of this function goes here
%   Detailed explanation goes here


    if old_value > upper_limit
        
        new_value = upper_limit;
    
    elseif old_value < lower_limit
        
        new_value = lower_limit;
    else
        new_value = old_value;
    end
    
end

