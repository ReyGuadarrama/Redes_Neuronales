
function C = costo(w, x, T)
    C = sum((hipotesis_n(w, x) - T).^2);
end