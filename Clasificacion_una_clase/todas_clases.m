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

% Crea los limites de graficacion
x_min = min(x(2,:)) - 0.2;
x_max = max(x(2,:)) + 0.2;
y_min = min(x(3,:)) - 0.2;
y_max = max(x(3,:)) + 0.2;

for i = 1:4

    % Crea los datos objetivo de la clase en turno
    T = t(i,:);

    for iteracion = 1:iteraciones
    
        % Actualizacion de parametros
        w = w - alpha*derivada(w, x, T);
    end
    
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
    view([0, 0, 1])
    xlim([x_min, x_max]), ylim([y_min, y_max]);
    title(['Frontera de decision clase ', num2str(i)])
    
end


