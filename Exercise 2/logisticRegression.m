function theta = logisticRegression(data, alpha)

    theta = rand([3,1]) * 0.02 - 0.01;
    [rows, columns] = size(data);
    vec = ones([rows, 1]);
    
    x_mat = [vec data(:,1:2)];
    y = data(:,3);
    
    threshold = 0.1;
    errorDecrease = 1;
    iteration = 0;
    errors = [];
    
    while(errorDecrease / alpha > threshold)
    
        % compute matrix product of X and Theta 
        % After that we can compute the result of the logistic function
        intermediate = x_mat * theta;
        h = logsig(intermediate); % logsig is the sigmoid function
        diff = (y - h);
        error = diff' * diff;
        update = alpha * diff' * x_mat;
        theta = theta + update';
        
        if iteration > 0
            errorDecrease = ((errors(end) - error)/errors(end));
        end
        iteration = iteration + 1;
        errors = [errors error];
    end
    
    display(['Converged after ' num2str(iteration) ' iterations.'])

end