clearvars, clc, close all

% Inicializa las variables X y t con los datos de simpleclass_dataset
[X,t] = simpleclass_dataset;

% Crea la matriz de muestras
x = ones(3, length(X(1,:)));
for i = 2:3
    x(i,:) = X(i-1,:);
end

% Grafica las muestras
figure(1)
plot(x(2,:), x(3, :), 'bo')

% inicializacion de parametros
w = randn(length(t(:,1)), length(x(:,1)));
alpha = 0.01;

%%
% definicion del numero de iteraciones
iteraciones = 50;
valor_costo = zeros(1, iteraciones);

% Crea los limites de graficacion
x_min = min(x(2,:));
x_max = max(x(2,:));
y_min = min(x(3,:));
y_max = max(x(3,:));


for iteracion = 1:iteraciones

    % Actualizacion de parametros
    w = w - alpha*derivada(w, x, t);

    valor_costo(iteracion) = costo(w, x, t);
end

plot(valor_costo);
%%

% Crea una cuadricula en el plano xy 
w1 = linspace(x_min, x_max, 100);
w2 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(w1, w2);

P = zeros(100, 100);

for j = 1:length(X)^2
    P(j) = predictor(w ,[1, X(j), Y(j)].');             
end

T = predictor(w, x);

% Grafica la frontera de decision 
colormap_custom = [0.988235 0.454902 0.890196; 0.929412 0.0823529 0.647059; 
                   0.933333 0.556863 0.631373; 0.960784 0.760784 0.8;
                   0.270588 0.54902 0.972549; 0 0.0980392 0.988235;
                   0.0823529 0.796078 0.929412; 0.0823529 0.929412 0.827451];

figure(3)
mesh(w1, w2, P)
hold on
scatter3(x(2,:), x(3, :), T + 4, 10, T + 4, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Frontera de decision')
    
