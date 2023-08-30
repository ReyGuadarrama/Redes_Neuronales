% Declaracion de la funcion de costo

function C = funcion_costo(P, T)
    C = sum((P - T).^2);
end


