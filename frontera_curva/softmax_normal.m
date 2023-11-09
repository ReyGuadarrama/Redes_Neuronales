clearvars, clc, close all

% Extraccion de los datos desde un csv
[X0, t] = extractor('datos_lunas');

% Crear un mapa de colores para las clases
colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];

% Normalizacion de los datos
X_norm = normalizacion(X0, 'rango');

% Graficar los datos con colores según las clases
figure(1)
scatter(X0(1, :), X0(2, :), 30, t(1,:), 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2');  
title('Datos')


% creacion de una matriz de potencias de x
grado = 4;
x = polinomio(grado, X0);
x_norm = polinomio(grado, X_norm);

% inicializacion de parametros
w = randn(length(t(:,1)), length(x_norm(:,1)));
alpha = 0.01;

%% Entrenamiento de parametros

% definicion del numero de iteraciones
iteraciones = 10000;
valor_costo = zeros(1, iteraciones);

% Crea los limites de graficacion
x_min = min(x(2,:));
x_max = max(x(2,:));
y_min = min(x(3,:));
y_max = max(x(3,:));


for iteracion = 1:iteraciones

    % Actualizacion de parametros
    w = w - alpha*derivada(w, x_norm, t);

    valor_costo(iteracion) = costo(w, x_norm, t);
end

figure(2)
plot(valor_costo);
xlabel('iteraciones');
ylabel('valor del costo'); 
title('Costo vs iteraciones')

%%

% Calcula la presicion de los parametros entrenados
predict = hipotesis(w, x_norm);
prec = precision(w, x_norm, t);

for i = 1:2

    % Crea los datos objetivo de la clase en turno
    T = t(i,:);

    % Crea una cuadricula en el plano xy 
    w1 = linspace(x_min, x_max, 100);
    w2 = linspace(y_min, y_max, 100);
    w1_n = normalizacion(w1, 'rango');
    w2_n = normalizacion(w1, 'rango');
    [X, Y] = meshgrid(w1_n, w2_n);

    % Calcula la presicion de los parametros entrenados
    p = predict(i,:) > 0.5;
    prec_i = sum(p == T) / length(p);
    
    % Evaluacion del costo en cada uno de puntos de la cuadricula
    P = zeros(100, 100);                                                          
      
    for j = 1:length(X)^2
        P0 = hipotesis(w,polinomio(grado, [X(j), Y(j)].'));   
        P(j) = P0(i);
    end
 
    % Grafica la frontera de decision
    figure(3)
    subplot(1, 2, i);
    mesh(w1, w2, P)
    hold on
    scatter3(x(2,:), x(3, :), T+1, 10, T-2, 'filled');
    hold off
    view([0, 0, 1])
    xlim([x_min, x_max]), ylim([y_min, y_max]);
    title(['Precisión  ', num2str(prec_i)])
    
end

%%


P = zeros(100, 100);

for j = 1:length(X)^2
    P(j) = predictor(w ,polinomio(grado, [X(j), Y(j)].'));             
end

T = predictor(w, x_norm);

% Grafica la frontera de decision 
colormap_custom = [0.482353 0.847059 0.270588; 0.992157 0.933333 0.164706; 
                   0 0.14902 0.788235; 0.12549 0.647059 0.992157];

figure(5)
mesh(w1, w2, P)
hold on
scatter3(x(2,:), x(3, :), T + 2, 25, T + 2, "filled")
colormap(colormap_custom); 
hold off
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('Frontera de decision')
annotation('textbox', [0.7, 0.6, 0.3, 0.3], 'String', ['Precisión  ', num2str(prec)], 'FitBoxToText', 'on');

