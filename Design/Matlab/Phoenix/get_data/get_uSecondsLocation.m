function [ location ] = get_uSecondsLocation( PARAM, uSeconds, uSecondsAbsMin )
%GET_USECONDSMINLOCATION Summary of this function goes here
%   Detailed explanation goes here
    
    test = 1;
    
    uSecondsParam = PARAM(:, 2);
    
    for i = 1:length( uSecondsParam ) 
        if  uSecondsParam(i) - uSecondsAbsMin >= uSeconds
            location = find(uSecondsParam == uSecondsParam(i));
            test = 0;
            break;
        end
    end
    
    
    if test == 1
        location = uSecondsParam(end)
    end
    
end

