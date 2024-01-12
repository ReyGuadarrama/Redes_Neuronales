function P = red(w, x)
    % Separa los w para las distintas capas
    w_1 = w(1:2,:);
    w_2 = w(3,:);
    
    % Capa de entrada
    z_1 = x;
    a_1 = activacion(z_1, 'lineal');

    % Capa oculta
    z_2 = neurona(w_1, a_1);
    a_2 = activacion(z_2, 'relu');

    % Capa de salida
    z_3 = neurona(w_2', a_2')';
    P = activacion(z_3, 'lineal');

end