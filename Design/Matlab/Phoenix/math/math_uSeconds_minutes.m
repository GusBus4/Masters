function [ minutes ] = math_uSeconds_minutes( uSeconds )
%MATH_USECONDS_SMH Summary of this function goes here
%   Converts a uSecond value to a number of minutes
    
    mSeconds = uSeconds/1000.0;
    seconds = mSeconds/1000.0;
    minutes = seconds/60.0;
    
end

