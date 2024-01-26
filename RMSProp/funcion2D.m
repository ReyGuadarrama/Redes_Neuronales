function [F, DF] = funcion2D(w)
    % Devuelve el valor de la funcion y el valor de su derivada en un punto

    F = (w - 3).^2 + 50 * sin(w - 0.5) + 4;
    DF = 2 * (w - 3) + 50 * cos(w -0.5);

end