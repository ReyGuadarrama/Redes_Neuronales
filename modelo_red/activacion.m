function a = activacion(z, tipo) 

    % Realiza el tipo de funcion de activacion elegida
    if strcmp(tipo, 'lineal')
        a = z;
    elseif strcmp(tipo, 'relu')
        a = z .* (z > 0);
    elseif strcmp(tipo, 'sigmoide')
        a = 1 ./ (1 + exp(-z)) + 1e-4;
    elseif strcmp(tipo, 'softmax')
        exp_z = exp(z);
        a = exp_z ./ sum(exp_z, 1) + 1e-4;
    end

end

