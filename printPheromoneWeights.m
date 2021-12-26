function printPheromoneWeights(pheromoneMatrix, bestSolution, iters, display)
% Print a stylized plot of the pheromone matrix and best solution. This can be set to print to disk (png file) or display.

if nargin < 3
    iters = 0;
    display = true;
end
    
normPheromoneMatrix = zeros(size(pheromoneMatrix));
[nLocations, nFacilities] = size(pheromoneMatrix);

% normalize the data using min-max scaling [each entry has a min-max value of 0-1]
for i = 1:nLocations
    normPheromoneMatrix(i,:) = pheromoneMatrix(i,:) - min(pheromoneMatrix(i,:));
    normPheromoneMatrix(i,:) = normPheromoneMatrix(i,:) / max(normPheromoneMatrix(i,:));
end

if not(display)
    figure('visible', 'off');
end

for i = 1:nLocations
    for j = 1:nFacilities
        scatter(i, j, 'o', 'MarkerEdgeAlpha', normPheromoneMatrix(i,j), "LineWidth", 3);
        hold on; 
    end
end

grid on; box on;
axis([0 nFacilities+1 0 nLocations+1]); 
xticks([1:1:nFacilities]); yticks([1:1:nLocations]);
xlabel("Locations"); ylabel("Facilities"); 
if not(display)
    title(sprintf("Best Solution & Pheromone Weights - Iteration %02d", iters));
else
    title("Current Best Solution & Pheromone Weights");
end

plot(bestSolution, [1:1:length(bestSolution)], "r--", "LineWidth",1);
hold off;

if not(display)
    print(sprintf('Pheromone_Matrix_Weights_%02d', iters), "-dpng")
end

clear i j normPheromoneMatrix; 

end

