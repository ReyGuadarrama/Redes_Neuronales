clearvars, clc, close all

% Cargar los datos desde el archivo CSV
[X0, t] = extractor('datos_lunas_3D.csv');

% Normalizacion de los datos
X_norm = normalizacion(X0, 'rango');

% Crear un mapa de colores para las clases
colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];

% Graficar los datos con colores según las clases
scatter3(X0(1, :), X0(2, :), X0(3, :), 40, t(1,:), 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2');
zlabel('Característica 3');

% creacion de una matriz de potencias de x
grado = 3;
x = polinomio(grado, X0);
x_norm = polinomio(grado, X_norm);

% inicializacion de parametros
w = randn(length(t(:,1)), length(x_norm(:,1)));
alpha = 0.01;

%% Entrenamiento de parametros

% definicion del numero de iteraciones
iteraciones = 3000;
valor_costo = zeros(1, iteraciones);

% Crea los limites de graficacion
x_min = min(X0(1,:));
x_max = max(X0(1,:));
y_min = min(X0(2,:));
y_max = max(X0(2,:));
z_min = min(X0(3,:)) - 1;
z_max = max(X0(3,:)) + 1;


for iteracion = 1:iteraciones

    % Actualizacion de parametros
    w = w - alpha*derivada(w, x_norm, t);

    valor_costo(iteracion) = costo(w, x_norm, t);
end

figure(2)
plot(valor_costo);

%%

% Calcula la presicion de los parametros entrenados
prec = precision(w, x_norm, t);

% Crear una malla 3D para visualizar la superficie
w1 = linspace(x_min, x_max, 100);
w2 = linspace(y_min, y_max, 100);
w3 = linspace(z_min, z_max, 100);
w1_n = normalizacion(w1, 'rango');
w2_n = normalizacion(w2, 'rango');
w3_n = normalizacion(w3, 'rango');
[X, Y, Z] = meshgrid(w1_n, w2_n, w3_n);

% Calcular las probabilidades para cada punto en la malla
P = zeros(100, 100, 100);                                                          

for plano = 1:length(Z)
    P_plano = zeros(100, 100);
    X1 = X(:,:,plano);
    Y1 = Y(:,:,plano);
    for j = 1:length(X)^2
        P0 = hipotesis(w,polinomio(grado, [X1(j), Y1(j), w3_n(plano)].'));   
        P_plano(j) = P0(1);
    end
    P(:,:,plano) = P_plano;
end 
%%

[X, Y, Z] = meshgrid(w1, w2, w3);

% Define un valor central y una "libertad" (tolerancia) alrededor del valor central
valor_central = 0.5;
libertad = 0.1;

% Encuentra los puntos en la cuadrícula que cumplen con la condición
condicion = P > (valor_central - libertad) & P < (valor_central + libertad);
frontera = [X(condicion), Y(condicion), Z(condicion)].'; 

% Visualizar la superficie de decisión
figure(2);
plot3(frontera(1,:), frontera(2,:), frontera(3,:), 'b.');
hold on
scatter3(X0(1, :), X0(2, :), X0(3, :), 40, t(1,:), 'filled');
colormap(colormap_custom);
hold off
xlabel('X1');
ylabel('X2');
zlabel('X3');
title('Frontera de Decisión 3D');


