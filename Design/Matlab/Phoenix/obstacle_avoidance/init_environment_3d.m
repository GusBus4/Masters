%% Init Room Variables
room_length         = 10;
room_width          = 2;
room_height         = 8;



%% Create Basic Outlines for Room

room_n =    [
                5 5;                                                        %Front Bottom
                5 5;                                                        %Front Top
            ]
        
room_e =    [
                -room_width/2 room_width/2;                                 %Front Bottom
                -room_width/2 room_width/2;                                 %Front Top
            ]
        
room_d =    [
                0 0;                                                        %Front Bottom
                room_height room_height;                                    %Front Top
            ]
        
% front_bottom    = [-room_width/2:1:room_width/2; zeros([1 length(-room_width/2:1:room_width/2)])+room_length/2; zeros([1 length(-room_width/2:1:room_width/2)])]
% front_top       = [-room_width/2:1:room_width/2; zeros([1 length(-room_width/2:1:room_width/2)])+room_length/2; zeros([1 length(-room_width/2:1:room_width/2)]) + room_height]
% back_bottom     = [-room_width/2:1:room_width/2; zeros([1 length(-room_width/2:1:room_width/2)])-room_length/2; zeros([1 length(-room_width/2:1:room_width/2)])]
% back_top        = [-room_width/2:1:room_width/2; zeros([1 length(-room_width/2:1:room_width/2)])-room_length/2; zeros([1 length(-room_width/2:1:room_width/2)]) + room_height]

hold on;
view(3);
grid on;

plot3((-room_width/2):1:(room_width/2), zeros([1 length((-room_width/2):1:(room_width/2))])+room_length/2, zeros([1 length((-room_width/2):1:(room_width/2))]), 'r', 'LineWidth', 2)
plot3((-room_width/2):1:(room_width/2), zeros([1 length((-room_width/2):1:(room_width/2))])+room_length/2, zeros([1 length((-room_width/2):1:(room_width/2))])+room_height, 'r', 'LineWidth', 2)
plot3((-room_width/2):1:(room_width/2), zeros([1 length((-room_width/2):1:(room_width/2))])-room_length/2, zeros([1 length((-room_width/2):1:(room_width/2))]), 'r', 'LineWidth', 2)
plot3((-room_width/2):1:(room_width/2), zeros([1 length((-room_width/2):1:(room_width/2))])-room_length/2, zeros([1 length((-room_width/2):1:(room_width/2))])+room_height, 'r', 'LineWidth', 2)
 
plot3(zeros([1 length((-room_length/2):1:(room_length/2))])-room_width/2, (-room_length/2):1:(room_length/2), zeros([1 length((-room_length/2):1:(room_length/2))]), 'r', 'LineWidth', 2)
plot3(zeros([1 length((-room_length/2):1:(room_length/2))])-room_width/2, (-room_length/2):1:(room_length/2), zeros([1 length((-room_length/2):1:(room_length/2))])+room_height, 'r', 'LineWidth', 2)
plot3(zeros([1 length((-room_length/2):1:(room_length/2))])+room_width/2, (-room_length/2):1:(room_length/2), zeros([1 length((-room_length/2):1:(room_length/2))]), 'r', 'LineWidth', 2)
plot3(zeros([1 length((-room_length/2):1:(room_length/2))])+room_width/2, (-room_length/2):1:(room_length/2), zeros([1 length((-room_length/2):1:(room_length/2))])+room_height, 'r', 'LineWidth', 2)
 
plot3(zeros([1 length(0:1:room_height)])-room_width/2, zeros([1 length(0:1:room_height)])+room_length/2, (0:1:room_height), 'r', 'LineWidth', 2)
plot3(zeros([1 length(0:1:room_height)])-room_width/2, zeros([1 length(0:1:room_height)])-room_length/2, (0:1:room_height), 'r', 'LineWidth', 2)
plot3(zeros([1 length(0:1:room_height)])+room_width/2, zeros([1 length(0:1:room_height)])+room_length/2, (0:1:room_height), 'r', 'LineWidth', 2)
plot3(zeros([1 length(0:1:room_height)])+room_width/2, zeros([1 length(0:1:room_height)])-room_length/2, (0:1:room_height), 'r', 'LineWidth', 2)

xlim([-10 10])
ylim([-10 10])
zlim([-1 10])
% xlim([(-room_width/2 - 1) (room_width/2 + 1)]);
% ylim([(-room_length/2 - 1 ) ( room_length/2 + 1)]);
% zlim([(- 1) (room_height + 1)]);
hold off;