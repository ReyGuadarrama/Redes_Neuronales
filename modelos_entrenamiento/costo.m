function C = costo(w, x, T)
    P = hipotesis(w, x);
    C = -sum(T.*log(P) + (1 - T).*log(1 - P));
end
