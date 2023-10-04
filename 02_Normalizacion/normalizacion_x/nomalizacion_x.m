clc, clearvars, close all

% Vectores x
x = linspace(0, 3*pi, 50);
x_n1 = (x-mean(x))/std(x);
x_n2 = (x-min(x))/(max(x) - min(x));

% Vector de valores objetivo
T = sin(x);

% Vectores de coeficientes de la hipotesis
w = randn(1, 6);
w_n1 = w;
w_n2 = w;

% parametro de aprendizaje
alpha = 0.0008;

% Limites de la grafica
x_lim = [min(x) - 1, max(x) + 1];
y_lim = [min(T) - 1, max(T) + 1];
%%
figure(1)

% numero de iteraciones
iteraciones = 1000;

% Inicializacion de vectores con los valores del costo
valor_costo = ones(1, iteraciones);
valor_costo_n1 = ones(1, iteraciones);
valor_costo_n2 = ones(1, iteraciones);


for iteracion = 1:iteraciones
    % Ajuste sin normalizar
    
    % Graficacion del ajuste sin normalizar
    subplot(1, 3, 1)
    plot(x, hipotesis(w, x), 'r');
    xlim(x_lim), ylim(y_lim);
    title('Ajuste sin normalizar')
    hold on
    plot(x, T, 'bo')
    hold off
    
    % Actualizacion de los valores del costo y el vector de coeficientes
    valor_costo(iteracion) = costo(w, x, T);
    derivada = derivada_w(w, x, T);
    w = w - alpha*derivada;

    
    % Ajuste normalizando x metodo 1: Valores normales mu = 0, std = 1
    
    % Graficacion del ajuste normalizados 1
    subplot(1, 3, 2)
    plot(x, hipotesis(w_n1, x_n1), 'r', 'LineWidth', 1);
    xlim(x_lim), ylim(y_lim);
    title('Ajuste normalizado')
    hold on
    plot(x, T, 'bo')
    hold off

    % Actualizacion de los valores del costo y el vector de coeficientes
    valor_costo_n1(iteracion) = costo(w_n1, x_n1, T);
    derivada_n1 = derivada_w(w_n1, x_n1, T);
    w_n1 = w_n1 - alpha*derivada_n1;

    % Ajuste normalizando x metodo 2: valores entre [0, 1]
    
    % Graficacion del ajuste normalizados 2
    subplot(1, 3, 3)
    plot(x, hipotesis(w_n2, x_n2), 'r', 'LineWidth', 1);
    xlim(x_lim), ylim(y_lim);
    title('Ajuste normalizado')
    hold on
    plot(x, T, 'bo')
    hold off
    
    % Actualizacion de los valores del costo y el vector de coeficientes
    valor_costo_n2(iteracion) = costo(w_n2, x_n2, T);
    derivada_n2 = derivada_w(w_n2, x_n2, T);
    w_n2 = w_n2 - alpha*derivada_n2;

    pause(0.001)
end

figure(2)

% GRaficacion del valor del costo contra las iteraciones
semilogy(1:iteraciones, valor_costo);
hold on
semilogy(1:iteraciones, valor_costo_n1);
semilogy(1:iteraciones, valor_costo_n2);
hold off
legend("sin normalizar", "normalizacion mu = 0, std = 1", "normalizacion [0, 1]");

