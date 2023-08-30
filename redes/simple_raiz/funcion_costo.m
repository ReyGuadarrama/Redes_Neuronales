% Declaracion de la funcion de costo

function C = funcion_costo(P, T)
    C = sqrt(sum((P - T).^2));
end


