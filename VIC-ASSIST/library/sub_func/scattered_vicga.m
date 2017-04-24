function xoverKids = scattered_vicga(thisPopulation,parents,nXoverKids,Npar,Nhru,lumpar_ind,clustind)
% Position independent crossover function.
%   This creates the crossover children XOVERKIDS of the given population
%   THISPOPULATION using the available PARENTS. In single or double point
%   crossover, genomes that are near each other tend to survive together,
%   whereas genomes that are far apart tend to be separated. The technique
%   used here eliminates that effect. Each gene has an equal chance of
%   coming from either parent. This is sometimes called uniform or random
%   crossover.

parents_crossover = parents(1:(2*nXoverKids));
% How many children to produce?
nKids = nXoverKids;
% Allocate space for the kids
GenomeLength = Npar * Nhru;
xoverKids    = zeros(GenomeLength,nKids);

uniqclustind = unique(clustind);

% To move through the parents twice as fast as thekids are
% being produced, a separate index for the parents is needed
index = 1;
% for each kid...
for i=1:nKids
    % get parents
    r1 = parents_crossover(index);
    index = index + 1;
    r2 = parents_crossover(index);
    index = index + 1;
    
    % Randomly select half of the genes from each parent
    % This loop may seem like brute force, but it is twice as fast as the
    % vectorized version, because it does no allocation.
    population1 = reshape(thisPopulation(:,r1),Nhru,Npar);
    population2 = reshape(thisPopulation(:,r2),Nhru,Npar);
    
    Kid = nan(Nhru,Npar);
    for j = 1:Npar
        if lumpar_ind(j) == 1
            if rand > 0.5
                Kid(:,j) = population1(1,j);
            else
                Kid(:,j) = population2(1,j);
            end
                     
        elseif lumpar_ind(j) == 0
            for n = 1:length(uniqclustind)
                selclust = clustind == uniqclustind(n);
                if rand > 0.5
                    Kid(selclust,j) = population1(selclust,j);
                else
                    Kid(selclust,j) = population2(selclust,j);
                end 
            end 
        end
    end
    
    xoverKids(:,i) = Kid(:);
    
end