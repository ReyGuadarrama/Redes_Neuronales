function [w, C] = batch_gradient_descent(w, x, t, alpha, iteraciones)

    C = zeros(1, iteraciones);

    % Bach Gradient Descent

    for iteracion = 1:iteraciones
    
        % Actualizacion de parametros
        w = w - alpha*derivada(w, x, t);
    
        % Calculo del costo
        C(iteracion) = costo(w, x, t);
    end

end