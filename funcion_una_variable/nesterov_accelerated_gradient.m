function [x, m] = nesterov_accelerated_gradient(x, lr, gama, m)
    x = x - gama*m;
    [~, df] = fun(x);
    m = gama*m + lr*df;
    x = x - m;
end