%% Simple Corridor
wall_1   =  [
                -3 20;                                                      %North                                                   
                -3 -3                                                        %East                                                        
            ];
        
wall_2   =  [
                -3 20;      %17 17                                                %North
                1 1                                                     %East
            ];

%% Create Failed Test 1
% wall_1   =  [
%                 -3 -3;                                                      %North                                                   
%                 -10 -5                                                        %East                                                        
%             ];
%         
% wall_2   =  [
%                 -3 -3;      %17 17                                                %North
%                 10 5                                                     %East
%             ];
%         
% wall_3   =  [
%                 -3 1;                                                        
%                 -5 -1                                                        
%             ];
%         
% wall_4   =  [
%                 -3 1;                                                        
%                 5 1                                                        
%             ];
% wall_5   =  [
%                 10 1;                                                        
%                 -1 -1                                                        
%             ];
%         
% wall_6   =  [
%                 10 1;                                                        
%                 1 1                                                        
%             ];

%% Failed Test 2
% wall_1   =  [
%                 5 5;                                                      %North                                                   
%                 -5 5                                                        %East                                                        
%             ];
%         
% wall_2   =  [
%                 10 -5;      %17 17                                                %North
%                 -5 -5                                                     %East
%             ];
%         
% wall_3   =  [
%                 -5 -5;                                                        
%                 -5 10                                                        
%             ];
%         
% wall_4   =  [
%                 -5 10;                                                        
%                 10 10                                                        
%             ];
% wall_5   =  [
%                 10 10;                                                        
%                 10 -5                                                        
%             ];
        
% wall_6   =  [
%                 10 1;                                                        
%                 1 1                                                        
%             ];


%% Corridor Wide ZigZag
% wall_1   =  [
%                 -1 5;                                                      %North                                                   
%                 -5 -5                                                        %East                                                        
%             ];
%         
% wall_2   =  [
%                 -1 5;                                                      %North
%                 4 4                                                     %East
%             ];

wall_3   =  [
                5 12;                                                      %North                                                   
                4 11                                                        %East                                                        
            ];
        
wall_4   =  [
                5 12;                                                      %North
                -5 2                                                     %East
            ];

wall_5   =  [
                12 24;                                                        
                11 -1                                                        
            ];

wall_6   =  [
                12 24;                                                        
                2 -10                                                        
            ];

wall_7   =  [
                24 30;                                                        
                -10 -4                                                        
            ];
        
wall_8  =  [
                24 28;                                                      %North
                -1 3 
            ];
        
wall_9  =  [
                30 35;                                                      %North
                -4 -4 
            ];

wall_10  =  [
                28 35;                                                      %North
                3 3 
            ];

%% Corridor Narrow ZigZag
% wall_1   =  [
%                 -1 5;                                                      %North                                                   
%                 -2 -2                                                        %East                                                        
%             ];
%         
% wall_2   =  [
%                 -1 5;                                                      %North
%                 1 1                                                     %East
%             ];
% 
% wall_3   =  [
%                 5 8;                                                      %North                                                   
%                 1 4                                                        %East                                                        
%             ];
%         
% wall_4   =  [
%                 5 8;                                                      %North
%                 -2 1                                                     %East
%             ];
% 
% wall_5   =  [
%                 8 10;                                                        
%                 1 -1                                                        
%             ];
% 
% wall_6   =  [
%                 8 10;                                                        
%                 4 2                                                        
%             ];
% 
% wall_7   =  [
%                 10 12;                                                        
%                 -1 1                                                        
%             ];
%         
% wall_8  =  [
%                 10 11;                                                      %North
%                 2 3 
%             ];
%         
% wall_9  =  [
%                 12 20;                                                      %North
%                 1 1 
%             ];
% 
% wall_10  =  [
%                 11 20;                                                      %North
%                 3 3 
%             ];

% 
% %% Fullsuite
wall_1   =  [
                -3 16;                                                      %North                                                   
                3 3                                                        %East                                                        
            ];
        
wall_2   =  [
                16 20;                                                      %North
                3 -20                                                     %East
            ];
        
wall_3   =  [
                20 -3;                                                        
                -20 -20                                                        
            ];
        
wall_4   =  [
                -3 -3;                                                        
                -20 3                                                        
            ];
        
wall_5   =  [
                1 5;                                                        
                -5 -5                                                        
            ];

wall_6   =  [
                5 14;                                                        
                -5 0                                                        
            ];

wall_7   =  [
                14 14;                                                        
                0 -17                                                        
            ];
        
wall_8  =  [
                14 1;                                                      %North
                -17 -5 
            ];

        
wall_9   =  [
                14 15;                                                      %North
                -4 -6                                                   %East
            ];
        
wall_10  =  [
                15 14;                                                      %North
                -6 -9                                                        
            ];

wall_11   =  [
                7 7;                                                      %North
                -20 -14                                                        %East                                                        
            ];


wall_12  =  [
                7 -3;                                                      %North
                -14 -4                                                        
            ];

% wall_13  =  [
%                 0 0;                                                      %North
%                 0 0                                                        
%             ];
% 
% wall_14  =  [
%                 0 0;                                                      %North
%                 0 0                                                        
%             ];

roof = 6;                                                                  %Up
        
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

wall_12_body = dcm_earth_to_body(1:2, 1:2)*wall_12;
% wall_13_body = dcm_earth_to_body(1:2, 1:2)*wall_13;
% wall_14_body = dcm_earth_to_body(1:2, 1:2)*wall_14;

walls_body =  zeros(2, 2, 14);

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

walls_body(1, 1, 12) = wall_12_body(1, 1);
walls_body(1, 2, 12) = wall_12_body(1, 2);
walls_body(2, 1, 12) = wall_12_body(2, 1);
walls_body(2, 2, 12) = wall_12_body(2, 2);

% walls_body(1, 1, 13) = wall_13_body(1, 1);
% walls_body(1, 2, 13) = wall_13_body(1, 2);
% walls_body(2, 1, 13) = wall_13_body(2, 1);
% walls_body(2, 2, 13) = wall_13_body(2, 2);
% 
% walls_body(1, 1, 14) = wall_14_body(1, 1);
% walls_body(1, 2, 14) = wall_14_body(1, 2);
% walls_body(2, 1, 14) = wall_14_body(2, 1);
% walls_body(2, 2, 14) = wall_14_body(2, 2);
%% Plot in body frame, with Xb pointing in the Y-Plot direction
hold on;
grid on;

for k = 1:10
    plot(walls_body(2,:,k), walls_body(1,:,k), 'b');                        %X-plot = East; Y-Plot = North
end
% 
% for k = 1:length(walls_body)
%     plot(walls_body(2,:,k), walls_body(1,:,k), 'b');                        %X-plot = East; Y-Plot = North
% end
    
% xlim([-22 5])                                                               %East Limit
% ylim([-5 22])                                                               %North Limit

xlabel('Y Body')
ylabel('X Body')

hold off;