clc, clearvars, close all

% Extrae dos clases de classdata_set
[x, T] = extractor(2, 4);

% Modifica los datos para que la frontera de decision pase por el origen
x(1,:) = x(1,:) - 0.5;
x(2,:) = x(2,:) - 1;

% inicializacion de coeficientes y parametro de aprendizaje
w = [randi([-10, 10]), randi([85, 95])];
alpha = 0.1;
beta = 0.9;
v = 0;


%%

% Crea una cuadricula en el plano xy 
[W0, W1] = meshgrid(linspace(-50, 250, 150), linspace(-150, 150, 150));

% Evaluacion del costo en cada uno de puntos de la cuadricula
C = zeros(150, 150);                                                          

for i = 1:length(W1)^2           
    C(i) = costo([W0(i), W1(i)]); 
end


%%

% definicion del numero de iteraciones
iteraciones = 100;
valor_costo = zeros(1,iteraciones);
figure(2)

for iteracion = 1:iteraciones

    % Grafica el valor del costo en la superficie de la funcion de costo
    mesh(W0, W1, C)
    view([20, -50, 120])
    hold on
    plot3(w(1), w(2), costo(w) + 20, 'r.', MarkerSize=35) 
    hold off
    title('Descenso del costo')
    xlabel('W0'), ylabel('W1'), zlabel('funcion de costo')
    legend('costo', ['iteración ' num2str(iteracion)]);

    % Actualizacion de parametros
    valor_costo(iteracion) = costo(w); 
    w = w - alpha*derivada(w);
    %v = v * beta + alpha * derivada(w);
    %w = w - v;

    pause(0.1)
end

% Grafica el costo vs las iteraciones
figure(3)
plot(1:iteraciones, valor_costo)

%%

% Define los límites de graficacion
x_min = min(x(1,:));
x_max = max(x(1,:));
y_min = min(x(2,:));
y_max = max(x(2,:));

% Crea una cuadricula en el plano xy 
x1 = linspace(x_min, x_max, 100);
y1 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(x1, y1);

% Evaluacion del costo en cada uno de puntos de la cuadricula
P = zeros(100, 100);                                                          

for i = 1:length(X)^2
    P(i) = hipotesis(w ,[X(i), Y(i)].');             
end

figure(4)
mesh(x1, y1, P)
hold on
scatter3(x(1,:), x(2, :), T+1, 10, T-2, "filled")
hold off
xlim([x_min, x_max]), ylim([y_min, y_max]);
view([0, 0, 1]);
title('frontera de decision')



