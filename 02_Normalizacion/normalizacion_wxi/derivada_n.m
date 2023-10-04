function derivada_n(w, x, T)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x));
    norm_prom_cuadrado = ones(1, length(w));
    for fila = 2:length(w)
        promedio_fila = mean(X(fila, :));
        desviacion_fila = std(X(fila,:));
        mat_norm(fila,:) = (X(fila,:) - promedio_fila) / desviacion_fila;
        norm_prom_cuadrado(:,fila) = mean(mat_norm(fila,:).^2);
    end
    
    DP_DW = ones(1, length(w)) - norm_prom_cuadrado;

end