% Declaracion de variables

clc, clearvars, close all

x_0 = ones(1, 10);                                                          % Inicializa un vector identidad  
x_1 = 1:10;                                                                 % inicializa un vector que contiene los valores del 1 al 10
w_0 = randi([-50, 50]);                                                     % inicializa el parametro w0 con un valor aleatorio
w_1 = randi([-50, 50]);                                                     % inicializa el parametro w0 con un valor aleatorio
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];                % Inicializa un vector con los valores objetivo T
alpha = 0.002;                                                              % Inicializa el coeficiente de aprendizaje  

%%
% Creacion de una matriz que contiene los valores de la funcion de costo
% para cada par de valores (w0, w1) en el rectangulo [-10, 10] x [-10, 10]

w0 = linspace(-50, 50, 60);                                                 % Inicializa dos vectores con 60 valores equidistantes desde -10 hasta 10
w1 = linspace(-50, 50, 60);

[W0, W1] = meshgrid(w0, w1);                                                % Inicializa una matriz con todas las combinaciones entre los vectores w0 y w1

C = zeros(60, 60);                                                          % Inicializa una matriz de ceros de 60 x 60

for i = 1:length(W1)^2
    C(i) = funcion_costo(hipotesis(W0(i), W1(i), x_0, x_1), T);             % Llena la C con los valores para cada par de valores (w0, w1)
end

%%

% iterations

numero_iteraciones = 300;                                                   % Define el numero de iteraciones
valores_costo = zeros(1, numero_iteraciones);
figure(1)           

for iteracion = 1:numero_iteraciones

 
    % Graficacion del ajuste vs los datos objetivo
    subplot(1, 2, 1)
    plot(x_1, T, 'bo', x_1, hipotesis(w_0, w_1, x_0, x_1))
    xlim([-1, 11]), ylim([-1, 25])
    title('ajuste vs objetivo')
    xlabel('X'), ylabel('T')
    legend('Datos', 'Ajuste lineal');

    % Graficacion de la busqueda del minimo de la funcion de costo
    subplot(1, 2, 2)
    mesh(W0, W1, C)
    view(100, 45)
    hold on
    plot3(w_0, w_1, funcion_costo(hipotesis(w_0, w_1, x_0, x_1), T), 'r.', MarkerSize=20)
    hold off
    title('Descenso del costo')
    xlabel('W_0'), ylabel('función de costo')
    legend('costo', ['iteración ' num2str(iteracion)]);

    % actualizacion de parametros
    
    costo = funcion_costo(hipotesis(w_0, w_1, x_0, x_1), T);                % inicializa variables con los valores para la funcion de costo y sus derivadas
    derivada_w0 = costo_derivada_w0(w_0, w_1, x_0, x_1, T);                 % parciales para el par de valores (w0, w1) correspodientes a la iteracion actual
    derivada_w1 = costo_derivada_w1(w_0, w_1, x_0, x_1, T);

    w_0 = w_0 - (alpha * derivada_w0);                                      % Actualiza el valor del parametro w0
    w_1 = w_1 - (alpha * derivada_w1);                                      % Actualiza el valor del parametro w0

    valores_costo(iteracion) = costo;                                       % Guarda el valor de la funcion de costo correspondiente a la iteracion actual
   
    pause(0.01)
end

% Graficacion del valor de la funcion de costo vs las iteraciones
figure(2)
plot(valores_costo);
title('Valor de la funcion de costo vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');

