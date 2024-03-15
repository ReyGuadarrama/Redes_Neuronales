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

SGD_model = model([capa1, salida]);
Momentum_model = model([capa1, salida]);

%%

train.SGD(SGD_model, train_imgs, train_labels, 0.1, 100, 40, 'cross entropy');


train.SGDMomentum(Momentum_model, train_imgs, train_labels, 0.1, 0.9, 100, 40, 'cross entropy');

%%
figure()
SGD_model.plot_cost()
hold on
Momentum_model.plot_cost()
hold off
legend('SGD', 'SGD momentum')
xlabel('epochs')
ylabel('cost')

figure()
SGD_model.plot_accuracy()
hold on
Momentum_model.plot_accuracy()
hold off
legend('SGD', 'SGD momentum')
xlabel('epochs')
ylabel('accuracy')