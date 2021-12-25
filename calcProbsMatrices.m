function [cummProbsMatrix] = calcProbsMatrices(pheromoneMatrix)
% Generate the individual and cummulative probabilities from the pheromone matrix.

[nLocations, nFacilities] = size(pheromoneMatrix);

% --- CALCULATE PROBABILITIES BASED ON PHEROMONE MATRIX
probsMatrix = zeros(size(pheromoneMatrix));
for i = 1:nLocations
    for j = 1:nFacilities
        probsMatrix(i,j) = pheromoneMatrix(i,j) / sum(pheromoneMatrix(i,:));
    end
end
clear i j


% --- CALCULATE CUMMULATIVE PROBABILITIES BASED ON PROBABILITIES MATRIX
cummProbsMatrix = probsMatrix;
for i = 2:nLocations
    for j = 2: nFacilities
        cummProbsMatrix(i,j) = cummProbsMatrix(i,j-1) + cummProbsMatrix(i,j);
    end
end
clear i  j

end

