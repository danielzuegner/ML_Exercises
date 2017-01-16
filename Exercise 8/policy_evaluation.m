function [ values ] = policy_evaluation( n_states, values_in, gridSize, actions, gamma)
%POLICY_EVALUATION Summary of this function goes here
%   Detailed explanation goes here

    delta = 0;
    values = values_in;
    
    for s=1:n_states
        v = values(s);
        
        update = 0;
        action = policySelectAction(s, values, gridSize, actions, gamma);
        next_state_probs = nextStateProbabilities(s, action, gridSize); % TO DO: keep policy fixed during evaluation step, compare with chapter 4 slide 11
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

