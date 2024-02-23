function mapa_prob(modelo_entrenado, t, titulo)

    % Inicializa un batch size de 100 por defecto
    if nargin < 3
        titulo = ''; 
    end 

    P = zeros(100, 100);

    % Obtiene la funcion de activacion de la ultima capa
    activacion_final = modelo_entrenado.a{end};

    % Define los límites de graficacion
    x = modelo_entrenado.P{1, 1};
    x_min = min(x(1,:));
    x_max = max(x(1,:));
    y_min = min(x(2,:));
    y_max = max(x(2,:));
    
    % Crea una cuadricula en el plano xy 
    w1 = linspace(x_min, x_max, 100);
    w2 = linspace(y_min, y_max, 100);
    [X, Y] = meshgrid(w1, w2);
    
    n_capas = size(modelo_entrenado.w, 2);
    
    capas = cell(1, n_capas);
    w = modelo_entrenado.w;
    b = modelo_entrenado.b;
    a = modelo_entrenado.a;
    
    for capa = 1:n_capas
        cap.w = w{capa};
        cap.b = b{capa};
        cap.a = a{capa};
        capas{capa} = cap;
    end
    
    % Calcula la probabilidad de cada punto en la cuadricula de pertener a
    % una u otra clase

    if strcmp(activacion_final, 'sigmoide')
        for i = 1:length(X)^2
            %temp1 = predictor([X(i), Y(i)]', capas);
            P(i) = predictor([X(i), Y(i)]', modelo_entrenado);          
        end

        figure;
  
        mesh(w1, w2, P)
        hold on
        scatter3(x(1,:), x(2, :), t+1, 10, t-2, "filled")
        hold off
        view([0, 0, 1])
        xlim([x_min, x_max]), ylim([y_min, y_max]);
        title(strcat('Mapa de probabilidad', titulo));

    elseif strcmp(activacion_final, 'softmax')

        % Obtiene el numero de clases
        clases = size(modelo_entrenado.P{end, end}, 1);

        figure;
        for clase = 1:clases
            for i = 1:length(X)^2
            temp1 = predictor([X(i), Y(i)]', capas);
            P(i) = temp1{end, end}(clase);             
            end


            subplot(clases / 2, 2, clase);
            mesh(w1, w2, P)
            hold on
            scatter3(x(1,:), x(2, :), t(clase,:)+1, 10, t(clase,:)-2, "filled")
            hold off
            view([0, 0, 1])
            xlim([x_min, x_max]), ylim([y_min, y_max]);
            title(strcat('Mapa de probabilidad', titulo));

        end
    end
end