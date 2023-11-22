function dC_dw = derivada(w, x, T)
    n_muestras = length(x(1,:));
    w1 = w(1:2, :);
    w2 = w(3, :);
    dC_dP1 = x * (red_neuronal(w, x) - T).';
    dC_dw = [dC_dP1 .* w2; (red_neuronal(w, x) - T) * capa_oculta(w1, x).'] .* 2/n_muestras;
end