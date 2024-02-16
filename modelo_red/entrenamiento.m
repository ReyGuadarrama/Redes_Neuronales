function E = entrenamiento(x, T, M, iteraciones, alpha, loss)
    
    % Calcula la derivada de los pesos y bias para la primera iteracion
    D = derivada(T, M);
    Dw = D(1,:);
    Db = D(2,:);
    model = M;
    n_capas = size(D, 2);
    
    % Inicializa un vector para almacenar el valor de la funcion de costo en cada iteracion
    valor_costo = zeros(1, iteraciones);

    for iteracion = 1:iteraciones

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
    
    figure;
    plot(1:iteraciones, valor_costo, 'LineWidth', 3);
    title('Costo')
    xlabel('Iteraciones'), ylabel('valor del costo')

    E = model;
    E.C = valor_costo;
end
    