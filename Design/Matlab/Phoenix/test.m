%% Import Variables

% current_yaw         = heading_current_yaw(count)                            %Radians
current_yaw           = deg2rad(0.1)
% previous_target     = yaw_angle_target(count - 1)                           %Radians
   
%% Create Column vectors representing the line of each segment  
% velocity_vector =   [
%                         heading_velocity_vector(count, 1);
%                         heading_velocity_vector(count, 2);
%                         0
%                     ];
velocity_vector =   [
                        1;                                                 %North
                        1;                                                %East
                        0
                    ];
                
align_vector    =   [
                        1;                                                 %Body X
                        0;                                                 %Body Y
                        0
                    ];
         
heading_vector  =   angle2dcm(0, 0, current_yaw, 'XYZ')'*align_vector;     %This allows for flight at any alignment angle
      
%% Create unity vectors to only keep direction information
velocity_vector = velocity_vector/(norm(velocity_vector))
align_vector    = align_vector/(norm(align_vector))
heading_vector  = heading_vector/norm(heading_vector)

%% If the angle between the current heading and the current velocity is bigger than 90, 
%  then align the negative of the aling vector

% ||Cross(A, B)|| = ||A|| x ||B|| x sin(alpha)
% alpha = rad2deg(asin(norm(cross(velocity_vector, heading_vector))))
% Dot(A, B) = ||A|| x ||B|| x cos(alpha)
alpha = rad2deg(acos(dot(velocity_vector, heading_vector)))

gain = -1;

if alpha > 90
    
    heading_vector = -heading_vector
    
    gain = 1;
    
end


% %% ||Cross(A, B)|| = ||A|| x ||B|| x sin(beta)
beta = rad2deg(asin(norm(cross(velocity_vector, heading_vector))))

if current_yaw < 0
    if velocity_vector(2) < 0 
        gain = -gain;
    end
else
    if velocity_vector(2) > 0 
        gain = -gain;
    end    
end


target = rad2deg(current_yaw) + gain*beta

% alpha = quadrant_gain*rad2deg(asin(cross_product_length))
% 
% % dot_product = dot(sc1, wc1);
% % beta = quadrant_gain*rad2deg(acos(dot_product))
% 
% %% Check if it is quicker to rotate the opposite quadrant
% if abs(rad2deg(current_yaw) - alpha) > 90
%     test1 = 1
%     alpha = 180 + alpha;
% end
% 
% 
% if abs(alpha) > (180)
%     
%     if alpha > 0
%         test1 = 2
%         alpha = alpha - (360);
%     else
%         test1 = 3
%         alpha = alpha + (360);
%     end  
% end
% 
% alpha = deg2rad(alpha)
% 
% if abs(previous_target - (alpha - deg2rad(360))) < abs(previous_target - alpha) || abs(previous_target - (alpha + deg2rad(360))) < abs(previous_target - alpha)
%     
%     if alpha > 0
%         alpha = alpha - deg2rad(360);
%     else
%         alpha = alpha + deg2rad(360);
%     end 
%  
% end

% answer = rad2deg(alpha)

figure;
hold on;
grid on;

plot([0  velocity_vector(2)], [0 velocity_vector(1)], 'r', 'LineWidth', 2); 
plot([0  heading_vector(2)],  [0 heading_vector(1)], 'b', 'LineWidth', 2);
% plot([0  align_vector(2)],    [0 align_vector(1)], 'g', 'LineWidth', 2);

xlim([-5 5])
ylim([-5 5])
hold off;

count = count + 1