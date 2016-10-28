function theta =  stochasticGradientDescent (data, polynomial, alpha)

    % initialize
    theta = rand(1,polynomial + 1);
    exponents = [0:polynomial];
    
    [rows, columns] = size(data);
    threshold = 0.0005;
    update = ones(1,polynomial + 1);
    errors = [];
    
    iteration = 0;
    allUpdates = ones(1,polynomial + 1);
    while (max(abs(allUpdates)) > threshold)
        meanError = 0;
        allUpdates = zeros(1,polynomial + 1);
        for j = 1:rows
            element = data(j,:);
            x = element(1);
            y = element(2);
            xnew = x.^exponents;
           
            
            h = xnew * theta';
            meanError = meanError + (h - y).^2;
             
            update = alpha * (y - h) * xnew;
            allUpdates = allUpdates + update;
            theta = theta + update;

        end
        meanError = meanError / rows;
        display(allUpdates);
        iteration = iteration + 1;
        errors = [errors meanError];
    end
    figure
    scatter([1: iteration], errors)

end