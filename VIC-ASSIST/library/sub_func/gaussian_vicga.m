function mutateKids = gaussian_vicga(parents,thisPopulation,generation,GenNum,...
    nMutateKids,scale,shrink,par_lb,par_ub,Npar,Nhru,lumpar_ind,clustind)
% Gaussian mutation.
%   Creates the mutated children using the Gaussian distribution.
%
%   SCALE controls what fraction of the gene's range is searched. A value
%   of 0 will result in no change, a SCALE of 1 will result in a
%   distribution whose standard deviation is equal to the range of this
%   gene. Intermediate values will produce ranges in between these
%   extremes.
%
%   SHRINK controls how fast the SCALE is reduced as generations go by. A
%   SHRINK value of 0 will result in no shrinkage, yielding a constant
%   search size. A value of 1 will result in SCALE shrinking linearly to 0
%   as GA progresses to the number of generations specified by the options
%   structure. (See 'Generations' in GAOPTIMSET for more details).
%   Intermediate values of SHRINK will produce shrinkage between these
%   extremes. Note: SHRINK may be outside the interval (0,1), but this is
%   ill-advised

par_range       = par_ub - par_lb;
scale           = scale - shrink * scale * generation / GenNum;
scaled_parrange = scale * par_range;
uniqueclustind  = unique(clustind);
clustnum        = length(uniqueclustind);

parents_mutation = parents(end-nMutateKids+1:end);
mutateKids       = zeros(Npar * Nhru,length(parents_mutation));
for i=1:length(parents_mutation)
    mutateparent = thisPopulation(:,parents_mutation(i));
    mutateparent = reshape(mutateparent,Nhru,Npar);
    
    kid = zeros(Nhru,Npar);
    for j=1:Npar
        if lumpar_ind(j) == 1
            kid(:,j) = mutateparent(:,j) + scaled_parrange(j)*randn;
 
        elseif lumpar_ind(j) == 0
            for k = 1:clustnum
                selclust = uniqueclustind(k);
                selindex = clustind == selclust;
                kid(selindex,j) = mutateparent(selindex,j) + scaled_parrange(j)*randn;
            end
        end
    end
                
    mutkid = kid(:);
    
    % Bound check
    LB = repmat(par_lb,Nhru,1); LB = LB(:);
    UB = repmat(par_ub,Nhru,1); UB = UB(:);
    lbound   = mutkid-LB >= 0;
    ubound   = mutkid-UB <= 0;
    feasible = all(lbound) && all(ubound);
    if ~feasible
        mutkid(~lbound) = LB(~lbound);
        mutkid(~ubound) = UB(~ubound);
    end
    mutateKids(:,i) = mutkid;
end
