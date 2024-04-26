function [x, m] = gradient_descent_momentum(x, df, lr, gama, m)
    m = gama*m + lr*df;
    x = x - m;
end