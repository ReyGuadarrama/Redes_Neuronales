clearvars, clc, close all

% Definir rangos y variables iniciales
x = linspace(-15, 15, 200);
[f, df] = fun(x);

iteraciones = 100;
lr = 0.05;

% Parámetros de Adam
beta1 = 0.9;
beta2 = 0.999;

% Tamaños de ventana a evaluar
window_sizes = [1, 5, 10, 20];
% Zonas a evaluar
zonas = [-10, -2, -1, 2, 7.6, 11.4];


% Figura para los resultados del algoritmo Adam
figure;

% Para cada zona, correr el algoritmo Adam y graficar los resultados
for z = 1:length(zonas)
    X = zonas(z);  % Zona inicial
    subplot(3, 2, z);
    hold on;
    colors = lines(length(window_sizes));
    
    % Ejecutar el algoritmo Adam para diferentes tamaños de ventana
    for w = 1:length(window_sizes)
        window_size = window_sizes(w);
        gradient_history = [];
        v = 0;
        m = 0;
        x0 = X;
        adam_history = zeros(1, iteraciones);  % Guardar historia de costos

        for i = 1:iteraciones
            [f_x0, df_x0] = fun(x0);
            [x0, m, v, m_norm, v_norm, gradient_history] = adam_mw(x0, df_x0, m, v, i, lr, beta1, beta2, window_size, gradient_history);
            adam_history(i) = f_x0;  % Guardar la función de costo
        end

        % Graficar los resultados para esta zona y tamaño de ventana
        plot(1:iteraciones, adam_history, 'DisplayName', ['Tamaño de ventana: ', num2str(window_sizes(w))], 'Color', colors(w, :));
    end
    
    % Configurar el subplot
    title(['Zona inicial: ', num2str(X)]);
    xlabel('Iteraciones');
    ylabel('Costo');
    legend show;
    grid on;
    hold off;
end

% Configurar la figura principal
sgtitle('Convergencia de Adam en diferentes zonas con distintos tamaños de ventana');

% % Crear figuras adicionales para cada zona
% for z = 1:length(zonas)
%     X = zonas(z);  % Zona inicial
%     figure;
%     sgtitle(['Zona: ', num2str(z)]);
% 
%     for w = 1:length(window_sizes)
%         window_size = window_sizes(w);
%         gradient_history = [];
%         v = 0;
%         m = 0;
%         x0 = X;
%         puntos = zeros(1, iteraciones);
%         adam_history = zeros(1, iteraciones);  % Guardar historia de costos
%         c = 1:iteraciones;  % Para color en scatter plot
% 
%         for i = 1:iteraciones
%             [f_x0, df_x0] = fun(x0);
%             puntos(i) = x0;
%             [x0, m, v, m_norm, v_norm, gradient_history] = adam_mw(x0, df_x0, m, v, i, lr, beta1, beta2, window_size, gradient_history);
%             adam_history(i) = f_x0;  % Guardar la función de costo
%         end
% 
%         % Crear subplot para cada tamaño de ventana
%         subplot(2, 2, w);
%         plot(x, f, 'Color', 'b');
%         hold on;
%         scatter(puntos, adam_history, 20, c, 'filled');
%         colormap('autumn');
%         s = plot(puntos(1), adam_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
%         e = plot(puntos(end), adam_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'finish');
%         title(['tamaño de ventana: ', num2str(window_sizes(w))]);
%         xlabel('x');
%         ylabel('f(x)');
%         legend([s, e]);
%         grid on;
%         hold off;
%     end
% end

