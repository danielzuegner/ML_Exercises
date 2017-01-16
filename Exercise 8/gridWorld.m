gridSize = 4;
n_states = gridSize * gridSize;

values = zeros([gridSize gridSize]);

n_actions = 4;
actions = 1:n_actions;
gamma = 1;
policy = ceil(rand([gridSize gridSize]) * n_actions); % initialize policy with random actions
policy_stable = false;

while (policy_stable == false)
    values = policy_evaluation( n_states, values, gridSize, actions, policy, gamma);
    [policy, policy_stable] = policy_improvement(n_states, values, gridSize, actions, policy, gamma); 
end
display(policy);