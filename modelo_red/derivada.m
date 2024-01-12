function D = derivada(T, modelo)
    
    % Obtiene el numero de muestras
    n_muestras = size(T, 2);

    % Obtiene el numero de capas en el modelo
    n_capas = size(modelo.w, 2);
    
    % Obtiene los valores y las clases de funciones de activacion del modelo 
    activaciones = modelo.P(2,:);
    tipo_activacion = modelo.a;

    w = modelo.w;

    % Crea una celda para almacenar las derivadas de cada capa
    D = cell(2, n_capas);
    DC_Dz = cell(1, n_capas);

    % Calcula la derivada del costo respecto a z(m)
    DC_Dam = 2 * (activaciones{end} - T) ./ n_muestras; % DC/Da(m)
    Dam_Dzm = Da_Dz(activaciones{end}, tipo_activacion{end});
    DC_Dzm = DC_Dam .* Dam_Dzm; % DC/Dz(m)
    DC_Dwm = activaciones{end - 1} * DC_Dzm'; % DC/Dw(m-1)

    % Agrega el valor de las derivadas a una celda
    D{1, end} = DC_Dwm; % Derivadas DC/DW
    D{2, end} = sum(DC_Dzm, 2); % Derivadas DC/Db
    DC_Dz{end} = DC_Dzm; % Derivadas DC/Dz
     
    % Calcula las derivadas utilizando la propagacion hacia atras
    for i = 2:n_capas
        Dai_Dzi = Da_Dz(activaciones{end - (i - 1)}, ...
                  tipo_activacion{end - (i - 1)});  % Da(i)/Dz(i)
        DC_Dzi = (w{end - (i - 2)} * DC_Dz{end - (i - 2)}) .* Dai_Dzi; % DC/Dz(i)
        DC_Dwi = activaciones{end - i} * DC_Dzi'; % DC/Dw(i)

        % Agrega el valor de las derivadas a una celda
        D{1, end - (i - 1)} = DC_Dwi; % Derivadas DC/DW
        D{2, end - (i - 1)} = sum(DC_Dzi, 2); % Derivadas DC/Db
        DC_Dz{end - (i - 1)} = DC_Dzi; % Derivadas DC/Dz
    end

end

% Funcion que calcula la derivada de la funcion de activacion da(m)/dz(m)

function Da = Da_Dz(activacion, tipo)
    
     % Realiza la derivada del tipo de funcion de activacion elegida
    if strcmp(tipo, 'lineal')
        Da = ones(size(activacion));
    elseif strcmp(tipo, 'relu')
        Da = (activacion > 0);
    elseif strcmp(tipo, 'sigmoide')
        Da = activacion .* (1 - activacion);
    elseif strcmp(tipo, 'softmax')
        Da = activacion - (activacion.^2);  
    end
end
