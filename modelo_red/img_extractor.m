function [entr_imgs, entr_etiquetas, val_imgs, val_etiquetas, prueba_imgs, prueba_etiquetas] = img_extractor(path)

    % Guarda la direccion del directorio donde se encuentran las imagenes
    images_path = path;
    
    % Carga las imagenes con sus etiquetas dentro de un objeto imageDatastore
    digit_images = imageDatastore(images_path, 'IncludeSubfolders',true, 'LabelSource','foldernames');
    
    % Obtiene el numero de categorias unicas en los datos
    categorias = categories(digit_images.Labels); 
    
    num_categorias = numel(categorias);
    num_muestras = numel(digit_images.Labels);
    
    % Crea una matriz de etiquetas adecuadas para el entrenamiento
    category_matrix = zeros(num_categorias, num_muestras);
    
    for i = 1:num_categorias
        categoria = categorias{i};
        category_matrix(i, :) = double(digit_images.Labels == categoria);
    end
    
    
    % Crea una matriz con las imagenes de entrenamiento convertidas a vector
    % junto a sus etiquetas
    
    index = randperm(10000);
    
    entr_imgs = zeros(784, 7000);
    entr_etiquetas = zeros(num_categorias, 7000);
    
    for dato = 1:6000
        %label = digit_images.Labels(dato);
    
        % Obtiene la matriz de la imagen y la convierte en vector
        img = readimage(digit_images, index(dato));
        img_vector = reshape(img, [], 1);
        entr_imgs(:, dato) = img_vector;
    
        % Obtiene la etiqueta correspondiente a la imagen
        etiqueta = category_matrix(:, index(dato));
        entr_etiquetas(:, dato) = etiqueta;
    
    end
    
    % Crea una matriz con las imagenes de validación convertidas a vector
    % junto a sus etiquetas
    
    val_imgs = zeros(784, 3000);
    val_etiquetas = zeros(num_categorias, 3000);
    
    for dato = 6001:8000
    
        % Obtiene la matriz de la imagen y la convierte en vector
        img = readimage(digit_images, index(dato));
        img_vector = reshape(img, [], 1);
        val_imgs(:,dato - 6000) = img_vector;
    
        % Obtiene la etiqueta correspondiente a la imagen
        etiqueta = category_matrix(:, index(dato));
        val_etiquetas(:,dato - 6000) = etiqueta;
    
    end

    % Crea una matriz con las imagenes de prueba convertidas a vector
    % junto a sus etiquetas
    
    prueba_imgs = zeros(784, 3000);
    prueba_etiquetas = zeros(num_categorias, 3000);
    
    for dato = 8001:10000
    
        % Obtiene la matriz de la imagen y la convierte en vector
        img = readimage(digit_images, index(dato));
        img_vector = reshape(img, [], 1);
        prueba_imgs(:,dato - 8000) = img_vector;
    
        % Obtiene la etiqueta correspondiente a la imagen
        etiqueta = category_matrix(:, index(dato));
        prueba_etiquetas(:,dato - 8000) = etiqueta;
    
    end

    % Muestra algunos de los datos
    ind = randperm(1000, 20);
    
    figure()
    for i = 1:20
        subplot(4, 5, i)
        img = uint8(reshape(entr_imgs(:,ind(i)), 28, 28));
        imshow(img, 'Border', 'tight', 'InitialMagnification', 'fit')
    end
    
end
