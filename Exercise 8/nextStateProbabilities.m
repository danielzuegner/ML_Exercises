function [ probs ] = nextStateProbabilities( state, action, gridSize )

    % which row in the state space are we in?
    state_row = ceil(state / gridSize); 
    state_col = mod(state, gridSize) + 1;
    
    probs = zeros([gridSize gridSize]);
    
    switch(action)
        case 1 % move north
            if state_row == 1 % we are in the first row and cannot move north, hence we stay in our state
                probs(state) = 1;
            else
                % we move one row north
                probs(state_row - 1, state_col) = 1;
            end
        case 2 %move east
            if state_col == grid_size %cannot move east
                probs(state) = 1;
            else % move one col to the right
                probs(state_row, state_col + 1) = 1;
            end
        case 3 % move south
            if state_row == grid_size %cannot move south
               probs(state) = 1; 
            else % move one row below
                probs(state_row + 1, state_col) = 1;
            end
        case 4 % move west
            if state_col == 1 % cannot move west
               probs(state) = 1;
            else
                probs(state_row, state_col - 1) = 1;
            end
    end
    

end

