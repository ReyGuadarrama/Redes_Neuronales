function [x, v, delta_x] = ada_delta(x, df, v, gama, delta_x)
    v = gama * v + (1 - gama) * df.^2;
    update = (sqrt(delta_x  + 1e-8) ./ sqrt(v + 1e-8))  .* df;
    delta_x = gama * delta_x + (1 - gama) * update.^2;
    x = x - update;  
end
