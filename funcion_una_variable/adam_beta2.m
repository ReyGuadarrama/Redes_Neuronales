clearvars, clc, close all

% Combinaciones interesantes
% beta1 = 0.9
% beta2_values = linspace(0.1, 0.9, 9)

% beta1 = 0.99
% beta2_values = linspace(0.1, 0.999, 9)



% Definir rangos y variables iniciales
x = linspace(-15, 15, 200);
[f, df] = fun(x);
zonas = [-10, -2, -1, 2, 7.6, 11.4];

iteraciones = 100;
lr = 0.05;

% Hiperparámetros a evaluar
beta1 = 0.99;  % Dejar beta1 fijo
beta2_values = linspace(0.1, 0.999, 9);  % valores diferentes para beta2


% Figura para los resultados del algoritmo Adam
figure;

% Crear una cuadrícula de subplots para cada valor de beta1
for z = 1:length(zonas)
    subplot(3, 2, z);
    hold on;
    colors = lines(length(beta2_values));

    % Ejecutar el algoritmo Adam para cada zona
    for  b2 = 1:length(beta2_values)
        beta2= beta2_values(b2);
        X = zonas(z);  % Zona inicial
        gradient_history = [];
        v = 0;
        m = 0;
        x0 = X;
        adam_history = zeros(1, iteraciones);  % Guardar historia de costos

        for i = 1:iteraciones
            [f_x0, df_x0] = fun(x0);
            [x0, m, v, m_norm, v_norm] = adam(x0, df_x0, m, v, i, lr, beta1, beta2);
            adam_history(i) = f_x0;  % Guardar la función de costo
        end

        % Graficar los resultados para esta zona
        plot(1:iteraciones, adam_history, 'DisplayName', ['\beta_1 = ', num2str(beta1), ', \beta_2 = ', num2str(beta2, 3)], 'Color', colors(b2, :));
    end
    
    % Configurar el subplot
    title(['zona: ', num2str(z)]);
    xlabel('Iteraciones');
    ylabel('Valor de la función de costo');
    legend show;
    grid on;
    hold off;
end

% Configurar la figura principal
sgtitle(['Convergencia de Adam para varios \beta_2 con \beta_1 = ', num2str(beta1)]);


%%
% Crear figuras adicionales para cada zona
for z = 1:length(zonas)
    X = zonas(z);  % Zona inicial
    figure;
    sgtitle(['Zona: ', num2str(z), ',  \beta_1 = ', num2str(beta1)]);

    for  b2 = 1:length(beta2_values)
        beta2 = beta2_values(b2);
        X = zonas(z);  % Zona inicial
        puntos = zeros(1, iteraciones); 
        gradient_history = [];
        v = 0;
        m = 0;
        x0 = X;
        adam_history = zeros(1, iteraciones);  % Guardar historia de costos
        c = 1:iteraciones;  % Para color en scatter plot

        for i = 1:iteraciones
            [f_x0, df_x0] = fun(x0);
            puntos(i) = x0;
            [x0, m, v, m_norm, v_norm] = adam(x0, df_x0, m, v, i, lr, beta1, beta2);
            adam_history(i) = f_x0;  % Guardar la función de costo
        end

        % Crear subplot para cada tamaño de ventana
        subplot(3, 3, b2);
        plot(x, f, 'Color', 'b');
        hold on;
        scatter(puntos, adam_history, 20, c, 'filled');
        colormap('autumn');
        s = plot(puntos(1), adam_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
        e = plot(puntos(end), adam_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'finish');
        title(['beta 2: ', num2str(beta2_values(b2), 3)]);
        xlabel('x');
        ylabel('f(x)');
        legend([s, e]);
        grid on;
        hold off;
    end
end


