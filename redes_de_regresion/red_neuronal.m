function red = red_neuronal(w, x)
    w_1 = w(1:2, :);
    w_2 = w(3, :);
    capas_ocultas = capa_oculta(w_1, x);
    red = capa_salida(w_2, capas_ocultas);
end
