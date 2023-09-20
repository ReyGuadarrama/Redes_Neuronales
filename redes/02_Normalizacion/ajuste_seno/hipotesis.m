% Declaracion de la funcion hipotesis
% w : vector de coeficientes del polinomio
% x : vector de valores para x
% La funcion crea un vector P donde el i-esimo elemento es el valor del
% polinomio de grado N evaluado en el i-esimo elemento del vector x 

function P = hipotesis(w, x)
    p = 0:length(w) - 1;
    X = repmat(x, length(w), 1).^(p.');
    WX = X.*(w.');
    P = w*X;
end