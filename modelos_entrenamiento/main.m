clearvars, clc, close all

% Extraccion de los datos desde un csv
[X0, t] = extractor('datos3.csv');

% creacion de una matriz de potencias de x
grado = 3;
x = polinomio(grado, X0);

% inicializacion de parametros
w = randn(length(t(:,1)), length(x(:,1)));
alpha = 0.01;

% definicion del numero de iteraciones
iteraciones = 1000;

[w_BGD, valor_costo_BGD] = batch_gradient_descent(w, x, t, alpha, iteraciones);
[w_SGD, valor_costo_SGD] = stochastic_gradient_descent(w, x, t, alpha, iteraciones);
[w_MBGD, valor_costo_MBGD] = minibatch_gradient_descent(w, x, t, alpha, iteraciones, 64);

% Graficacion de la funcion de costo vs iteraciones
figure(2)
plot(valor_costo_BGD, LineWidth=3);
hold on
plot(valor_costo_SGD, LineWidth=3);
plot(valor_costo_MBGD, LineWidth=3);
hold off
xlabel('iteraciones');
ylabel('valor del costo'); 
legend('BGD', 'SGD', 'MBGD');
title('Costo vs iteraciones');


%%
% Crea los limites de graficacion
x_min = min(x(2,:));
x_max = max(x(2,:));
y_min = min(x(3,:));
y_max = max(x(3,:));

% Crea una cuadricula en el plano xy 
w1 = linspace(x_min, x_max, 100);
w2 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(w1, w2);

P_BGD = zeros(100, 100);
P_SGD = zeros(100, 100);
P_MBGD = zeros(100, 100);

for j = 1:length(X)^2
    P_BGD(j) = predictor(w_BGD ,polinomio(grado, [X(j), Y(j)].'));    
    P_SGD(j) = predictor(w_SGD ,polinomio(grado, [X(j), Y(j)].'));
    P_MBGD(j) = predictor(w_MBGD ,polinomio(grado, [X(j), Y(j)].'));
end

% Calcula la presicion de los parametros entrenados
prec_BGD = precision(w_BGD, x, t);
prec_SGD = precision(w_SGD, x, t);
prec_MBGD = precision(w_MBGD, x, t);

% Grafica la frontera de decision 
colormap_custom = [0.482353 0.847059 0.270588; 0.992157 0.933333 0.164706; 
                   0 0.14902 0.788235; 0.12549 0.647059 0.992157];

figure(5)
subplot(1, 3, 1);
mesh(w1, w2, P_BGD)
hold on
scatter3(x(2,:), x(3, :), t(1,:) + 2, 25, t(1,:) + 3, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Batch Gradient Descent')
annotation('textbox',[0.278125,0.891173416933165,0.061458331656953,0.028037382651465], 'String', ['Precisión  ', num2str(prec_BGD)], 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');

subplot(1, 3, 2);
mesh(w1, w2, P_SGD)
hold on
scatter3(x(2,:), x(3, :), t(1,:) + 2, 25, t(1,:) + 3, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Stochastic Gradient Descent')
annotation('textbox',[0.557291666666666 0.893250260131505 0.0614583316569527 0.0280373826514647], 'String', ['Precisión  ', num2str(prec_SGD)], 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');

subplot(1, 3, 3);
mesh(w1, w2, P_MBGD)
hold on
scatter3(x(2,:), x(3, :), t(1,:) + 2, 25, t(1,:) + 3, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Mini-Batch Gradient Descent')
annotation('textbox',[0.838020833333332 0.891173416933166 0.0614583316569527 0.0280373826514647], 'String', ['Precisión  ', num2str(prec_MBGD)], 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');

   
  


