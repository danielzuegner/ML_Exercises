alphas = [0.001 0.005 0.01 0.05 0.1];
iterations = [39426 7850 3904 753 362];
figure
plot(alphas,iterations);
title('Iterations to convergence for varying alpha values');
xlabel('alpha');
ylabel('iterations to convergence');


figure
residualError = [1.8831 1.9011 1.9229 2.0732 2.2386];
plot(alphas, residualError);
title('Residual square errors for varying alpha values');
xlabel('alpha');
ylabel('residual square error');