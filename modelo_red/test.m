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
