clearvars, clc, close all

[x, t] = extractor('datos_2.csv');


%%

oculta1 = capa(2, 8, 'relu');
oculta2 = capa(8, 4, 'relu');
salida = capa(4, 1, 'sigmoide');
M = modelo(x,{oculta1, oculta2, salida});

%%

E_SGD = entrenamiento_test(x, t, M, 200, 0.1, 'binary cross entropy', 'SGD');
E_BGD = entrenamiento_test(x, t, M, 200, 0.1, 'binary cross entropy', 'BGD');
E_MBGD = entrenamiento_test(x, t, M, 200, 0.1, 'binary cross entropy', 'MBGD', 100);

plot(1:200, E_BGD.C, 1:200, E_SGD.C, 1:200, E_MBGD.C, LineWidth=3);
legend('BGD', 'SGD', 'MBGD');

mapa_prob(E_BGD, t, ', BGD');
mapa_prob(E_SGD, t, ', SGD');
mapa_prob(E_MBGD, t, ', MBGD');
