function theta =  stochasticGradientDescent (data, polynomial, alpha)
    display(['Polynomial: ' num2str(polynomial) ' Alpha: ' num2str(alpha)]);

    % initialize
    theta = rand(1,polynomial + 1);
    exponents = [0:polynomial];
    
    [rows, columns] = size(data);
    threshold = 0.01;
    update = ones(1,polynomial + 1);
    errors = [];
    
    iteration = 0;
    allUpdates = ones(1,polynomial + 1);
    errorDecrease = 1;
    while (errorDecrease / alpha > threshold)
        error = 0;
        allUpdates = zeros(1,polynomial + 1);
        for j = 1:rows
            element = data(j,:);
            x = element(1);
            y = element(2);
            xnew = x.^exponents;
           
            
            h = xnew * theta';
            error = error + (h - y).^2;
             
            update = alpha * (y - h) * xnew;
            allUpdates = allUpdates + update;
            theta = theta + update;

        end
        if iteration > 0
            errorDecrease = ((errors(end) - error)/errors(end));
        end
        iteration = iteration + 1;
        errors = [errors error];
    end
    figure
    plot([1: iteration], errors);
    title('Error values');
    xlabel('iteration');
    ylabel('square error');
    display(['Converged after ' num2str(iteration) ' iterations.']);
    display(['Resulting theta: ' mat2str(theta)]);
    display(['Summed residual square error: ' num2str(errors(end))]); 

end