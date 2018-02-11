function [ T ] = thrust( inputs, k )
T = [0;0;k*sum(inputs)];
end

