clearvars, clc

% Generacion de muestras y valores objetivo
x = [linspace(-1, 1, 11)];
T = x;


%%
oculta = capa(1, 10, 'relu');
salida = capa(10, 1);
M = modelo(x, {oculta, salida});
E = entrenamiento(x, T, M, 100, 0.2, 'error cuadratico medio');

figure;
plot(x, T, 'bo', x, E.P{end, end}, 'LineWidth', 2);


diagrama_red(M);