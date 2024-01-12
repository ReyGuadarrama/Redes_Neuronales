function Modelo = modelo(x, capas) 

    % Crea las celdas para almacenar los valores de los pesos y bias
    w = cell(1,numel(capas));
    b = cell(1,numel(capas));
    a = cell(1,numel(capas));

    % Guarda los pesos, bias y activaciones de cada capa en celdas
    for i = 1:numel(capas)
        w{i} = capas{i}.w;
        b{i} = capas{i}.b;
        a{i} = capas{i}.a;
    end

    % Realiza el calculo hacia delante de la red
    P = predictor(x, capas);

    % Almacena las celdas con datos dentro de una estructura
    Modelo.w = w; 
    Modelo.b = b; 
    Modelo.a = a; 
    Modelo.P = P; 

end
