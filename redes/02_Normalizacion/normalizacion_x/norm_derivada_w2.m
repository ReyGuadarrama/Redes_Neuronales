% Declaracion de la derivada normalizada con respecto a w2

function norm_DC_w2 = norm_derivada_w2(w_0, w_1, w_2, x_0, x_1, T)
    norm_DC_w2 = 2 * sum((w_0*x_0 + w_1*x_1 + w_2*(x_1.^2) - T) .* normalizacion(x_1.^2));
end