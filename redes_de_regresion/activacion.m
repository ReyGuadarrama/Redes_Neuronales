function a = activacion(z, tipo, m)
    
    % Asigna un valor por defecto a la pendiente en la activacion lineal
    if nargin < 3
        m = 1; % Valor por defecto de la pendiente de activacion lineal
    end

    % Realiza el tipo de funcion de activacion elegida
    if strcmp(tipo, 'lineal')
        a = m.*z;
    elseif strcmp(tipo, 'relu')
        a = z .* (z > 0);
    end

end

