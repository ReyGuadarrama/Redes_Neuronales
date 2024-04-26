function [x, v] = adaptative_gradient(x, df, lr, v)
    v =  v + df.^2;
    x = x - (1 ./ sqrt(v + 1e-8)*lr) .* df ;
end