function [a, Da_Dz] = activation(z, tipo) 

    % Returns the selected activation function and its derivative

    if strcmp(tipo, 'linear')
        a = z;
        Da_Dz = ones(size(z));

    elseif strcmp(tipo, 'relu')
        a = max(0, z);
        Da_Dz = z > 0;

    elseif strcmp(tipo, 'relu_var1')
        a = max(0, z);
        a = normalize(a);
        Da_Dz = z > 0;

    elseif strcmp(tipo, 'relu_var2')
        a = max(0, z);
        mu = mean(a, 'all');
        sigma = std(a, 0, 'all');
        a = (a - mu) / (sigma + 1e-5);
        Da_Dz = z > 0;

    elseif strcmp(tipo, 'sigmoid')
        a = 1 ./ (1 + exp(-z));
        Da_Dz = a .* (1 - a);

    elseif strcmp(tipo, 'softmax')
        exp_z = exp(z);
        a = exp_z ./ sum(exp_z, 1);
        Da_Dz = a - (a .^2);
   
    elseif strcmp(tipo, 'softmax_var1')
        max_z = max(z);
        exp_z = exp(z - max_z);
        a = exp_z ./ sum(exp_z, 1);
        Da_Dz = a - (a .^2);

    end

end