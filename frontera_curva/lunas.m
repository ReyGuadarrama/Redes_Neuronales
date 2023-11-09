clearvars, clc, close all

% Cargar los datos desde el archivo CSV
data = readmatrix('datos_lunas.csv');

% Dividir los datos en características X y etiquetas t
X = data(1:2,:);
t = data(3,:);

% Crear un mapa de colores para las clases
colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];

% Graficar los datos con colores según las clases
scatter(X(1, :), X(2, :), 50, t, 'filled');
colormap(colormap_custom); 
xlabel('Característica 1');
ylabel('Característica 2');