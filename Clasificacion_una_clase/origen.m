clc, clearvars, close all

% Extrae dos clases de classdata_set
[x, T] = extractor(3, 4);

% Grafica las dos clases extraidas
figure(1)
subplot(1, 2, 1)
plot(x(1, :), x(2, :), '+')
title('Muestras sin desplazar')

% Modifica los datos para que la frontera de decision pase por el origen
x(2,:) = x(2,:) - 0.5;

% Grafica las dos clases modificadas
subplot(1, 2, 2)
plot(x(1, :), x(2, :), '+')
title('Muestras desplazadas')

% inicializacion de coeficientes y parametro de aprendizaje
w = randn(1, 2);
alpha = 0.1;

%%

% Crea una cuadricula en el plano xy 
w0 = linspace(-50, 50, 60);
w1 = linspace(-50, 50, 60);
[W0, W1] = meshgrid(linspace(-50, 50, 60), linspace(-50, 50, 60));

% Evaluacion del costo en cada uno de puntos de la cuadricula
C = zeros(60, 60);                                                          

for i = 1:length(W1)^2
    C(i) = costo([W0(i), W1(i)], x, T);             
end


%%

% definicion del numero de iteraciones
iteraciones = 20;
valor_costo = zeros(1,iteraciones);
figure(2)

for iteracion = 1:iteraciones

    % Grafica el valor del costo en la superficie de la funcion de costo
    mesh(W0, W1, C)
    view([27, -50, 20])
    hold on
    plot3(w(1), w(2), costo(w, x, T), 'r.', MarkerSize=25)
    hold off
    title('Descenso del costo')
    xlabel('W0'), ylabel('W1'), zlabel('funcion de costo')
    legend('costo', ['iteración ' num2str(iteracion)]);

    % Actualizacion de parametros
    valor_costo(iteracion) = costo(w, x, T);
    w = w - alpha*derivada(w, x, T);

    pause(0.1)
end

% Grafica el costo vs las iteraciones
figure(3)
plot(1:iteraciones, valor_costo)

%%

% Define los límites de graficacion
x_min = min(x(1,:)) - 0.2;
x_max = max(x(1,:)) + 0.2;
y_min = min(x(2,:)) - 0.2;
y_max = max(x(2,:)) + 0.2;

% Crea una cuadricula en el plano xy 
x1 = linspace(x_min, x_max, 100);
y1 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(x1, y1);

% Evaluacion del costo en cada uno de puntos de la cuadricula
P = zeros(100, 100);                                                          

for i = 1:length(X)^2
    P(i) = hipotesis(w,[X(i), Y(i)].');             
end

figure(4)
subplot(1, 2, 1);
mesh(x1, y1, P)
xlim([x_min, x_max]), ylim([y_min, y_max]);
view([0, 0, 1]);
title('frontera de decision')

subplot(1, 2, 2);
plot(x(1, :), x(2, :), '+')
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('muestras desplazadas')
