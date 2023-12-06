function DC_DW = derivada(w, x, T)
    
    % Separa las w para cada capa
    w_1 = w(1:2,:);
    w_2 = w(3,:);

    % Obtiene el numero de muestras y neuronas
    n_muestras = size(x, 2);

    % Pendiente de la activacion lineal
    m = 4;

    % Calcula las activaciones de cada capa
    z_1 = x;
    a_1 = activacion(z_1, 'lineal');

    z_2 = neurona(w_1, a_1);
    a_2 = activacion(z_2, 'relu');

    z_3 = neurona(w_2', a_2');
    P = activacion(z_3, 'lineal')';

    D_aux = repmat(P - T, 2, 1) .* z_1; 

    % Activacion lineal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % w2 = repmat(w_2, n_muestras, 1);
    % 
    % DC_DW1 = 2*m*(D_aux * w2)./n_muestras;

    % Activacion ReLu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Da2_Dz2 = z_2 > 0;
    Dz2_Dw1 = Da2_Dz2 .* repmat(w_2, n_muestras, 1);  

    % Calcula la derivada respecto a los omegas de la primera capa
    DC_DW1 = 2*(D_aux * Dz2_Dw1)./n_muestras;

    % Calcula la derivada respecto a los omegas de la segunda capa
    DC_DW2 = 2*((P - T)*a_2)./n_muestras;

    % Matriz de derivadas
    DC_DW = [DC_DW1; DC_DW2];
end