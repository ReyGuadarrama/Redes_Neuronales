clc, clearvars, close all

% Permite utilizar las funciones definidas en el folder anterior
ant_dir =  fullfile(pwd, '..');
addpath(genpath(ant_dir));

% Extrae los datos de entrenamiento y de prueba
dataFolder = fullfile(toolboxdir('nnet'),'nndemos','nndatasets','DigitDataset');
[train_imgs, train_labels, test_imgs, test_labels] = img_extractor(dataFolder);


% Normalizacion de los datos
train_imgs = train_imgs ./ 255;
test_imgs = test_imgs ./ 255;
%%

capa1 = layer(784, 20, 'relu');
salida = layer(20, 10, 'softmax');

test_model = model([capa1, salida]);
%%

P = test_model.prediction(train_imgs);
layers_info = test_model.pass_forward(train_imgs);
derivatives_info = test_model.back_propagation(train_imgs, train_labels, 'cross entropy');
test_cost = cost(P, train_labels, 'cross entropy');
test_acc = train.accuracy(test_model, test_imgs, test_labels);
train.SGD(test_model, train_imgs, train_labels, 0.05, 1, 'cross entropy');

%%

% Encuentra los NaN
find(isnan(P))
