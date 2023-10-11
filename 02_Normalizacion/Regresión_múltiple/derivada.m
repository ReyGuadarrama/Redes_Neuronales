function DC = derivada(w, x, T)
    DC = 2 * (hipotesis(w, x) - T) * x.';
end