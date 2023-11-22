function C = costo(w, x, T)
    n_muestras = length(x(1,:));
    
    C = sum(((red_neuronal(w, x) - T).^2)/n_muestras);
end
