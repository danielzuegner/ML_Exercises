function [ values ] = policy_evaluation( n_states, values_in, gridSize, actions, policy, gamma)
%POLICY_EVALUATION Summary of this function goes here
%   Detailed explanation goes here

   % values = values_in;
    values_new = values_in;
    n_actions = size(actions,2);
    while(1)
        delta = 0;
        values = values_new;
        for s=1:n_states
            v = values(s);

            update = 0;
            action = policy(s); % choose action from policy at state s
            
            next_state_probs = nextStateProbabilities(s, action, gridSize); % TO DO: keep policy fixed during evaluation step, compare with chapter 4 slide 11
            for target_state=1:n_states
                reward = -1;
                if s == 1 || s == 16
                    reward = 0;
                end
                update = update + next_state_probs(target_state) * (reward + gamma*values(target_state));
            end 
            values_new(s) = update;
            delta = max(delta, abs(v - values(s)));
            %display([v values(s)]);
        end
        if delta < 0.0001
            break;
        else
           % display(delta);
        end
    end
    values = values_new;
end

