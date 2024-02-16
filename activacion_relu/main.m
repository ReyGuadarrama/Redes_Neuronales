clc, clearvars, close all

x = linspace(-2, 10);
n_puntos = 30;
n_graf = floor((n_puntos+4)/5);

puntos = linspace(-2, 10, n_puntos);

% Elegir puntos aleatorios
indices = randperm(100, n_puntos);
pts_aleatorios = x(indices);
pts_aleatorios = sort(pts_aleatorios);

%[relus, w] = ajuste(@funcion, x, puntos);

[relus, w] = ajuste(@funcion, x, pts_aleatorios);


resultado = zeros(1, length(x));

figure(1)
hold on 

for i = 1:n_puntos - 1
    subplot(n_graf, 5, i);
    plot(w(i) * relus(i,:), LineWidth=2);
    resultado = resultado + w(i) * relus(i,:);
end
hold off

figure(2)
plot(x, funcion(x), LineWidth=2);
hold on
plot(x, resultado, LineWidth=2);
hold off


