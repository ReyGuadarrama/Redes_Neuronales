function [x, m, v, m_hat, v_hat, gradient_history] = adam_mw2(x, df, m, v, t, lr, beta1, beta2, window_size, gradient_history)
    
    % Añadir el gradiente actual al historial
    gradient_history = [gradient_history, df];
    if length(gradient_history) > window_size
        gradient_history = gradient_history(end-window_size+1:end);
    end
    
    % Calcula m y v utilizando los gradientes de la ventana deslizante
    m = mean(gradient_history);
    v = mean(gradient_history.^2);
    
    % Normalización
    m_hat = m / (1 - beta1^t);
    v_hat = v / (1 - beta2^t);
    
    % Actualización del parámetro
    x = x - lr * m_hat ./ (sqrt(v_hat) + 1e-8);

end