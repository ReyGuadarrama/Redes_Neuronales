% Declaracion de la funcion de costo

function C = funcion_costo(w, x, T)
    P = hipotesis(w, x);
    C = sum((P - T).^2)/length(x) - 100 * cos(4*w) + 100;
end


