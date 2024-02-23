function pred = predictor(x, modelo_entrenado)

    % Extrae los paramatros del modelo entrenado
    n_capas = size(modelo_entrenado.w, 2);
    
    capas = cell(1, n_capas);
    w = modelo_entrenado.w;
    b = modelo_entrenado.b;
    a = modelo_entrenado.a;
    
    for capa = 1:n_capas
        cap.w = w{capa};
        cap.b = b{capa};
        cap.a = a{capa};
        capas{capa} = cap;
    end
    
    % Creacion de una celda para almacenar los valores de las neuronas y
    % sus activaciones
    P = cell(2,numel(capas));

    % Inicializacion de valores para la capa de entrada de la red
    P{1, 1} = x;
    P{2, 1} = activacion(x, 'lineal');

    % Itera sobre cada una de las capas creadas
    for i = 1:numel(capas)
        % Calcula las salidas de cada neurona en la capa i+1
        z = neurona(capas{i}.w, P{2,i}, capas{i}.b);

        % Calcula las salidas de cada activacion en la capa i+1
        a = activacion(z, capas{i}.a);

        % Guarda los valores de las salidas de neuronas y activaciones de
        % la capa i + 1
        P{1, i+1} = z;
        P{2, i+1} = a;
    end

    pred = P{end, end};

end