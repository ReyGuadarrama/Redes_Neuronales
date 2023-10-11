clc, clearvars, close all

% Extrae dos clases de classdata_set
[x, t] = extractor(1, 4);
% Grafica las dos clases extraidas
plot(x(1, :), x(2, :), '+')

% Crea un vector con los valores objetivo
T = t(1,:);

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
figure(1)

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

    pause(1)
end

% Grafica el costo vs las iteraciones
figure(2)
plot(1:iteraciones, valor_costo)