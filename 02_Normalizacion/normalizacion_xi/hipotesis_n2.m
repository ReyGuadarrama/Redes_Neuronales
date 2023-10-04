function P_norm = hipotesis_n2(w, x)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    mat_norm = ones(length(w), length(x));
    for fila = 2:length(w)
        mat_norm(fila, :) = (X(fila,:)-min(X(fila,:))) / (max(X(fila,:)) - min(X(fila,:)));
    end
    P_norm = w*mat_norm;
end
