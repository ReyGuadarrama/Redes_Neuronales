% Declaracion de variables

clc, clearvars, close all

x_0 = ones(1, 10);
x_1 = 1:10;
w_0 = randi([-10, 10]);
w_1 = randi([-10, 10]);
w_2 = randi([-10, 10]);
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];
%T = (T + x_1).^2;
alpha_0 = 0.002;
alpha_1 = 0.0002;
alpha_2 = 0.00002;


%%

% iterations

numero_iteraciones = 1000;
figure(1)

for iteracion = 1:numero_iteraciones
 
    % actualizacion de parametros

    costo = funcion_costo(hipotesis(w_0, w_1, w_2, x_0, x_1), T);
    derivada_w0 = costo_derivada_w0(w_0, w_1, w_2, x_0, x_1, T);
    derivada_w1 = costo_derivada_w1(w_0, w_1, w_2, x_0, x_1, T);
    derivada_w2 = costo_derivada_w2(w_0, w_1, w_2, x_0, x_1, T);

    w_0 = w_0 - (alpha_0 * derivada_w0);
    w_1 = w_1 - (alpha_1 * derivada_w1);
    w_2 = w_2 - (alpha_2 * derivada_w2);

    plot(x_1, T, 'bo', x_1, hipotesis(w_0, w_1, w_2, x_0, x_1))
    xlim([-1, 11]), ylim([-1, 30])

    pause(0.001)
end


