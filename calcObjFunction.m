function [popFitnesses, sortedPopulation] = calcObjFunction(population)
% Calculate the fitness of a population of chromosomes.
% RETURNS: The two matrices -- fitnesses and population -- both sorted by descending order of chromosome fitness.

% 
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
% 
[nLocations, nFacilities] = size(facilitiesFrequenciesMatrix);
[nPopulation, ~] = size(population);
popFitnesses = zeros(nPopulation, 1);

for idx = 1:nPopulation
    chrmsm = population(idx,:);
    distXfreq = zeros(nLocations, nFacilities);
    for i = 1:nLocations
        for j = 1:nFacilities
            dist = locationsDistancesMatrix(chrmsm(i),chrmsm(j));
            freq = facilitiesFrequenciesMatrix(i,j);
            distXfreq(i,j) = dist*freq;
        end
    end
    popFitnesses(idx) = sum(sum(distXfreq));
end

if nPopulation > 1
    temp = [population, popFitnesses];
    temp = sortrows(temp, nLocations+1);
    sortedPopulation = temp(:, 1:nLocations); 
    popFitnesses = temp(:, nLocations+1);
end

end

