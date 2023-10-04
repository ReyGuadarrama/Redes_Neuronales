% Declaracion de variables

clc, clearvars, close all

% Inicializacion de parametros y valores objetivo
x_0 = ones(1, 10);                                                          
x_1 = 1:10;                                                                 
w_0 = randi([-10, 10]);                                                     
w_1 = randi([-10, 10]);                                                     
w_2 = randi([-10, 10]);                                                    
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];                
alpha = 0.01;   


%% Iteraciones sin normalizacion


numero_iteraciones = 500;                                                   
valores_costo = zeros(1, numero_iteraciones);
figure(1)           

for iteracion = 1:numero_iteraciones

 
    % Graficacion del ajuste vs los datos objetivo funcion
    plot(x_1, T, 'bo', x_1, hipotesis(w_0, w_1, w_2, x_0, x_1))
    title('ajuste vs objetivo')
    xlabel('X'), ylabel('T')
    legend('Datos', ['Ajuste lineal iteracion ' num2str(iteracion)]);

    % Actualizacion de parametros 
    costo = funcion_costo(hipotesis(w_0, w_1, w_2, x_0, x_1), T);           
    derivada_w0 = costo_derivada_w0(w_0, w_1, w_2, x_0, x_1, T);            
    derivada_w1 = costo_derivada_w1(w_0, w_1, w_2, x_0, x_1, T);
    derivada_w2 = costo_derivada_w2(w_0, w_1, w_2, x_0, x_1, T);

    w_0 = w_0 - (alpha * derivada_w0);                                    
    w_1 = w_1 - (alpha * derivada_w1);                                     
    w_2 = w_2 - (alpha * derivada_w2);                                      

    valores_costo(iteracion) = costo;                                  
   
    pause(0.001)
end

% Graficacion del valor de la funcion de costo vs las iteraciones
figure(2)
loglog(valores_costo);
title('Valor de la funcion de costo vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');
