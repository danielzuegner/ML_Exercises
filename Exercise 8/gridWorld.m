gridSize = 4;
n_states = grid_size * grid_size;

values = zeros([gridSize gridSize]);

n_actions = 4;
actions = 1:n_actions;
gamma = 0.9;

%q_values = zeros([gridSize gridSize n_actions]);


policy_stable = false;

while (policy_stable == false)
    values = policy_evaluation( n_states, values_in, gridSize, actions, gamma);
    [policy_stable] = policy_improvement(); % TO DO: Implement policy improvement, chapter 4 slide 11
end


for i=1:iterations
    delta = 0;
    
    for s=1:n_states
        v = values(s);
        
        update = 0;
        action = policySelectAction(s, values, gridSize, actions, gamma);
        next_state_probs = nextStateProbabilities(s, action, gridSize);
        for target_state=1:n_states
            reward = -1;
            if target_state == 1 || target_state == 16
                reward = 0;
            end
            update = update + next_state_probs(target_state) * (reward + gamma*values(target_state));
        end 
        values(s) = update;
        delta = max(delta, abs(v - values(s)));
    end
    if delta < 0.0001
        display(delta);
        break;
    end
end