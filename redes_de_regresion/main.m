clearvars, clc

% Generacion de muestras y valores objetivo
x = [ones(1, 100); linspace(-1, 1, 100)];
T = sin(2*pi*x(2,:));

% Creando una matriz de w
n_neuronas = 100;
w = randn(3, n_neuronas);
alpha = 0.01;

%%
iteraciones = 10000;
valor_costo = ones(0, iteraciones);

for iteracion = 1:iteraciones
    w = w - alpha*derivada(w, x, T);
    valor_costo(iteracion) = costo(w, x, T);
end

figure(1)
plot(x(2,:), T, x(2,:), red(w, x));

figure(2)
plot(1:iteraciones, valor_costo);
