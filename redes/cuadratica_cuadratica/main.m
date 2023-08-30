% Declaracion de variables

clc, clearvars, close all

x_0 = ones(1, 10);                                                          % Inicializa un vector identidad  
x_1 = 1:10;                                                                 % inicializa un vector que contiene los valores del 1 al 10
w_0 = randi([-10, 10]);                                                     % inicializa el parametro w0 con un valor aleatorio
w_1 = randi([-10, 10]);                                                     % inicializa el parametro w1 con un valor aleatorio
w_2 = randi([-10, 10]);                                                     % inicializa el parametro w2 con un valor aleatorio
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];                % Inicializa un vector con los valores objetivo T
alpha = 0.00001;                                                            % Inicializa el coeficiente de aprendizaje  


%%

% iterations

numero_iteraciones = 500;                                                   % Define el numero de iteraciones
valores_costo = zeros(1, numero_iteraciones);
figure(1)           

for iteracion = 1:numero_iteraciones

 
    % Graficacion del ajuste vs los datos objetivo
    plot(x_1, T, 'bo', x_1, hipotesis(w_0, w_1, w_2, x_0, x_1))
    title('ajuste vs objetivo')
    xlabel('X'), ylabel('T')
    legend('Datos', 'Ajuste lineal');

    % actualizacion de parametros
    
    costo = funcion_costo(hipotesis(w_0, w_1, w_2, x_0, x_1), T);           % inicializa variables con los valores para la funcion de costo y sus derivadas
    derivada_w0 = costo_derivada_w0(w_0, w_1, w_2, x_0, x_1, T);            % parciales para los valores (w0, w1, w2) correspodientes a la iteracion actual
    derivada_w1 = costo_derivada_w1(w_0, w_1, w_2, x_0, x_1, T);
    derivada_w2 = costo_derivada_w2(w_0, w_1, w_2, x_0, x_1, T);

    w_0 = w_0 - (alpha * derivada_w0);                                      % Actualiza el valor del parametro w0
    w_1 = w_1 - (alpha * derivada_w1);                                      % Actualiza el valor del parametro w1
    w_2 = w_2 - (alpha * derivada_w2);                                      % Actualiza el valor del parametro w2

    valores_costo(iteracion) = costo;                                       % Guarda el valor de la funcion de costo correspondiente a la iteracion actual
   
    pause(0.001)
end

% Graficacion del valor de la funcion de costo vs las iteraciones
figure(2)
loglog(valores_costo);
title('Valor de la funcion de costo vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');