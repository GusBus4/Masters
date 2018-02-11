function [ output_args ] = plot_pilot_in_vs_set_points(pilot_in_roll, attitude_target_roll, pilot_in_pitch, attitude_target_pitch, pilot_in_yaw, rate_target_yaw, pilot_in_useconds, attitude_useconds, rate_useconds);
%PLOT_PILOT_IN_VS_SET_POINTS Summary of this function goes here
%   Detailed explanation goes here

    figure;
        title('Pilot Roll In vs Desired Roll');
        subplot(1, 3, 1)
        hold on;
        plot()
        hold off;
end

