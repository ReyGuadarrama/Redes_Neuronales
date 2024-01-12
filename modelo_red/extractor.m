function [x, t] = extractor(archivo)
    % Cargar los datos desde el archivo CSV
    data = readmatrix(archivo);
    
    % Dividir los datos en características X y etiquetas t
    n_caracteristicas = length(data(:,1)) - 1;
    x = data(1:n_caracteristicas,:);
    T = data(end,:);

    % Crea una matriz de etiquetas
    t = [T;1-T];

end