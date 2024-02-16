function [x, t] = extractor(archivo)

    % Cargar los datos desde el archivo CSV
    data = readmatrix(archivo);

    % Dividir los datos en características X y etiquetas t
    n_caracteristicas = length(data(:,1)) - 1;
    X = data(1:n_caracteristicas,:);
    x = normalizacion(X);
    t = data(end,:);

    % Crear un mapa de colores para las clases
    colormap_custom = [0.533333 0.270588 0.847059; 0.929412 0.0823529 0.647059];
    
    % Graficar los datos con colores según las clases
    scatter(x(1, :), x(2, :), 50, t, 'filled');
    colormap(colormap_custom); 
    xlabel('Característica 1');
    ylabel('Característica 2'); 
    title('Datos')

end