function DC_w_norm = derivada_w_norm(w, x, T)
    p = 0:length(w) - 1;
    Z = repmat(x, length(w), 1).^(p.');
    X = ones(length(w), length(x));
    for fila = 2:length(w)
        X(fila, :) = (Z(fila,:)-mean(Z(fila,:))) / std(Z(fila,:));
    end
    DC_w_norm = 2 * (hipotesis_norm(w, x) - T) * (X.');
end