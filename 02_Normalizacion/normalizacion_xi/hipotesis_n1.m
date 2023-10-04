% Declaracion de la funcion hipotesis para el metodo de normalizacion 1

function P_norm = hipotesis_n1(w, x)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x)); 

    % Generacion de la matriz normalizada
    for fila = 2:length(w)
        mat_norm(fila, :) = (X(fila,:)-mean(X(fila,:))) / std(X(fila,:));
    end
    
    P_norm = w*mat_norm;
end
