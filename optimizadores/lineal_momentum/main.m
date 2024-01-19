% Declaracion de variables

clc, clearvars, close all

x = 1:10;                                                               
w = randi([7, 10]);                                                    
T = pi*x;                
alpha = 0.001;    
beta = 0.9;
v = 0;

%%

w0 = linspace(-4, 11, 300);
C = zeros(1, 300);

for i = 1:300
    C(i) = funcion_costo(w0(i), x, T);
end

%%
% iterations

numero_iteraciones = 100;                                                   
valores_costo = zeros(1, numero_iteraciones);
figure(1)           

for iteracion = 1:numero_iteraciones


    % Graficacion de la busqueda del minimo de la funcion de costo
    plot(w0, C);
    hold on 
    plot(w, funcion_costo(w, x, T), 'r.', MarkerSize=20)    
    hold off
    xlim([-4, 11]), ylim([-500, 4000])


    % actualizacion de parametros
    
    costo = funcion_costo(w, x, T);               
    derivada_w0 = costo_derivada_w0(w, x, T);              

    w = w - (alpha * derivada_w0); 
    %v = beta * v + alpha * derivada_w0;
    %w = w - v;

    valores_costo(iteracion) = costo;                                     
   
    pause(0.1)
end

%%
figure(2)
plot(x, T, 'bo', x, hipotesis(w, x))
xlim([-1, 11]), ylim([-1, 40])
title('ajuste vs objetivo')
xlabel('X'), ylabel('T')
legend('Datos', 'Ajuste lineal');

% Graficacion del valor de la funcion de costo vs las iteraciones
figure(3)
plot(valores_costo);
title('Valor de la funcion de costo vs iteraciones');
xlabel('iteraciones'), ylabel('función de costo');
legend('costo');

