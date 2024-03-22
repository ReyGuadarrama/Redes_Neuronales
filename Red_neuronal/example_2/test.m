clc, clearvars

ant_dir =  fullfile(pwd, '..');
addpath(genpath(ant_dir));

% Load handwritten digit images and labels
%train_dataset
train_imgs = loadMNISTImages('./Mnist/train-images.idx3-ubyte');
train_labels = loadMNISTLabels('./Mnist/train-labels.idx1-ubyte');

% test dataset
test_imgs = loadMNISTImages('./Mnist/t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('./Mnist/t10k-labels.idx1-ubyte');
%%

capa1 = layer(784, 100, 'relu');
capa2 = layer(100, 50, 'relu');
salida = layer(50, 10, 'softmax');

Momentum_model = model([capa1, capa2, salida]);
SGD_model = model([capa1, capa2, salida]);
NAG_model = model([capa1, capa2, salida]);
AdaGrad_model = model([capa1, capa2, salida]);
RMSProp_model = model([capa1, capa2, salida]);



%%
epochs = 20;
batchSize = 100;

train.RMSProp(RMSProp_model, train_imgs, train_labels, 0.001, batchSize, epochs, 'cross entropy');
train.AdaGrad(AdaGrad_model, train_imgs, train_labels, 0.01, batchSize, epochs, 'cross entropy');
train.Momentum(NAG_model, train_imgs, train_labels, 0.01, batchSize, epochs, 'cross entropy');
train.SGD(SGD_model, train_imgs, train_labels, 0.01, batchSize, epochs, 'cross entropy');
train.Momentum(Momentum_model, train_imgs, train_labels, 0.01, batchSize, epochs, 'cross entropy');
%%
figure()
SGD_model.metrics.plot_loss()
hold on
Momentum_model.metrics.plot_loss()
NAG_model.metrics.plot_loss()
AdaGrad_model.metrics.plot_loss()
RMSProp_model.metrics.plot_loss()
hold off
title('loss');
legend(['MBGD: ', num2str(SGD_model.metrics.validation_loss(end))], ...
    ['GD momentum: ', num2str(Momentum_model.metrics.validation_loss(end))], ...
    ['NAG: ', num2str(NAG_model.metrics.validation_loss(end))], ...
    ['AdaGrad: ', num2str(AdaGrad_model.metrics.validation_loss(end))], ...
    ['RMSProp: ', num2str(RMSProp_model.metrics.validation_loss(end))])


figure()
SGD_model.metrics.plot_accuracy()
hold on
Momentum_model.metrics.plot_accuracy()
NAG_model.metrics.plot_accuracy()
AdaGrad_model.metrics.plot_accuracy()
RMSProp_model.metrics.plot_accuracy()
hold off
title('accuracy')
legend(['MBGD: ', num2str(SGD_model.metrics.validation_accuracy(end))], ...
    ['GD momentum: ', num2str(Momentum_model.metrics.validation_accuracy(end))], ...
    ['NAG: ', num2str(NAG_model.metrics.validation_accuracy(end))], ...
    ['AdaGrad: ', num2str(AdaGrad_model.metrics.validation_accuracy(end))], ...
    ['RMSProp: ', num2str(RMSProp_model.metrics.validation_accuracy(end))])



%%
% n=80; 
% 
% figure()
% img = reshape(test_imgs(:,n), 28, 28);
% imshow(img, 'Border', 'tight', 'InitialMagnification', 'fit')
% 
% label = find(test_labels(:,n)==1);
% disp(label - 1);
