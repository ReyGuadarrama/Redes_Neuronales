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
w = randn(1, 3);
alpha = 0.1;

%%
% definicion del numero de iteraciones
iteraciones = 30;
w_entrenados = ones(4, 3);
prec = zeros(1, 4);

% Crea los limites de graficacion
x_min = min(x(2,:));
x_max = max(x(2,:));
y_min = min(x(3,:));
y_max = max(x(3,:));

for i = 1:4

    % Crea los datos objetivo de la clase en turno
    T = t(i,:);

    for iteracion = 1:iteraciones
    
        % Actualizacion de parametros
        w = w - alpha*derivada(w, x, T);
    end
    
    % Guarda los parametros entrenados 
    w_entrenados(i, :) = w;

    % Calcula la presicion de los parametros entrenados
    prec(i) = precision(w, x, T);

    % Crea una cuadricula en el plano xy 
    w1 = linspace(x_min, x_max, 100);
    w2 = linspace(y_min, y_max, 100);
    [X, Y] = meshgrid(w1, w2);
    
    
    % Evaluacion del costo en cada uno de puntos de la cuadricula
    P = zeros(100, 100);                                                          
      
    for j = 1:length(X)^2
        P(j) = hipotesis(w,[1, X(j), Y(j)].');             
    end
 
    % Grafica la frontera de decision
    figure(2)
    subplot(2, 2, i);
    mesh(w1, w2, P)
    hold on
    scatter3(x(2,:), x(3, :), T+1, 10, T-2, 'filled');
    hold off
    view([0, 0, 1])
    xlim([x_min, x_max]), ylim([y_min, y_max]);
    title(['Precisión  ', num2str(prec(i))])
    
end

%%

F = zeros(100, 100);

for j = 1:length(X)^2
    F(j) = predictor(w_entrenados ,[1, X(j), Y(j)].');             
end

T = predictor(w_entrenados, x);

% Grafica la frontera de decision 
colormap_custom = [0.988235 0.454902 0.890196; 0.929412 0.0823529 0.647059; 
                   0.933333 0.556863 0.631373; 0.960784 0.760784 0.8;
                   0.270588 0.54902 0.972549; 0 0.0980392 0.988235;
                   0.0823529 0.796078 0.929412; 0.0823529 0.929412 0.827451];

figure(3)
mesh(w1, w2, F)
hold on
scatter3(x(2,:), x(3, :), T + 4, 10, T + 4, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Frontera de decision')

