function acc = precision(x, T, modelo_entrenado)

    % Realiza la prediccion
    prob_matrix = predictor(x, modelo_entrenado);

    predict_matrix = prob_matrix == max(prob_matrix);

    matches = predict_matrix == T;

    results = sum(matches) == 10;

    acc = sum(results) / length(results);
    
end 