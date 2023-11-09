function N = normalizacion(x, tipo)
    if tipo == "rango"
        maximos = max(x, [], 2);
        minimos = min(x, [], 2);
        rango = maximos - minimos;
        unit = (x - minimos) ./ rango;
        N = (unit - 0.5) * 2;
    end
end