function parents = tournament_vicga(expectation,nParents,tournamentSize)
% Each parent is the best of a random set.
%   PARENTS = SELECTIONTOURNAMENT(EXPECTATION,NPARENTS,OPTIONS,TOURNAMENTSIZE)
%   chooses the PARENTS by selecting the best TOURNAMENTSIZE players out of 
%   NPARENTS with EXPECTATION and then choosing the best individual 
%   out of that set.

% Choose the players
playerlist = ceil(size(expectation,1) * rand(nParents,tournamentSize));
% Play tournament
playerSize = size(playerlist,1);
parents = zeros(1,playerSize);
% For each set of players
for i = 1:playerSize
    players = playerlist(i,:);
    % For each tournament
    winner = players(1); % Assume that the first player is the winner
    for j = 2:length(players) % Winner plays against each other consecutively
        score1 = expectation(winner);
        score2 = expectation(players(j));
        if score2 > score1
            winner = players(j);
        end
    end
    parents(i) = winner;  % champions
end