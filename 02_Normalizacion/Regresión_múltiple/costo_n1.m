
function C = costo_n1(w, x, T)
    C = ((hipotesis_n1(w, x) - T).^2) * ones(length(x), 1);
end
    