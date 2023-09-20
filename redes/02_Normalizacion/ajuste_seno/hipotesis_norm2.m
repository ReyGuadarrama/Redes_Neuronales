

function P_norm2 = hipotesis_norm2(w, x)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    WX = X.*(w.');
    desviaciones = ones(length(w), 1);
    promedios = ones(length(w), 1);
    for fila = 2:length(w)
        promedios(fila) = mean(WX(fila, :));
        desviaciones(fila) = std(WX(fila,:));
    end
    mat_norm = (WX-promedios)./desviaciones;
    P_norm2 = ones(1, length(w)) * mat_norm;
end