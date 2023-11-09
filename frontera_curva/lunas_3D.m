clearvars, clc, close all

% Cargar los datos desde el archivo CSV
[X, t] = extractor('datos_lunas_3D.csv');

% Crear un mapa de colores para las clases
colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];

% Graficar los datos con colores según las clases
scatter3(X(1, :), X(2, :), X(3, :), 40, t(1,:), 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2');
zlabel('Característica 3');