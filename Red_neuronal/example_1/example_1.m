clearvars, clc, close all

nn_dir =  fullfile('..');
addpath(genpath(nn_dir));

dataFolder = fullfile('..', 'Datasets/datos_3.csv' );

[x, t] = extractor(dataFolder);

t =[t; t ==0];
%%

capa1 = layer(2, 20, 'relu');
capa2 = layer(20, 40, 'relu');
capa3 = layer(40, 20, 'relu');
salida = layer(20, 2, 'softmax');


SGD_model = model([capa1, capa2, capa3, salida]);
Momentum_model = model([capa1, capa2, capa3, salida]);
Batch_model = model([capa1, capa2, capa3, salida]);
miniBatch_model = model([capa1, capa2, capa3, salida]);
NAG_model = model([capa1, capa2, capa3, salida]);


train.SGD(SGD_model, x, t, 0.2, 1, 1000, 'cross entropy');

train.Momentum(Momentum_model, x, t, 0.2, 100, 1000, 'cross entropy');

train.SGD(miniBatch_model, x, t, 0.2, 100, 1000, 'cross entropy');

train.SGD(Batch_model, x, t, 0.2, 1000, 1000,  'cross entropy');

train.NAG(NAG_model, x, t, 0.2, 100, 1000, 'cross entropy');

%%
figure()
SGD_model.metrics.plot_loss()
hold on
Momentum_model.metrics.plot_loss()
miniBatch_model.metrics.plot_loss()
Batch_model.metrics.plot_loss()
NAG_model.metrics.plot_loss()

hold off
xlabel('epochs')
ylabel('cost')
legend('SGD', 'Momentum', 'miniBatch', 'Batch', 'NAG')

figure()
SGD_model.metrics.plot_accuracy()
hold on
Momentum_model.metrics.plot_accuracy()
miniBatch_model.metrics.plot_accuracy()
Batch_model.metrics.plot_accuracy()
NAG_model.metrics.plot_accuracy()

xlabel('epochs')
ylabel('cost')
legend('SGD', 'Momentum', 'miniBatch', 'Batch', 'NAG')
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


