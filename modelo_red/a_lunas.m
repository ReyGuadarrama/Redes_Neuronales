clearvars, clc, close all

[x, t] = extractor('datos_lunas_normal.csv');

plot(x(1,:), x(2,:), 'o')

t = t(1, :);

%%

oculta1 = capa(2, 8, 'relu');
oculta2 = capa(8, 16, 'relu');
oculta3 = capa(16, 8, 'relu');
salida = capa(8, 1, 'sigmoide');
M = modelo(x,{oculta1, oculta2, oculta3, salida});

%%

E = entrenamiento(x, t, M, 5000, 0.1, 'binary cross entropy');

diagrama_red(M);
mapa_prob(E, t);