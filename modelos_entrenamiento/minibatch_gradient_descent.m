function [w, C] = minibatch_gradient_descent(w, x, t, alpha, iteraciones, batch_size)

    C = zeros(1, iteraciones);

    % Mini-Batch Gradient Descent
    
    for iteracion = 1:iteraciones
    
        n = randperm(length(x), batch_size);
        batch = x(:,n);
        etiquetas = t(:,n);
    
        % Actualizacion de parametros
        C(iteracion) = costo(w, x, t);
        w = w - alpha*derivada(w, batch, etiquetas);
    
    end

end