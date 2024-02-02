function [w, C] = stochastic_gradient_descent(w, x, t, alpha, iteraciones)

    C = zeros(1, iteraciones);

    % Stochastic Gradient Descent

    for iteracion = 1:iteraciones
    
        n = randi(length(x));
        muestra_aleatoria = x(:,n);
        etiqueta = t(:,n);
    
        % Actualizacion de parametros
        C(iteracion) = costo(w, x, t);
        w = w - alpha*derivada(w, muestra_aleatoria, etiqueta);
    
    end

end