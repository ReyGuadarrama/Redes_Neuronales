function E = entrenamiento_test(x, T, model, varargin)

    % Valores predeterminados
    alpha = 0.1;
    batch_size = length(x);
    update = 'GD';
    train = 'SGD';

    % Analiza los argumentos de entrada
    for i = 1:2:length(varargin)
        switch varargin{i}
            case 'epochs'
                epocas = varargin{i+1};
            case 'learningRate'
                alpha = varargin{i+1};
            case 'lossFunction'
                loss = varargin{i+1};
            case 'trainAlgorithm'
                train = varargin{i+1};
            case 'batch_size'
                batch_size = varargin{i+1};
            case 'optimizer'
                update = varargin{i+1};
        end
    end
    
    % Inicializa un vector para almacenar el valor de la funcion de costo en cada epoca
    valor_costo = zeros(1, epocas);

    for epoca = 1:epocas

        valor_costo(epoca) = costo(model.P{end, end}, T, loss);
        if isnan(valor_costo(epoca))
            break
        end

        model = algoritmo_aprendizaje(x, T, model, alpha, train, batch_size, update);
        
    end

    E = model;
    E.C = valor_costo;

end