function [ angle_above_threshold ] = angle_check( column_vector1, column_vector2, angle_min_limit_deg )
%ANGLE_CHECK Summary of this function goes here
%   Detailed explanation goes here
    
    %% Create unity vectors to only keep direction information
    column_vector1 = column_vector1/(norm(column_vector1));
    column_vector2 = column_vector2/(norm(column_vector2));

    %% ||Cross(A, B)|| = ||A|| x ||B|| x sin(alpha)
    cross_product_length = norm(cross(column_vector1, column_vector2));

    alpha = rad2deg(asin(cross_product_length));

    if alpha < angle_min_limit_deg
        angle_above_threshold = 0;
    else
       angle_above_threshold = 1;
    end

end

