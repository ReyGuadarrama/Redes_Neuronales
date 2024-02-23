  function C = costo(P, T, tipo)
    
    % obtiene el n[umero de muestras
    n_muestras = size(P, 2);

    % Realiza el tipo de funcion de activacion elegida
    if strcmp(tipo, 'error cuadratico medio')

        % Funcion de costo promedio cuadratico
        C = sum((P - T).^2) ./ n_muestras;

    elseif strcmp(tipo, 'binary cross entropy')

        % Funcion de costo binary cross entropy
        C = - sum(T.*log(P) + (1 - T).*log(1 - P)) ./ n_muestras;

    elseif strcmp(tipo, 'cross entropy')

        % Funcion de costo cross entropy
        C = 0;
        for i = 1:length(P(1,:))
            C = C - sum(T(:,i) .* log(P(:,i))) ./ n_muestras;
        end
    end
end