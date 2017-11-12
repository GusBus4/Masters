function [ deltaArray ] = get_dataDelta( data )
%MATH_USECONDS_SMH Summary of this function goes here
%   Calculate the average differences in sequential datapoints.
%   Gathers and collects the following information:
    
    dataSize = size(data);
    delta = 0;
    %deltaArray = zeros(dataSize, 1);
    deltaSum = 0; 
    deltaAverage = 0;
    deltaMax = 0;
    deltaMin = 0;
    
    for i = 2:dataSize(1)
        delta = abs(data(i)-(data(i-1)));
        deltaArray(i, 1) = i;
        deltaArray(i, 2) = delta;
        deltaSum = delta + deltaSum;
        
        if delta > deltaMax
            deltaMax = delta;
        end
        if deltaMin == 0 || delta < deltaMin
            deltaMin = delta;
        end
    end
    deltaAverage = deltaSum / (dataSize(1) - 1);
    %deltaMax
    %deltaMin
end

