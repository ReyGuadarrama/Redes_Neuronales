function updated_model = algoritmo_aprendizaje(x, T, model, alpha, algoritmo, batch_size, update)
        
    % ejecuta el tipo de algoritmo de apredizaje seleccionado
    if strcmp(algoritmo, 'BGD')
         batch_size = length(x);
    elseif strcmp(algoritmo, 'SGD')
         batch_size = 1;
    end
    
    updated_model = miniBatch_gradient_descent(x, T, model, alpha, batch_size, update);

end

% Algoritmo mini Batch Gradient Descent
function updated_model = miniBatch_gradient_descent(x, T, model, alpha, batch_size, update)

    n_muestras = length(x);
    n_capas = size(model.w, 2);
    indices_revueltos = randperm(n_muestras);
    iteraciones = floor(n_muestras/batch_size);
    
    params = cell(1, n_capas);
    for capa = 1:n_capas
        cap.w = model.w{capa};
        cap.b = model.b{capa};
        cap.a = model.a{capa};
        cap.mw = zeros(size(cap.w));
        cap.mb = zeros(size(cap.b));
        params{capa} = cap;
    end

    for iteracion = 1:iteraciones

        batch_indices = indices_revueltos(:, batch_size * (iteracion - 1) + 1 : batch_size * iteracion);

        batch = x(:, batch_indices);
        etiquetas = T(:, batch_indices);

        [params, ~] = optimizador(batch, etiquetas, params, alpha, update);
        
    end

    [~, updated_model] = optimizador(x, T, params, alpha, update);
    
end

