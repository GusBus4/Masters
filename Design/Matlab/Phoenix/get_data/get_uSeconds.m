function [ uSeconds ] = get_uSeconds( PARAM )
%GET_USECONDS Summary of this function goes here
%   Returns the 2nd column from any flight log parameter, which just
%   happens to be the uSecond value for that sample.
uSeconds = PARAM(:,2);

end

