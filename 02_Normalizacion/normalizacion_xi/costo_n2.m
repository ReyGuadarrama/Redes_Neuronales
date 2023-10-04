% Declaracion de la funcion de costo (diferencia al cuadrado)
% P : funcion de hipotesis
% T : vector de valores objetivo
% La funcion de costo devuelve la suma de los cuadrados de las diferencias
% entre la funcion hipotesis P y los valores objetivo T

function C = costo_n2(w, x, T)
    C = sum((hipotesis_n2(w, x) - T).^2);
end
