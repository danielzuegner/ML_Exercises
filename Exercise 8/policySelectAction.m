function [ action ] = policySelectAction( state, values, gridSize, actions, gamma )
    
    action_values = zeros(size(actions));
    for target_state=1:(gridSize*gridSize)
        reward = -1;
        if target_state == 1 || target_state == 16 % terminal state
            reward = 0;
        end
        for a=1:actions %iterate over actions
            %get probability of target_state given action
            % will be zero or one in this example
            state_probabilities = nextStateProbabilities(state, a, gridSize);
            % update action value based on reward and value of target_state
            actions_values(a) = action_values(a) + state_probabilities(target_state) * (reward + gamma*values(target_state));
        end
    end
    [val, best_action] = max(action_values); % select best action
    action = best_action; %return

end

