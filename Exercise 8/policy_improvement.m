function [ policy, stable ] = policy_improvement( n_states, values, gridSize, actions, policy_in, gamma )
%POLICY_IMPROVEMENT Summary of this function goes here
%   Detailed explanation goes here

    stable = true;
    policy = policy_in;
    
    for s=1:n_states
        b = policy_in(s);
        policy(s) = policySelectAction(s, values, gridSize, actions, gamma );
        if policy(s) ~= b
            stable = false;
        end
    end
    if stable ~= 1
        display('not stable.');
    else
        display('stable.');
    end
end

