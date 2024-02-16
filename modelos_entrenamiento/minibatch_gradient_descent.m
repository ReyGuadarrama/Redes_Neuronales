function [w, C] = minibatch_gradient_descent(w, x, t, alpha, epocas, batch_size)

    C = zeros(1, epocas);
    iteraciones = floor(length(x)/batch_size);

    % Mini-Batch Gradient Descent
    
    for epoca = 1:epocas

        % Revuelve las muestras
        indices_revueltos = randperm(length(x));
        
        for iteracion = 1:iteraciones

            batch_indices = indices_revueltos(:,batch_size * (iteracion - 1) + 1:batch_size * iteracion);
            
            batch = x(:,batch_indices);
            etiquetas = t(:,batch_indices);
            w = w - alpha*derivada(w, batch, etiquetas);

        end

        % Actualizacion de parametros
        C(epoca) = costo(w, x, t);
        
    end

end