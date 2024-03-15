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

capa1 = layer(784, 50, 'relu_var1');
salida = layer(50, 10, 'softmax_var1');

test_model = model([capa1, salida]);

%%

train.SGD(test_model, train_imgs, train_labels, 0.2, 1, 25, 'cross entropy');

%%
figure()
test_model.plot_cost()
xlabel('epochs')
ylabel('cost')

figure()
test_model.plot_accuracy()
xlabel('epochs')
ylabel('accuracy')

%%
train.accuracy(test_model, test_imgs, test_labels)
