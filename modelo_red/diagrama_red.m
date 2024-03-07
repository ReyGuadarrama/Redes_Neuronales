function diagrama_red(M)   

    % Información sobre la arquitectura de la red
    capa_entrada = size(M.w{1}, 1);
    n_capas = size(M.w, 2);
    capas = [capa_entrada, ones(1, n_capas)];
    for capa = 1:n_capas
        capas(capa + 1) = size(M.w{capa}, 2);
    end
    funciones_activacion = [{'lineal'}, M.a(:)'];
    espacio_entre_neuronas = 2;
    espacio_entre_capas = 5;
    
    
    % Crear una nueva figura
    figure;
    title('Diagrama de la red neuronal')
    
    % Dibujar la capa de entrada y conectar con las siguientes capas
    for capa = 1:length(capas)-1
        x_position = capa * espacio_entre_capas;
        altura_total_capa_actual = capas(capa) * espacio_entre_neuronas;
        altura_total_capa_siguiente = capas(capa+1) * espacio_entre_neuronas;
    
        inicio_y_actual = -altura_total_capa_actual / 2; % Centrar verticalmente
        inicio_y_siguiente = -altura_total_capa_siguiente / 2; % Centrar verticalmente
    
        % Dibujar neuronas en la capa actual
        for i = 1:capas(capa)
            y_position_actual = inicio_y_actual + (i - 0.5) * espacio_entre_neuronas; % Ajuste para centrar
            rectangle('Position', [x_position, y_position_actual, 1, 1], 'Curvature', [1, 1], 'FaceColor', 'w');
            rectangle('Position', [x_position + 1.5, y_position_actual, 1, 1], 'Curvature', [0, 0], 'FaceColor', 'w');
            line([x_position + 1, x_position + 1.5], [y_position_actual + 0.5, y_position_actual + 0.5], 'Color', 'k');
    
            % Conectar con neuronas de la capa siguiente
            for j = 1:capas(capa+1)
                y_position_siguiente = inicio_y_siguiente + (j - 0.5) * espacio_entre_neuronas; % Ajuste para centrar
                line([x_position + 2.5, x_position + 5], [y_position_actual + 0.5, y_position_siguiente + 0.5], 'Color', 'k');
            end
        end
    
        y_position_capa = inicio_y_actual + 1; %+ (capas(capa) / 2) * espacio_entre_neuronas; % Posición en el centro de la capa
        text(x_position + 2, y_position_capa, sprintf('%s', funciones_activacion{capa}), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 10);
    end
    
    % Dibujar la última capa
    capa = length(capas);
    x_position = capa * espacio_entre_capas;
    altura_total_capa_actual = capas(capa) * espacio_entre_neuronas;
    inicio_y_actual = -altura_total_capa_actual / 2;
    
    for i = 1:capas(capa)
        y_position_actual = inicio_y_actual + (i - 0.5) * espacio_entre_neuronas; % Ajuste para centrar
        rectangle('Position', [x_position, y_position_actual, 1, 1], 'Curvature', [1, 1], 'FaceColor', 'w');
        rectangle('Position', [x_position + 1.5, y_position_actual, 1, 1], 'Curvature', [0, 0], 'FaceColor', 'w');
        line([x_position + 1, x_position + 1.5], [y_position_actual + 0.5, y_position_actual + 0.5], 'Color', 'k');
    end
    
    % Colocar el nombre de la función de activación sobre la última capa
    y_position_capa = inicio_y_actual + (capas(capa) / 2) * espacio_entre_neuronas; % Posición en el centro de la capa
    text(x_position + 2, y_position_capa, sprintf('%s', funciones_activacion{capa}), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 10);
    
    
    % Ajustar los ejes
    axis equal;
    axis off;
end