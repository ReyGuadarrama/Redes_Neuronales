function out = capa_oculta(w, x)

    % Calcula el valor del polinomio para cada una de las neuronas
    P = w.' * x;
    
    % Aplica una funcion de activacion al polinomio de cada neurona
    out = relu(P);
end
    