
function DC = derivada_n1(w, x, T)

    X_n1 = ones(length(x(:, 1)), length(x));

    % Creacion de la matriz de datos normalizada
    for fila = 2:length(x(:, 1))
        X_n1(fila,:) = (x(fila,:) - mean(x(fila,:))) / std(x(fila,:));
    end

    DC = 2 * (hipotesis_n1(w, x) - T) * X_n1.';
end

  