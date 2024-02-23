clearvars, clc

% Extrae los datos de simpleclass_dataset
[x, t] = simpleclass_dataset;


%%
salida = capa(2, 4, 'softmax');
M = modelo(x,{salida});

%%
%E = entrenamiento(x, t, M, 5000, 0.1, 'cross entropy');
E = entrenamiento_test(x, t, M, 5000, 0.1, 'cross entropy', 'BGD', 10);
%%
diagrama_red(M);
mapa_prob(E, t);
figure()
plot(1:5000, E.C, 'LineWidth', 3);
