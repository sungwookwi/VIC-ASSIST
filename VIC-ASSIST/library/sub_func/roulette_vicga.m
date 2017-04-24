function parents = roulette_vicga(expectation,nParents)
% Choose parents using roulette wheel.
%   PARENTS = SELECTIONROULETTE(EXPECTATION,NPARENTS,OPTIONS) chooses
%   PARENTS using EXPECTATION and number of parents NPARENTS. On each 
%   of the NPARENTS trials, every parent has a probability of being selected
%   that is proportional to their expectation.
wheel = cumsum(expectation) / nParents;
parents = zeros(1,nParents);
for i = 1:nParents
    r = rand;
    for j = 1:length(wheel)
        if(r < wheel(j))
            parents(i) = j;
            break;
        end
    end
end