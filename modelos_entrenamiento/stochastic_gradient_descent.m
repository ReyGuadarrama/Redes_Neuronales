function [w, C] = stochastic_gradient_descent(w, x, t, alpha, epocas)

    C = zeros(1, epocas);

    % Stochastic Gradient Descent

    for epoca = 1:epocas

        % Revuelve las muestras
        indices_revueltos = randperm(length(x));
    
        for muestra = 1:length(x)

        muestra_aleatoria = x(:,indices_revueltos(muestra));
        etiqueta = t(:,indices_revueltos(muestra));

        % Actualizacion de parametros
        w = w - alpha*derivada(w, muestra_aleatoria, etiqueta);

        end
        
        C(epoca) = costo(w, x, t);
        
    
    end

end