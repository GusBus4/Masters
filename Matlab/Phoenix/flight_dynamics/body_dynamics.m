function [ rollDot, pitchDot, yawDot ] = body_dynamics( motorThrust1, motorThrust2, motorThrust3, motorThrust4 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rollDot = 2 * (motorThrust1+motorThrust4);
pitchDot = 3 * motorThrust2;
yawDot = 4 * motorThrust3 ;

end

