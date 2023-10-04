function DC_n2 = derivada_n2(w, x, T)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x));
    for fila = 2:length(w)
        mat_norm(fila, :) = (X(fila,:)-min(X(fila,:))) / (max(X(fila,:)) - min(X(fila,:)));
    end
    DC_n2 = 2 * (hipotesis_n2(w, x) - T) * (mat_norm.');
end