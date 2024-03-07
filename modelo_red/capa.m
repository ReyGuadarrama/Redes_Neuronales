function capa = capa(input, neuronas, activacion)

    % Selecciona la funcion lineal como activacion por defecto
    if nargin < 3
        activacion = 'lineal'; 
    end

    % Generacion de los pesos para la capa y definicion de la activacion
    capa.w = randn(input, neuronas);
    capa.b = zeros(neuronas, 1);
    capa.a = activacion;

end
    


