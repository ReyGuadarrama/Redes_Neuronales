clc, clearvars, close all

% Permite utilizar las funciones definidas en el folder anterior
ant_dir =  fullfile(pwd, '..');
addpath(genpath(ant_dir));

% Extrae los datos de entrenamiento y de prueba
dataFolder = fullfile(toolboxdir('nnet'),'nndemos','nndatasets','DigitDataset');
[train_imgs, train_labels, test_imgs, test_labels] = img_resize_extractor(dataFolder, [14, 14]);


% Normalizacion de los datos
train_imgs = train_imgs ./ 255;
test_imgs = test_imgs ./ 255;
%%

capa1 = layer(196, 50, 'relu_var1');
capa2 = layer(50, 30, 'relu_var1');
salida = layer(30, 10, 'softmax_var1');

test_model = model([capa1, capa2, salida]);

%%

train.SGD(test_model, train_imgs, train_labels, 0.1, 1, 15, 'cross entropy');


%%
figure()
test_model.plot_cost()
xlabel('epochs')
ylabel('cost')

figure()
test_model.plot_accuracy()
xlabel('epochs')
ylabel('accuracy')

train.accuracy(test_model, test_imgs, test_labels)
%%
n=4; 

figure()
img = reshape(train_imgs(:,n), 14, 14);
resized_img = imresize(img, [15, 15]);
imshow(resized_img, 'Border', 'tight', 'InitialMagnification', 'fit')

number = find(train_labels(:,n) == 1);
display(number - 1);