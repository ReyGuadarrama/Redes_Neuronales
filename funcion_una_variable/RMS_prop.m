function [x, v] = RMS_prop(x, df, lr, v, gama)
    v = gama*v + (1 - gama)*df.^2;
    x = x - (1 ./ sqrt(v + 1e-8)*lr) .* df ;
end