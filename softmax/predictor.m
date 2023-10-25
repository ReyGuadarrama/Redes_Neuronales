function prediccion = predictor(w_entrenados, x)
    porcentaje = hipotesis(w_entrenados, x);
    prediccion = zeros(1, length(x(1,:)));
    if length(porcentaje(:,1)) > 1
        for i = 1:length(x(1,:))
            clase = find(porcentaje(:, i) == max(porcentaje(:, i)));
            prediccion(i) = clase;
        end
    else
        for i = 1:length(x(1,:))
            if porcentaje(i) > 0.5
                prediccion(i) = 1;
            end
        end
    end
end