function [F, DFw1, DFw2] = funcion3D(w1, w2)
    % Devuelve el valor de la funcion y el valor de su derivada en un punto

    F = (w1 - 3).^2 + 50 * sin(w1 - 0.5) + (w2 - 3).^2 + 50 * sin(w2 - 0.5) + 8;
    DFw1 = 2 * (w1 - 3) + 50 * cos(w1 - 0.5);
    DFw2 = 2 * (w2 - 3) + 50 * cos(w2 - 0.5);

end