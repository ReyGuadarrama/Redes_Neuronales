function E = entrenamiento_test(x, T, M, epocas, alpha, loss, train, batch_size)

    % Inicializa un batch size de 100 por defecto
    if nargin < 8
        batch_size = 100; 
    end 
    
    if strcmp(train, 'BGD')
        [E, C] = batch_gradient_descent(x, T, M, epocas, alpha, loss);
    elseif strcmp(train, 'SGD')
        [E, C] = stochastic_gradient_descent(x, T, M, epocas, alpha, loss);
    elseif strcmp(train, 'MBGD')
        [E, C] = minibatch_gradient_descent(x, T, M, epocas, batch_size, alpha, loss);
    end

    % figure;
    % plot(1:epocas, C, 'LineWidth', 3);
    % title('Costo')
    % xlabel('Iteraciones'), ylabel('valor del costo')

    E.C = C;
end

% Batch Gradient Decent

function [BGD, C] = batch_gradient_descent(x, T, M, epocas, alpha, loss)

    % Calcula la derivada de los pesos y bias para la primera iteracion
    D = derivada(T, M);
    Dw = D(1,:);
    Db = D(2,:);
    model = M;
    n_capas = size(D, 2);
    
    % Inicializa un vector para almacenar el valor de la funcion de costo en cada iteracion
    valor_costo = zeros(1, epocas);

    for iteracion = 1:epocas

        valor_costo(iteracion) = costo(model.P{end, end}, T, loss);

        capas = cell(1, n_capas);
        w = model.w;
        b = model.b;
        a = model.a;
    
        for capa = 1:n_capas
            cap.w = w{capa} - alpha * Dw{capa};
            cap.b = b{capa} - alpha * Db{capa};
            cap.a = a{capa};
            capas{capa} = cap;
        end
    
        model = modelo(x, capas);
    
        D = derivada(T, model);
        Dw = D(1,:);
        Db = D(2,:);

    end

    BGD = model;
    C = valor_costo;
end

% Stochastica Gradient Decent
function [SGD, C] = stochastic_gradient_descent(x, T, M, epocas, alpha, loss)

    % Extrae el modelo de la red y sus caracteristicas
    model = M;
    n_capas = size(model.w, 2);
    n_muestras = size(x, 2);
    capas = cell(1, n_capas);

    for capa = 1:n_capas
        cap.w = model.w{capa};
        cap.b = model.b{capa};
        cap.a = model.a{capa};
        capas{capa} = cap;
    end

    % Inicializa un vector para almacenar el valor de la funcion de costo en cada iteracion
    valor_costo = zeros(1, epocas);

    for epoca = 1:epocas

        model = modelo(x, capas);
        valor_costo(epoca) = costo(model.P{end, end}, T, loss);

        % Revuelve las muestras
        indices_revueltos = randperm(length(x));

        for muestra = 1:n_muestras

            muestra_aleatoria = x(:,indices_revueltos(muestra));
            etiqueta = T(:,indices_revueltos(muestra));

            model = modelo(muestra_aleatoria, capas);

            D = derivada(etiqueta, model);
            Dw = D(1,:);
            Db = D(2,:);
    
            capas = cell(1, n_capas);
            w = model.w;
            b = model.b;
            a = model.a;
        
            for capa = 1:n_capas
                cap.w = w{capa} - alpha * Dw{capa};
                cap.b = b{capa} - alpha * Db{capa};
                cap.a = a{capa};
                capas{capa} = cap;
            end

        end

    end

    SGD = modelo(x, capas);
    C = valor_costo;
end

% Mini-Batch Gradient Decent
function [MBGD, C] = minibatch_gradient_descent(x, T, M, epocas, batch_size, alpha, loss)

    % Extrae el modelo de la red y sus caracteristicas
    model = M;
    n_capas = size(model.w, 2);
    n_muestras = size(x, 2);
    capas = cell(1, n_capas);

    for capa = 1:n_capas
        cap.w = model.w{capa};
        cap.b = model.b{capa};
        cap.a = model.a{capa};
        capas{capa} = cap;
    end

    % Inicializa un vector para almacenar el valor de la funcion de costo en cada iteracion
    valor_costo = zeros(1, epocas);
    iteraciones = floor(n_muestras/batch_size);

    for epoca = 1:epocas

        model = modelo(x, capas);
        valor_costo(epoca) = costo(model.P{end, end}, T, loss);

        % Revuelve las muestras
        indices_revueltos = randperm(length(x));

        for iteracion = 1:iteraciones

            batch_indices = indices_revueltos(:,batch_size * (iteracion - 1) + 1:batch_size * iteracion);
            
            batch = x(:,batch_indices);
            etiquetas = T(:, batch_indices);

            model = modelo(batch, capas);

            D = derivada(etiquetas, model);
            Dw = D(1,:);
            Db = D(2,:);
    
            capas = cell(1, n_capas);
            w = model.w;
            b = model.b;
            a = model.a;
        
            for capa = 1:n_capas
                cap.w = w{capa} - alpha * Dw{capa};
                cap.b = b{capa} - alpha * Db{capa};
                cap.a = a{capa};
                capas{capa} = cap;
            end

        end

    end

    MBGD = modelo(x, capas);
    C = valor_costo;
end