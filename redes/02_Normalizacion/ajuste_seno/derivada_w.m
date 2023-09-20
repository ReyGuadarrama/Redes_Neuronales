% Declaracion de la derivada de la funcion de costo
% w : vector de coeficientes del polinomio
% x : vector de valores para x
% La funcion crea un vector cuyo i-esimo t-ermino es la derivada con
% respecto a wi de la funcion de costo

function DC_w = derivada_w(w, x, T);
    p = 0:length(w) - 1;
    DP = repmat(x, length(w), 1).^(p.');
    DC_w = 2 * (hipotesis(w, x) - T) * (DP.');
end
