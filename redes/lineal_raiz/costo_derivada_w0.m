% Declaracion de la derivada de la funcion de costo respecto a w0

function DC_w0 = costo_derivada_w0(w_0, w_1, x_0, x_1, T)
    DC_w0 = (sum(w_0*x_0 + w_1*x_1 - T)) / sqrt(sum((w_0*x_0 + w_1*x_1 - T).^2));
end
    