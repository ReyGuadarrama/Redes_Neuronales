  % Declaracion de la derivada de la funcion de costo respecto a w1

function DC_w1 = costo_derivada_w1(w_0, w_1, x_0, x_1, T)
    DC_w1 = 2 * sum((w_0*x_0 + w_1*x_1 - T) .* x_1);
end
