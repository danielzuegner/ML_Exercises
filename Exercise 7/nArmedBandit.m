nMachines = 2000;

epsilons = [0 0.01 0.1 0.5 1];
%epsilons = [1 0.1];
n = 10;
plays = 1000;

optimalActionMatrix = zeros([plays nMachines]);
rewardsMatrix       = zeros([plays nMachines]);

%epsilonMeansOptimalActions = zeros([1000 0]);
%epsilonMeansMeanRewards = zeros([1000 0]);

figOA = figure();
figMR = figure();

for epsilon = epsilons
    display(epsilon);
    for i = 1:nMachines
        if mod(i, 1000) == 0
            display(i);
        end
        [ optimalActions, rewards] = nArmedBandit1( n, plays, epsilon );
        optimalActionMatrix(:,i) = optimalActions;
        rewardsMatrix(:,i) = rewards;
    end
    figure(figOA);
    optimalActionMeans = mean(optimalActionMatrix, 2);
    plot(optimalActionMeans)
    hold on
    
    figure(figMR);
    rewardMeans = mean(rewardsMatrix, 2);
    plot(rewardMeans)
    hold on
    
    
    %epsilonMeansOptimalActions = [epsilonMeansOptimalActions optimalActionMeans];
    %epsilonMeansMeanRewards = [epsilonMeansMeanRewards optimalActionMeans];
end

figure(figOA);
legend(num2str(epsilons'), 'Location', 'northwest');
xlabel('Plays');
ylabel('% Optimal action');
hold off

figure(figMR);
legend(num2str(epsilons'), 'Location', 'northwest');
xlabel('Plays');
ylabel('Average reward');
hold off


