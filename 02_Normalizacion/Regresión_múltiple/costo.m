function C = costo(w, x, T)
    C = ((hipotesis(w, x) - T).^2) * ones(length(x), 1);
end