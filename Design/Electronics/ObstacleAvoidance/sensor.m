function [ measured_distance alarm ] = sensor( actual_distance )
%SENSOR Summary of this function goes here
%   Detailed explanation goes here

measured_distance = actual_distance + noise(0.1);

alarm = 0;
if measured_distance < 1.5
    alarm = 1;
end

end

