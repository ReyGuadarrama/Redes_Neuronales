clearvars, clc

% Generacion de muestras y valores objetivo
x = [linspace(-1, 1, 101)];
T = abs(x);

%%
oculta1 = capa(1, 5, 'relu');
salida = capa(5, 1);
M = modelo(x, {oculta1, salida});
E = entrenamiento(x, T, M, 1000, 0.1, 'error cuadratico medio');

figure;
plot(x, T, 'bo', x, E.P{end, end}, 'LineWidth', 2);


diagrama_red(M);