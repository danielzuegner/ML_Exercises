function [ optimalActions, rewards] = nArmedBandit1( n, plays, epsilon )
%NARMEDBANDIT1 Summary of this function goes here
%   Detailed explanation goes here

means = zeros([n 1]);
for i=1:n
    means(i) = mvnrnd(0, 1, 1);
end
[argvalue, optimalAction] = max(means);
meanRewards = zeros([10 1]);
rewards = zeros([0 1]);
chosenActions = zeros([0 1]);
optimalActions = zeros([0 1]);

for i=1:plays
   r = rand(1);
   if r <= epsilon
       action = round(rand(1)*(n-1)) + 1;
   else
       [argvalue, action] = max(meanRewards);
   end
   nChosen = sum(chosenActions == action);
   chosenActions = [chosenActions; action];
   optimalActions = [optimalActions; action == optimalAction];
   reward = mvnrnd(means(action),1,1);
   rewards = [rewards; reward];
   meanRewards(action) = ( nChosen * meanRewards(action) + reward)/(nChosen + 1);    
end
end

