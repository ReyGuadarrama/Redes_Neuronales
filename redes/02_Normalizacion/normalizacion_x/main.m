% Declaracion de variables

clc, clearvars, close all

% Inicializacion de parametros y valores objetivo
x_0 = ones(1, 10);                                                          
x_1 = 1:10;                                                                 
w_0 = randi([-10, 10]);                                                     
w_1 = randi([-10, 10]);                                                     
w_2 = randi([-10, 10]);                                                    
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];                
alpha = 0.001;   

% inicializacion de valores wi auxiliares
w_0_n = w_0;
w_1_n = w_1;
w_2_n = w_2;


%% Iteraciones sin normalizacion


numero_iteraciones = 1000;                                                   
valores_costo = zeros(1, numero_iteraciones);
valores_costo_n = zeros(1, numero_iteraciones);
figure(1)           

for iteracion = 1:numero_iteraciones

 
    % Graficacion del ajuste vs los datos objetivo funcion sin normalizar
    subplot(1, 2, 1)
    plot(x_1, T, 'bo', x_1, hipotesis(w_0, w_1, w_2, x_0, x_1))
    title('ajuste vs objetivo')
    xlabel('X'), ylabel('T')
    legend('Datos', 'Ajuste lineal');

    % Actualizacion de parametros no normalizados
    costo = funcion_costo(hipotesis(w_0, w_1, w_2, x_0, x_1), T);           
    derivada_w0 = costo_derivada_w0(w_0, w_1, w_2, x_0, x_1, T);            
    derivada_w1 = costo_derivada_w1(w_0, w_1, w_2, x_0, x_1, T);
    derivada_w2 = costo_derivada_w2(w_0, w_1, w_2, x_0, x_1, T);

    w_0 = w_0 - (alpha * derivada_w0);                                    
    w_1 = w_1 - (alpha * derivada_w1);                                     
    w_2 = w_2 - (alpha * derivada_w2);                                      

    valores_costo(iteracion) = costo; 

    % Graficacion del ajuste vs los datos objetivo funcion normalizada
    subplot(1, 2, 2)
    plot(x_1, T, 'ro', x_1, hipotesis(w_0_n, w_1_n, w_2_n, x_0, x_1))
    title('ajuste vs objetivo normalizados')
    xlabel('X'), ylabel('T')
    legend('Datos', ['Ajuste lineal iteracion ' num2str(iteracion)]);

    % actualizacion de parametros normalizados
    
    costo_n = funcion_costo(hipotesis(w_0_n, w_1_n, w_2_n, x_0, x_1), T);           
    n_derivada_w0 = norm_derivada_w0(w_0_n, w_1_n, w_2_n, x_0, x_1, T);
    n_derivada_w1 = norm_derivada_w1(w_0_n, w_1_n, w_2_n, x_0, x_1, T);
    n_derivada_w2 = norm_derivada_w2(w_0_n, w_1_n, w_2_n, x_0, x_1, T);

    w_0_n = w_0_n - (alpha * n_derivada_w0);                                    
    w_1_n = w_1_n - (alpha * n_derivada_w1);                                     
    w_2_n = w_2_n - (alpha * n_derivada_w2);                                      

    valores_costo_n(iteracion) = costo_n;                                      
   
    pause(0.001)
end

% Graficacion del valor de la funcion de costo vs las iteraciones
figure(2)
subplot(1, 2, 1)
loglog(valores_costo);
title('Valor de la funcion de costo vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');

subplot(1, 2, 2)
loglog(valores_costo_n);
title('Valor de la funcion de costo normalizada vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');