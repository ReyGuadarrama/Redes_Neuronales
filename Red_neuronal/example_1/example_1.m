clearvars, clc, close all

nn_dir =  fullfile('..');
addpath(genpath(nn_dir));

dataFolder = fullfile('..', 'Datasets/datos_5.csv' );

[x, t] = extractor(dataFolder);

t =[t; t ==0];
%%

capa1 = layer(2, 20, 'relu');
capa2 = layer(20, 10, 'relu');
salida = layer(10, 2, 'softmax');


SGD_model = model([capa1, capa2, salida]);
Momentum_model = model([capa1, capa2, salida]);
Batch_model = model([capa1, capa2, salida]);
miniBatch_model = model([capa1, capa2, salida]);


train.SGD(SGD_model, x, t, 0.2, 1, 20, 'cross entropy');

train.SGDMomentum(Momentum_model, x, t, 0.2, 0.9, 100, 20, 'cross entropy');

train.SGD(miniBatch_model, x, t, 0.2, 100, 20, 'cross entropy');

train.SGD(Batch_model, x, t, 0.2, 1000, 20,  'cross entropy');

%%
figure()
SGD_model.plot_cost()
hold on
Momentum_model.plot_cost()
miniBatch_model.plot_cost()
Batch_model.plot_cost()
hold off
xlabel('epochs')
ylabel('cost')
legend('SGD', 'Momentum', 'miniBatch', 'Batch')

figure()
SGD_model.plot_accuracy()
hold on
Momentum_model.plot_accuracy()
miniBatch_model.plot_accuracy()
Batch_model.plot_accuracy()
xlabel('epochs')
ylabel('cost')
legend('SGD', 'Momentum', 'miniBatch', 'Batch')
%%
x_min = min(x(1,:));
x_max = max(x(1,:));
y_min = min(x(2,:));
y_max = max(x(2,:));

w1 = linspace(x_min, x_max);
w2 = linspace(y_min, y_max);
[X, Y] = meshgrid(w1, w1);

class = 2;

Prob = zeros(100, 100);
for point = 1:length(X)^2
    temp = SGD_model.prediction([X(point), Y(point)]');
    Prob(point) = temp(class);
end

figure()
mesh(w1, w2, Prob)
hold on
scatter3(x(1,:), x(2, :), t(class,:)+1, 10, t(class,:)-2, "filled")
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title(strcat('Mapa de probabilidad'))


