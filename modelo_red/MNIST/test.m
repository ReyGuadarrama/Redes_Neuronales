clc, clearvars, close all

% Permite utilizar las funciones definidas en el folder anterior
ant_dir =  fullfile(pwd, '..');
addpath(genpath(ant_dir));

% Extrae los datos de entrenamiento y de prueba
[train_imgs, train_labels, test_imgs, test_labels] = img_extractor(pwd);

%%

% Normalizacion de los datos
train_imgs = train_imgs ./ 255;
test_imgs = test_imgs ./ 255;

%%

salida = capa(784, 10, 'softmax');

M = modelo(train_imgs, {salida});

%%
epocas = 300;

E_NAG= entrenamiento_test(train_imgs, train_labels, M, epocas, 0.005, 'cross entropy', 'MBGD', 'NAG', 100);
E_MBGD = entrenamiento_test(train_imgs, train_labels, M, epocas, 0.005, 'cross entropy', 'MBGD', 'GD', 100);
E_SGD = entrenamiento_test(train_imgs, train_labels, M, epocas, 0.005, 'cross entropy', 'SGD', 'GD');


%%

acc_SGD = precision(test_imgs, test_labels, E_SGD);
acc_MBGD = precision(test_imgs, test_labels, E_MBGD);
acc_NAG = precision(test_imgs, test_labels, E_NAG);

figure()
plot(1:epocas, E_NAG.C, 1:epocas, E_SGD.C, 1:epocas, E_MBGD.C, 'LineWidth', 3);
legend('Nesterov Accelerated Gradient', 'Stochastic Gradient Descent', 'Mini Batch Gradient Descent') 
annotation('textbox', [0.3, 0.6, 0.5, 0.2], 'String', acc_NAG, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');
annotation('textbox', [0.3, 0.7, 0.5, 0.2], 'String', acc_SGD, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');
annotation('textbox', [0.3, 0.8, 0.5, 0.2], 'String', acc_MBGD, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');


%%
n = 7;
pred = predictor(test_imgs(:,n), E_SGD);
num_pred = find(pred == max(pred)) - 1;
 

figure()
img = reshape(test_imgs(:,n), 28, 28);
imshow(img, 'Border', 'tight', 'InitialMagnification', 'fit')
annotation('textbox', [0.2, 0.7, 0.3, 0.2], 'String', num_pred, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');



