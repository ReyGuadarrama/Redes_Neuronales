% Declaracion de la derivada de la funcion de costo respecto a w0

function DC_w0 = costo_derivada_w0(w, x, T)
    DC_w0 = 2 * sum((w*x - T).*x)/length(x) + 400 * sin(4*w);
end
    