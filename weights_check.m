% Check whether the weights sum to 1
WeightSum = W1D1 + W2D1;

% Calculate deviation from 1
Error = abs(WeightSum - 1);

fprintf('Minimum weight sum = %.10f\n', min(WeightSum(:)));
fprintf('Maximum weight sum = %.10f\n', max(WeightSum(:)));
fprintf('Mean weight sum    = %.10f\n', mean(WeightSum(:)));
fprintf('Maximum error      = %.10e\n', max(Error(:)));

% Check normalization
if max(Error(:)) < 1e-6
    disp('The weights are normalized. Equation (21) is satisfied.');
else
    disp('The weights are NOT normalized. Equation (21) is not satisfied.');
end