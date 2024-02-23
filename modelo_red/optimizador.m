function [w, v] = optimizador(tipo, alpha, gamma, gradiente, w, v)

    % ejecuta el tipo de algoritmo de actualizacion seleccionado
    if strcmp(tipo, 'GD')
        [w, v] = gradient_descent(alpha, gradiente, w);
    elseif strcmp(tipo, 'NAG')
        [w, v] = nesterov_accelerated_gradient(alpha, gamma, gradiente, w, v);
    end
end

% Algoritmo gradiente descendete convencional
function [w, v] = gradient_descent(alpha, gradiente, w)
    v = 0;
    w = w - alpha * gradiente;
end

% Algoritmo Nestervov Accelerated Gradient
function [w, v] = nesterov_accelerated_gradient(alpha, gamma, gradiente, w, v)
    v = gamma * v + alpha*gradiente .* (w - gamma*v);
    w = w - v;
end