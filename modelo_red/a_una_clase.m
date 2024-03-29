clearvars, clc

% Extrae los datos de simpleclass_dataset
[x, T] = simpleclass_dataset;

t = T(1,:);

%%
oculta1 = capa(2, 4, 'relu');
oculta2 = capa(4, 8, 'relu');
salida = capa(8, 1, 'sigmoide');
M = modelo(x,{oculta1, oculta2, salida});

%%
E = entrenamiento(x, t, M, 5000, 0.1, 'binary cross entropy');

diagrama_red(M);
mapa_prob(E, t);
