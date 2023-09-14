  % Declaracion de la derivada de la funcion de costo respecto a w2

function DC_w2 = costo_derivada_w2(w_0, w_1, w_2, x_0, x_1, T)
    DC_w2 = 2 * sum((w_0*x_0 + w_1*x_1 + w_2*(x_1.^2) - T) .* (x_1.^2));
end

