function DC_w_norm2 = derivada_w_norm2(w, x, T)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    WX = X.*(w.');
    promedios_xk = ones(length(w), 1);
    desviaciones_k = ones(length(w), 1);
    promedios_k = ones(length(w), 1);
    Wk_Xk_norm = ones(length(w), 1);
 
    for fila = 2:length(w)
        promedios_xk(fila) = mean(X(fila, :));
        desviaciones_k(fila) = std(WX(fila,:));
        promedios_k(fila) = mean(WX(fila,:));
    end

    mat_norm = (WX-promedios_k)./desviaciones_k;

    for fila = 2:length(w)
        Wk_Xk_norm(fila) = mean(mat_norm(fila, :).^2);
    end

    DC_w_norm2 = 2 * (hipotesis_norm2(w, x) - T)*((((X - promedios_xk)./ desviaciones_k).*(1-Wk_Xk_norm)).');
    DC_w_norm2(1,1) = 1;
end   