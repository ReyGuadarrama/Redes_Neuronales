function p = precision(w_entrenados, x, t)
    clases = predictor(w_entrenados, x);
    aciertos = 0;
    n_clases = length(t(:,1));
    if n_clases > 1 
        for i = 1:length(x(1,:))
            clase = clases(i);
            if t(clase, i) == 1
                aciertos = aciertos + 1;
            end
        end
    else
        for i = 1:length(x(1,:))
            if t(i) == clases(i) 
                aciertos = aciertos + 1;
            end
        end
    end

    p = aciertos / length(x(1,:));
end 