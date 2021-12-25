function visualizeSolution(solution, facility)
%  Plot a given facility's frequencies/distances with other facilities/locations in the solution.
% The thickness of the lines represents the frequencies while the length represents the distances.

if nargin < 1
    solution = [9 11 5 6 7 2 4 1 3 8 10]; % optimum solution
    % solution = [11 5 8 7 2 9 3 1 6 4 10]; % papers's optimum solution
    facility = 3;
end

facilitiesFrequenciesMatrix = [
                        0, 5, 2, 2, 1, 1, 4, 1, 2, 9, 1;
                        5, 0, 2, 5, 1, 2, 7, 8, 2, 3, 8;
                        2, 2, 0, 7, 4, 4, 9, 4, 5, 6, 5;
                        2, 5, 7, 0, 8, 7, 8, 1, 8, 5, 1;
                        1, 1, 4, 8, 0, 3, 4, 1, 3, 3, 6;
                        1, 2, 4, 7, 3, 0, 5, 8, 4, 7, 5;
                        4, 7, 9, 8, 4, 5, 0, 7, 6, 3, 2;
                        1, 8, 4, 1, 1, 8, 7, 0, 9, 4, 8;
                        2, 2, 5, 8, 3, 4, 6, 9, 0, 5, 3;
                        9, 3, 6, 5, 3, 7, 3, 4, 5, 0, 5;
                        1, 8, 5, 1, 6, 5, 2, 8, 3, 5, 0;
];
% 
locationsDistancesMatrix = [
                     0, 15, 25, 33, 40, 42, 47, 55, 35, 30, 20;
                    15,  0, 10, 18, 25, 27, 32, 42, 50, 45, 35;
                    25, 10,  0,  8, 15, 17, 22, 32, 52, 55, 45;
                    33, 18,  8,  0,  7,  9, 14, 24, 44, 49, 53;
                    40, 25, 15,  7,  0,  2,  7, 17, 37, 42, 52;
                    42, 27, 17,  9,  2,  0,  5, 15, 35, 40, 50;
                    47, 32, 22, 14,  7,  5,  0, 10, 30, 35, 40;
                    55, 42, 32, 24, 17, 15, 10,  0, 20, 25, 35;
                    35, 50, 52, 44, 37, 35, 30, 20,  0,  5, 15;
                    30, 45, 55, 49, 42, 40, 35, 25,  5,  0, 10;
                    20, 35, 45, 53, 52, 50, 40, 35, 15, 10,  0;
];

n_vals = length(solution);
y_vals = zeros(n_vals);
y_labels = [];
y_textx = [];
x_dists = zeros(n_vals);
t_freqs = zeros(n_vals);

for i = 1:length(solution)
    y_vals(i) = i;
    x_dists(i) = locationsDistancesMatrix(solution(facility), i);
    if i == facility
        t_freqs(solution(i)) = 1;
    else
        t_freqs(solution(i)) = facilitiesFrequenciesMatrix(facility, i);
    end
    % y_ticklabels{solution(i)} = sprintf("F%02d-L%02d", i, solution(i));
    y_labels{solution(i)} = sprintf("L%02d", solution(i));
    y_texts{solution(i)} = sprintf("[ F%02d ]", i);
end
clear i

for i = 1:length(solution)
    plot([0, x_dists(i)], [y_vals(i), y_vals(i)], 'LineWidth', t_freqs(i));
    text(x_dists(i) + 1, y_vals(i), y_texts(i), 'FontWeight', "bold", 'Color', "b");
    hold on;
end
clear i; 

% # [>>>>>]____________________________________________________________
% for n = 1:length(solution)
%     facility = n;
%     for i = 1:length(solution)
%         x_dists(n,i) = locationsDistancesMatrix(solution(facility), i);
%     end
% end
% clear i n
% bar3(x_dists);
% # [>>>>>]____________________________________________________________

grid("on");
ylim([0, 12]); yticks([1:1:11]);
yticklabels(y_labels); 
ylabel("Facilities/Locations", 'FontWeight', "bold"); 
xlabel("Distances", 'FontWeight', "bold"); 
title(sprintf("Visualizing Solution: Distances & Frequencies @ Facility %02d", facility));
set(gcf, 'Position', [90 260 750 400]);

hold off;

end