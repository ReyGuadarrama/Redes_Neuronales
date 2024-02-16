function L = recta_dos_puntos(f, x, x0, x1)
    L = ((f(x1) - f(x0)) / (x1 - x0))*(x - x0) + f(x0);
end
