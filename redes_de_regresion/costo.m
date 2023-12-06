function C = costo(w, x, T)
    
    % obtiene el n[umero de muestras
    n_muestras = size(x, 2);

    % Funcion de costo promedio cuadratico
    C = sum((red(w, x) - T).^2) ./ n_muestras;
end