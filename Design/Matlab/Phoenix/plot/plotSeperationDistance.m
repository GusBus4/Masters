
rotor_radius = 254
seperation_distance = 0:508;

for i = 1:length(seperation_distance)
    overlap(i) = (2/pi()) * ( acos(seperation_distance(i) / (2*rotor_radius)) - (seperation_distance(i)/(2*rotor_radius))*sqrt(1 - (seperation_distance(i)/(2*rotor_radius))^2));
    efficieny(i) = 1 - (((2/(2-overlap(i)))^(0.5)) - 1);
end


figure;

hold on;
plot(overlap*100, efficieny, 'LineWidth', 2);
plot(20, 0.9459, 'r+', 'LineWidth', 2, 'MarkerSize', 15)
plot(20, 0.9459, 'r+', 'LineWidth', 2, 'MarkerSize', 15)
dim = [.2 .5 .3 .3];
str = ['20% Overlap' newline '95% Efficient'];
annotation('textbox',dim,'String',str,'FitBoxToText','on', 'FontSize', 20);
xlabel('Percentage Overlap', 'FontSize', 20)
ylabel('Efficiency of Rotors', 'FontSize', 20)
grid on;
hold off;