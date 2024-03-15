function [C, DC_DP] = cost(P, T, tipo)
    
    % Get the number of samples
    n_samples = size(P, 2);

    % Performs the loss function selected
    if strcmp(tipo, 'mean squared error')

        % Mean squared error
        C = sum((P - T).^2, 'all') / n_samples;
    elseif strcmp(tipo, 'binary cross entropy')

        % Binary cross entropy
        C = -sum(T .* log(P) + (1 - T) .* log(1 - P), 'all') / n_samples;
    elseif strcmp(tipo, 'cross entropy')
        
        % Cross entropy
        C = -sum(T .* log(P), 'all') / n_samples;
    else
        error('Unsupported loss function type');
    end

    % Compute derivative of the loss function with respect to predicted values
    DC_DP = (P - T) / n_samples;

end