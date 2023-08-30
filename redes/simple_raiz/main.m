% Declaracion de variables

clc, clearvars, close all

x_0 = 1:10;
w_0 = randi([-10, 10]);
T = [2.3, 3.1, 5.8, 9.1, 8.9, 12.5, 14.6, 15.1, 19.6, 20.4];
alpha = 0.01;

%%

W = linspace(-10, 10);
C = zeros(1, 100);

for i = 1:length(W)
    C(i) = funcion_costo(x_0, W(i));
end

%%

% iterations

numero_iteraciones = 50;
costo = zeros(1, numero_iteraciones);
figure(1)

for iteracion = 1:numero_iteraciones

    costo(iteracion) = funcion_costo(x_0, w_0);
 
    % plotting fitline
    subplot(1, 3, 1)
    plot(x_0, T, 'o', x_0, hipotesis(w_0, x_0), '-');
    title(['Iteración ' num2str(iteracion)]);
    xlabel('X'), ylabel('T')
    legend('Datos', 'Ajuste lineal');

    % plotting cost vs iterations
    subplot(1, 3, 2)
    plot(costo);
    title('Valor de la funcion de costo vs iteraciones');
    xlabel('iteraciones'), ylabel('función de costo');
    legend('costo');

    % plotting cost vs W0
    subplot(1, 3, 3)
    plot(w_0, costo(iteracion), 'mv', W, C, 'b-')
    title('iteration jumps')
    xlabel('W_0'), ylabel('función de costo')
    legend('costo', ['iteración ' num2str(iteracion)]);

    % actualizacion de parametros

    costo = funcion_costo(hipotesis(w_0, x_0), T);
    derivada_w0 = costo_derivada_w0(w_0, x_0, T);

    w_0 = w_0 - (alpha * derivada_w0);
    
   
    pause(0.1)
end


