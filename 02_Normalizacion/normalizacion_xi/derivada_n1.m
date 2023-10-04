% Declaracion de la derivada del costo

function DC_n1 = derivada_n1(w, x, T)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x));

    % Generacion de la matriz normalizada
    for fila = 2:length(w)
        mat_norm(fila, :) = (X(fila,:)-mean(X(fila,:))) / std(X(fila,:));
    end
    DC_n1 = 2 * (hipotesis_n1(w, x) - T) * (mat_norm.');
end 