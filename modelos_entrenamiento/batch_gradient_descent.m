function [w, C] = batch_gradient_descent(w, x, t, alpha, epocas)

    C = zeros(1, epocas);

    % Bach Gradient Descent

    for epoca = 1:epocas
    
        % Actualizacion de parametros
        w = w - alpha*derivada(w, x, t);
    
        % Calculo del costo
        C(epoca) = costo(w, x, t);
    end

end