  % Definicion de la funcion de normalizacion

function x_norm = normalizacion(x)
   x_norm = (x - min(x))/(max(x)-min(x));
end