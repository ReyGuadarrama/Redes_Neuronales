function P = hipotesis_n1(w, x)
    
    X_n1 = ones(length(x(:, 1)), length(x));

    % Creacion de la matriz de datos normalizada
    for fila = 2:length(x(:, 1))
        X_n1(fila,:) = (x(fila,:) - mean(x(fila,:))) / std(x(fila,:));
    end

    % Calculo de polinomio
    P = w * X_n1;
end