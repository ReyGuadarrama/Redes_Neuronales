function [params, model] = optimizador(x, T, params, alpha, algorithm)

    % ejecuta el tipo de algoritmo de actualizacion seleccionado
    if strcmp(algorithm, 'GD')
        [params, model] = gradient_descent(x, T, params, alpha);
    elseif strcmp(algorithm, 'NAG')
        [params, model] = nesterov_accelerated_gradient(x, T, params, alpha);
    elseif strcmp(algorithm, 'momentum')
        [params, model] = momentum(x, T, params, alpha);
    elseif strcmp(algorithm, 'RMSProp')
        [params, model] = RMSProp(x, T, params, alpha);
    elseif strcmp(algorithm, 'Adagrad')
        [params, model] = Adagrad(x, T, params, alpha);
    end
end

% Algoritmo gradiente descendete 
function [updated_params, updated_model] = gradient_descent(x, T, params, alpha)

    model = modelo(x, params);
    
    n_capas = size(model.w, 2);
    
    D = derivada(T, model);
    Dw = D(1,:);
    Db = D(2,:);

    params = cell(1, n_capas);
    w = model.w;
    b = model.b;
    a = model.a;

    for capa = 1:n_capas
        updated_params.w = w{capa} - alpha * Dw{capa};
        updated_params.b =  b{capa} - alpha * Db{capa};
        updated_params.a =  a{capa};
        params{capa} = updated_params;
    end
    
    updated_params = params;
    updated_model = modelo(x, params);

end

% Algorimo gradiente descendente con momento
function [updated_params, updated_model] = momentum(x, T, prev_params, alpha)

    model = modelo(x, prev_params);

    n_capas = size(model.w, 2);
    gamma = 0.9;
    
    D = derivada(T, model);
    Dw = D(1,:);
    Db = D(2,:);

    params = cell(1, n_capas);
    w = model.w;
    b = model.b;
    a = model.a;

    for capa = 1:n_capas
        updated_params.mw = (gamma * prev_params{capa}.mw) + alpha * Dw{capa};
        updated_params.mb = (gamma * prev_params{capa}.mb) + alpha * Db{capa};
        updated_params.w = w{capa} - updated_params.mw;
        updated_params.b =  b{capa} - updated_params.mb;
        updated_params.a =  a{capa};
        params{capa} = updated_params;
    end
    
    updated_params = params;
    updated_model = modelo(x, params);

end

% Algorimo Nesterov accelerated gradient
function [updated_params, updated_model] = nesterov_accelerated_gradient(x, T, prev_params, alpha)

    model = modelo(x, prev_params);

    n_capas = size(model.w, 2);
    gamma = 0.9;

    params = cell(1, n_capas);
    ahead_params = cell(1, n_capas);
    w = model.w;
    b = model.b;
    a = model.a;

    for capa = 1:n_capas
        ahead.w = w{capa} - (gamma*prev_params{capa}.mw);
        ahead.b =  b{capa} - (gamma*prev_params{capa}.mb);
        ahead.a = a{capa};
        ahead_params{capa} = ahead;
    end
    
    model = modelo(x, ahead_params);
    
    D = derivada(T, model);
    Dw_ahead = D(1,:);
    Db_ahead = D(2,:);

    for capa = 1:n_capas
        updated.mw = (gamma * prev_params{capa}.mw) + alpha * Dw_ahead{capa};
        updated.mb = (gamma * prev_params{capa}.mb) + alpha * Db_ahead{capa};
        updated.w = w{capa} - updated.mw;
        updated.b =  b{capa} - updated.mb;
        updated.a =  a{capa};
        params{capa} = updated;
    end

    updated_params = params;
    updated_model = modelo(x, params);

end

% Algoritmo Root Mean Squared Propagation
function [updated_params, updated_model] = RMSProp(x, T, prev_params, alpha)

    model = modelo(x, prev_params);

    n_capas = size(model.w, 2);
    gamma = 0.9;
    
    D = derivada(T, model);
    Dw = D(1,:);
    Db = D(2,:);

    params = cell(1, n_capas);
    w = model.w;
    b = model.b;
    a = model.a;

    for capa = 1:n_capas
        updated_params.mw = (gamma * prev_params{capa}.mw) + (1 - gamma) * (Dw{capa}.^2);
        updated_params.mb = (gamma * prev_params{capa}.mb) + (1 - gamma) * (Db{capa}.^2);
        updated_params.w = w{capa} - (alpha ./ sqrt(updated_params.mw + 1e-8)) .* Dw{capa};
        updated_params.b =  b{capa} -  (alpha ./ sqrt(updated_params.mb + 1e-8)) .* Db{capa};
        updated_params.a =  a{capa};
        params{capa} = updated_params;
    end
    
    updated_params = params;
    updated_model = modelo(x, params);

end

% Adaptative Gradient algorithm
function [updated_params, updated_model] = Adagrad(x, T, prev_params, alpha)

    model = modelo(x, prev_params);

    n_capas = size(model.w, 2);
    
    D = derivada(T, model);
    Dw = D(1,:);
    Db = D(2,:);

    params = cell(1, n_capas);
    w = model.w;
    b = model.b;
    a = model.a;

    for capa = 1:n_capas
        updated_params.mw = prev_params{capa}.mw + Dw{capa}.^2;
        updated_params.mb = prev_params{capa}.mb + Db{capa}.^2;
        updated_params.w = w{capa} - (alpha ./ sqrt(updated_params.mw + 1e-8)) .* Dw{capa};
        updated_params.b =  b{capa} -  (alpha ./ sqrt(updated_params.mb + 1e-8)) .* Db{capa};
        updated_params.a =  a{capa};
        params{capa} = updated_params;
    end
    
    updated_params = params;
    updated_model = modelo(x, params);

end