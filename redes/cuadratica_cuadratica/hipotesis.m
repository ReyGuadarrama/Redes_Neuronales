% definicion de la hipotesis

function P = hipotesis(w_0, w_1, w_2, x_0, x_1)
    P = w_0*x_0 + w_1*x_1 + w_2*(x_1.^2);
end