clc, clearvars, close all

%  Vector x
x = linspace(0, 3*pi, 50);

% Vector de valores objetivo
T = - sin(x);

% vectores de coeficientes de los polinomios
w_n1 = randn(1, 7);
w_n2 = w_n1;

% Parametro de aprendizaje
alpha = 0.001;

% Limite de las graficas
x_lim = [min(x) - 1, max(x) + 1];
y_lim = [min(T) - 1, max(T) + 1];

%%
figure(1)

%numero de iteraciones
iteraciones = 1000;

for iteracion = 1:iteraciones

    % Graficacion de datos normalizados 1 
    subplot(1, 2, 1);
    plot(x, hipotesis_n1(w_n1, x), 'r');
    xlim(x_lim), ylim(y_lim);
    title('Ajuste')
    hold on
    plot(x, T, 'bo')
    hold off
    
    % Actualizacion de los coeficientes w_n1
    derivada1 = derivada_n1(w_n1, x, T);
    w_n1 = w_n1 - alpha*derivada1;

    % Graficacion de datos normalizados 2
    subplot(1, 2, 2);
    plot(x, hipotesis_n2(w_n2, x), 'r');
    xlim(x_lim), ylim(y_lim);
    title('Ajuste')
    hold on
    plot(x, T, 'bo')
    hold off
    
    % Acutializacion de los coeficientes w_n2
    derivada2 = derivada_n2(w_n2, x, T);
    w_n2 = w_n2 - alpha*derivada2;

    pause(0.001)
end


