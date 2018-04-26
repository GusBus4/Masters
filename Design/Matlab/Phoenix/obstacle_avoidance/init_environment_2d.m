%% Create Basic Outlines for Room
wall_1   =  [
                -1 7;                                                      %North                                                   
                0 0                                                        %East                                                        
            ];
        
wall_2   =  [
                7 7;                                                      %North
                0 2.5                                                     %East
            ];
        
wall_3   =  [
                -1 5;                                                        
                6 6                                                        
            ];
        
wall_4   =  [
                5 12;                                                        
                6 9                                                        
            ];

wall_5   =  [
                12 17;                                                        
                9 9                                                        
            ];

wall_6   =  [
                17 17;                                                        
                -10 9                                                        
            ];

wall_7   =  [
                -1 -1;                                                        
                -10 6                                                        
            ];
        
wall_8  =  [
                -1 17;                                                      %North
                -10 -10 
            ];
        
wall_9   =  [
                10 10;                                                        
                2 0                                                   %East
            ];
        
wall_10  =  [
                12 10;                                                        
                0 2                                                        
            ];

 wall_11   =  [
                10 12;                                                      %North                                                   
                0 0                                                        %East                                                        
            ];

% 
% wall_12  =  [
%                 12 17;                                                        
%                 9 9                                                        
%             ];
% 
% wall_13  =  [
%                 17 17;                                                        
%                 0 9                                                        
%             ];
% 
% wall_14  =  [
%                 -1 -1;                                                        
%                 0 6                                                        
%             ];

roof = 10;                                                                  %Up
        
%% Rotate into Body Frame
wall_1_body = dcm_earth_to_body(1:2, 1:2)*wall_1; 
wall_2_body = dcm_earth_to_body(1:2, 1:2)*wall_2;
wall_3_body = dcm_earth_to_body(1:2, 1:2)*wall_3;
wall_4_body = dcm_earth_to_body(1:2, 1:2)*wall_4;
wall_5_body = dcm_earth_to_body(1:2, 1:2)*wall_5;
wall_6_body = dcm_earth_to_body(1:2, 1:2)*wall_6;
wall_7_body = dcm_earth_to_body(1:2, 1:2)*wall_7;

wall_8_body = dcm_earth_to_body(1:2, 1:2)*wall_8;
wall_9_body = dcm_earth_to_body(1:2, 1:2)*wall_9;
wall_10_body = dcm_earth_to_body(1:2, 1:2)*wall_10;
wall_11_body = dcm_earth_to_body(1:2, 1:2)*wall_11;
% wall_7_body = dcm_earth_to_body(1:2, 1:2)*wall_12;

walls_body =  zeros(2, 2, 8);

walls_body(1, 1, 1) = wall_1_body(1, 1);                                    %Xb1
walls_body(1, 2, 1) = wall_1_body(1, 2);                                    %Xb2
walls_body(2, 1, 1) = wall_1_body(2, 1);                                    %Yb2
walls_body(2, 2, 1) = wall_1_body(2, 2);                                    %Yb2

walls_body(1, 1, 2) = wall_2_body(1, 1);
walls_body(1, 2, 2) = wall_2_body(1, 2);
walls_body(2, 1, 2) = wall_2_body(2, 1);
walls_body(2, 2, 2) = wall_2_body(2, 2);

walls_body(1, 1, 3) = wall_3_body(1, 1);
walls_body(1, 2, 3) = wall_3_body(1, 2);
walls_body(2, 1, 3) = wall_3_body(2, 1);
walls_body(2, 2, 3) = wall_3_body(2, 2);

walls_body(1, 1, 4) = wall_4_body(1, 1);
walls_body(1, 2, 4) = wall_4_body(1, 2);
walls_body(2, 1, 4) = wall_4_body(2, 1);
walls_body(2, 2, 4) = wall_4_body(2, 2);

walls_body(1, 1, 5) = wall_5_body(1, 1);
walls_body(1, 2, 5) = wall_5_body(1, 2);
walls_body(2, 1, 5) = wall_5_body(2, 1);
walls_body(2, 2, 5) = wall_5_body(2, 2);

walls_body(1, 1, 6) = wall_6_body(1, 1);
walls_body(1, 2, 6) = wall_6_body(1, 2);
walls_body(2, 1, 6) = wall_6_body(2, 1);
walls_body(2, 2, 6) = wall_6_body(2, 2);

walls_body(1, 1, 7) = wall_7_body(1, 1);
walls_body(1, 2, 7) = wall_7_body(1, 2);
walls_body(2, 1, 7) = wall_7_body(2, 1);
walls_body(2, 2, 7) = wall_7_body(2, 2);

walls_body(1, 1, 8) = wall_8_body(1, 1);
walls_body(1, 2, 8) = wall_8_body(1, 2);
walls_body(2, 1, 8) = wall_8_body(2, 1);
walls_body(2, 2, 8) = wall_8_body(2, 2);

walls_body(1, 1, 9) = wall_9_body(1, 1);
walls_body(1, 2, 9) = wall_9_body(1, 2);
walls_body(2, 1, 9) = wall_9_body(2, 1);
walls_body(2, 2, 9) = wall_9_body(2, 2);

walls_body(1, 1, 10) = wall_10_body(1, 1);
walls_body(1, 2, 10) = wall_10_body(1, 2);
walls_body(2, 1, 10) = wall_10_body(2, 1);
walls_body(2, 2, 10) = wall_10_body(2, 2);

walls_body(1, 1, 11) = wall_11_body(1, 1);
walls_body(1, 2, 11) = wall_11_body(1, 2);
walls_body(2, 1, 11) = wall_11_body(2, 1);
walls_body(2, 2, 11) = wall_11_body(2, 2);

%% Plot in body frame, with Xb pointing in the Y-Plot direction
hold on;
grid on;

for k = 1:length(walls_body)
    plot(walls_body(2,:,k), walls_body(1,:,k), 'b');                        %X-plot = East; Y-Plot = North
end
    
xlim([-20 20])                                                               %East Limit
ylim([-20 20])                                                               %North Limit

xlabel('Y Body')
ylabel('X Body')

hold off;