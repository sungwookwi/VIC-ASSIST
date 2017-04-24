function expectation = rankscaling_vicga(Score,nParents)
% Rank based fitness scaling (single objective only).
%   EXPECTATION = FITSCALINGRANK(SCORES,NPARENTS) calculates the
%   EXPECTATION using the SCORES and number of parents NPARENTS.
%   This relationship can be linear or nonlinear.
[~,i] = sort(Score);
expectation = zeros(size(Score));
expectation(i) = 1./ ((1:length(Score)).^0.5);
expectation = nParents * expectation ./ sum(expectation);