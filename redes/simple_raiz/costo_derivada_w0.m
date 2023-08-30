% Declaracion de la derivada de la funcion de costo respecto a w0

function DC_w0 = costo_derivada_w0(w_0, x_0, T)
    DC_w0 = (sum((w_0*x_0 - T).*x_0)) / sqrt(sum((w_0*x_0 - T).^2));
end
    