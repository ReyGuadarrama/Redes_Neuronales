function P_norm = hipotesis_n(w, x)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x));

    for fila = 2:length(w)
        promedio_fila = mean(X(fila, :));
        desviacion_fila = std(X(fila,:));
        mat_norm(fila,:) = (X(fila,:) - promedio_fila) / desviacion_fila;
    end
   
    P_norm = w * mat_norm;
end