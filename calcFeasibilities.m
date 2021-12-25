function calcFeasibilities(solutionsMatrix, verbose)
% Check the feasibility of the provided solutions i.e. no facility is assigned to two locations and vice-versa.
% The number of unique values in each solution must be equal to the number of
% values in the solution, meaning that there are no repetitions a-la permutation problems.

[nPopulation, nVariables] = size(solutionsMatrix);

nUniques = zeros(1, nPopulation);
for i = 1:nPopulation
    nUniques(i) = length(unique(solutionsMatrix(i,:)));
end

feasibilityCheck = nUniques == nVariables;
if sum(feasibilityCheck) ~= nPopulation
    error("There are INVALID solutions in the population!")
else
    if verbose
        disp("All solutions in the population are VALID!")
    end
end
end

