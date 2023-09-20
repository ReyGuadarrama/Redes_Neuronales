function P_norm = hipotesis_norm(w, x)
    p = 0:length(w) - 1;
    Z = repmat(x, length(w), 1).^(p.');
    X = ones(length(w), length(x));
    for fila = 2:length(w)
        X(fila, :) = (Z(fila,:)-mean(Z(fila,:))) / std(Z(fila,:));
    end
    P_norm = w*X;
end