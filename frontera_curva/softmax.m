clearvars, clc, close all

% Extraccion de los datos desde un csv
[X0, t] = extractor('datos_circulos.csv');

% Crear un mapa de colores para las clases
colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];

% Graficar los datos con colores según las clases
scatter(X0(1, :), X0(2, :), 50, t(1,:), 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2'); 
title('Datos')

% creacion de una matriz de potencias de x
grado = 2;
x = polinomio(grado, X0);

% inicializacion de parametros
w = randn(length(t(:,1)), length(x(:,1)));
alpha = 0.001;

%%
% definicion del numero de iteraciones
iteraciones = 3000;
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

figure(2)
plot(valor_costo);
xlabel('iteraciones');
ylabel('valor del costo'); 
title('Costo vs iteraciones')
%%

% Calcula la presicion de los parametros entrenados
predict = hipotesis(w, x);
prec = precision(w, x, t);

for i = 1:2

    % Crea los datos objetivo de la clase en turno
    T = t(i,:);

    % Crea una cuadricula en el plano xy 
    w1 = linspace(x_min, x_max, 100);
    w2 = linspace(y_min, y_max, 100);
    [X, Y] = meshgrid(w1, w2);

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

%% Ecuacion de la frontera de decision

% Define un valor central y una "libertad" (tolerancia) alrededor del valor central
valor_central = 0.5;
libertad = 0.01;

% Encuentra los puntos en la cuadrícula que cumplen con la condición
condicion = P > (valor_central - libertad) & P < (valor_central + libertad);
frontera = [X(condicion), Y(condicion)].';

% Determinacion de la ecuacion de la frontera de decision
ajuste = polyfit(frontera(1,:), frontera(2,:), grado);

% Crear una cadena de texto con la ecuación del ajuste
ecuacion = generar_ecuacion(ajuste);

%Graficacion
x1 = linspace(x_min, x_max);
y1 = polyval(ajuste,x1);

figure(4)
plot(x1, y1, 'LineWidth',3);
hold on
scatter(X0(1, :), X0(2, :), 50, t(1,:), 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2'); 
title('Frontera de decision')

% Agregar un cuadro de texto con fondo blanco para la ecuación
annotation('textbox', [0.15, 0.7, 0.3, 0.2], 'String', ecuacion, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');

hold off
xlim([x_min, x_max]), ylim([y_min, y_max])

%%

% Crea una cuadricula en el plano xy 
w1 = linspace(x_min, x_max, 100);
w2 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(w1, w2);

P = zeros(100, 100);

for j = 1:length(X)^2
    P(j) = predictor(w ,polinomio(grado, [X(j), Y(j)].'));             
end

T = predictor(w, x);

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
annotation('textbox', [0.7, 0.6, 0.3, 0.3], 'String', ['Precisión  ', num2str(prec)], 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black');




   



