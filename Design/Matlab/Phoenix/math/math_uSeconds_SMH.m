function [ seconds,  minutes,  hours ] = math_uSeconds_SMH( uSeconds )
%MATH_USECONDS_SMH Summary of this function goes here
%   Detailed explanation goes here
    
    miliSeconds = uSeconds/1000;
    seconds = miliSeconds/1000;
    minutes = seconds/60;
    hours = minutes/60;
    
end

