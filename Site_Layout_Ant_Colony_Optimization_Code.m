%% *Site-Level Facilities Layout Using Ant Colony Optimization*
% Oluwaleke Umar Yusuf
% Reference Paper: Site-Level Facilities Layout Using Genetic Algorithms
% >>> https://ascelibrary.org/doi/abs/10.1061/%28ASCE%290887-3801%281998%2912%3A4%28227%29

clc; clear; close all;

%% Design Variables & Constraints

s_Facilities = ["SO", "FW", "LR", "S1", "S2", "CW", "RSW", "SG", "UCR", "CBW", "MG"];
f_Facilities = ["Site Office", "Falsework Workshop", "Labor Residence", "Storeroom 1", ...
                "Storeroom 2", "Carpentry Workshop", "Reinforcement Steel Workshop", ...
                "Side Gate", "Utilities Control Room", "Concrete Batch Workshop", "Main Gate"];

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
[nLocations, nFacilities] = size(facilitiesFrequenciesMatrix);

reservedLocations = [1, 10];
specialFacilities = [8, 11];

%% Code Implementation

% --- INIT ALGORITHM HYPERPARAMETERS
rng(sum(double(char("AntColonyOptimization")))) % fix the seed for random number generation
maxIterations = 100;
nIterConvergence = 10;
histFitnesses = zeros(maxIterations, nLocations+2); % best fitness | mean fitness | best solution
nPopulation = 50;
pheromoneDecayFactor = 0.05;
pheromoneScalingParameter = 1.5;
printWeights = false;

% --- INIT PHEROMONE MATRIX AND PLACE SPECIAL FACILITIES IN RESERVED LOCATIONS
pheromoneMatrix = ones(nLocations, nFacilities);

for idx = 1:length(reservedLocations)
    % clear the entire row i.e. no facilities placed at this location
    pheromoneMatrix(reservedLocations(idx),:) = 0;
    % clear the entire column i.e. this facility is not placed at any location
    pheromoneMatrix(:,specialFacilities(idx)) = 0;
    % place the special facility at its reserved location 
    pheromoneMatrix(reservedLocations(idx),specialFacilities(idx)) = 1;
end; clear idx

%%
% --- START GENERATION LOOP ---
for iters = 1:maxIterations
    % --- GENERATE LOCATION-FACILITY PLACEMENT PROBABILTES FOR ALL ANTS IN POPULATION
    randLocationProbabilities = rand(nPopulation, nLocations);
    
    % --- CHOOSE THE PATH FOR EACH ANT USING ROULETTE WHEEL SELECTION
    locationsXfacilities = ones(size(randLocationProbabilities));
    facilitiesXlocations = ones(size(randLocationProbabilities));
    
    for ant = 1:nPopulation
        % create a copy of the pheromone matrix which will be updated once a facility has been assigned to a location 
        % i.e. once a facility has been assigned to a location, its pheromone values (for its column) are set to zero such that
        % there is zero probability of that same facility being assigned to another location in subsequent steps.
        tempPheromoneMatrix = pheromoneMatrix;
        
        for i = 1:nLocations
        % (re)compute the probabilities matrices to reflect any updates in the temp pheromone matrix
        [cummProbsMatrix] = calcProbsMatrices(tempPheromoneMatrix);
        
            for j = 1:nFacilities
                if cummProbsMatrix(i,j) > randLocationProbabilities(ant, i)
                    % TRANSLATION: facility j (column idx value) assigned to location i (column idx)
                    facilitiesXlocations(ant,j) = i;
                    % TRANSLATION: location i (column idx) contains facility j (column idx value)
                    locationsXfacilities(ant,i) = j;
                    
                    % since facility j has been assigned to a location, set column j in the temp pheromone matrix to zero 
                    % ensuring that facility j will never be selected again! because its probabilities henceforth will be zero!
                    tempPheromoneMatrix(:,j) = 0;
                    break
                end
            end
        end
    end; clear ant tempPheromoneMatrix i j locationsXfacilities cummProbsMatrix
    
    % --- TEST THAT THERE ARE NO FACILITIES ASSIGNED TO MULTIPLE LOCATIONS
    calcFeasibilities(facilitiesXlocations, false);
    
    % --- CALCULATE THE FITNESSES OF SOLUTIONS IN THE POPULATION
    [fitnesses, population] = calcObjFunction(facilitiesXlocations);
    histFitnesses(iters, :) = [fitnesses(1) mean(fitnesses) population(1,:)];
    bestSolution = population(1,:);
    
    % --- PLOT THE BEST SOLUTION AND CURRENT PHEROMONE WEIGHTS AND SAVE TO FILE
    heatmap(pheromoneMatrix, "CellLabelFormat","%0.2g", "ColorScaling","log", "ColorbarVisible","off"); 
    xlabel("Facilities"); ylabel("Locations"); title(sprintf("Pheromone Matrix @Iteration %02d", iters)); pause(1);
    if printWeights
        printPheromoneWeights(pheromoneMatrix, bestSolution, iters, false)
    end
        
    % --- CHECK FOR CONVERGENCE
    % terminate the algorithm if the best fitness value did not change for n iterations
    if iters > 2*nIterConvergence && length(unique(histFitnesses(iters-nIterConvergence:iters, 1))) == 1
        warning("Fitness has stagnated for %d iterations! Terminating at iteration %d!\n", nIterConvergence, iters)
        histFitnesses(iters+1:end, :) = [];
        break
    end
        
    % --- UPDATE THE PHEROMONE MATRIX
    bestNodeUpdate = pheromoneScalingParameter * (fitnesses(1)/fitnesses(end)); % add this to the current value
    otherNodesUpdate = 1-pheromoneDecayFactor; % multiply the current value by this

    for i = bestSolution
        for j = 1:nFacilities
            if j == find(bestSolution == i)
                pheromoneMatrix(i,j) = pheromoneMatrix(i,j) + bestNodeUpdate;
            else
                pheromoneMatrix(i,j) = pheromoneMatrix(i,j) * otherNodesUpdate;         
            end
        end
    end; clear i j bestNodeUpdate otherNodesUpdate bestSolution
    
    % --- END GENERATION LOOP --- 
end; clear iters randLocationProbabilities facilitiesXlocations
clear maxIterations nFacilities nIterConvergence nLocations nPopulation pheromoneDecayFactor pheromoneScalingParameter

%%
% --- PLOTTING AND PRINTING OPTIMIZATION RESULTS
fprintf("--- Best Fitness: %d --- \n", histFitnesses(end, 1)) % best=12546
fprintf("-% d ", histFitnesses(end, 3:end)); fprintf("\n");

for i = 1:length(bestSolution)
    fprintf("Facility {%02d=%-30s} -->>-- Location {%02d} \n", i, f_Facilities(i), bestSolution(i))
end; clear i;

figure;
plot(histFitnesses(:, 1), 'b-o', "LineWidth",1.25); title("Historical Best Fitness Values");

figure;
plot(histFitnesses(:, 2), 'r:*', "LineWidth",1); title("Historical Mean Fitness Values");

figure;
printPheromoneWeights(pheromoneMatrix, histFitnesses(end, 3:end));

figure;
visualizeSolution(histFitnesses(end, 3:end), 3);

%% __end__