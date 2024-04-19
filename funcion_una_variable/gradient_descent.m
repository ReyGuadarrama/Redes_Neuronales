function x = gradient_descent(x, df, lr)
    x = x - lr*df;
end