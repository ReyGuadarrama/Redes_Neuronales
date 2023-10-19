function P = hipotesis(w, x)
    P = 1 ./ (1 + exp(-(w*x)));
end