% Extrae dos clases de classdata_set
[X, T] = extractor(1, 4);

x = ones(3, length(X(1,:)));

% Crea la matriz de muestras
for i = 2:3
    x(i,:) = X(i-1,:);
end

% Grafica las dos clases extraidas
figure(1)
plot(x(2, :), x(3, :), '+')
grid on
title('muestras')

% inicializacion de coeficientes y parametro de aprendizaje
w = randn(1, 3);
alpha = 0.05;

% definicion del numero de iteraciones
iteraciones = 50;
valor_costo = zeros(1,iteraciones);

for iteracion = 1:iteraciones

    % Actualizacion de parametros
    valor_costo(iteracion) = costo(w, x, T);
    w = w - alpha*derivada(w, x, T);

end


% Grafica el costo vs las iteraciones
figure(3)
plot(1:iteraciones, valor_costo)

% Define los límites de graficacion
x_min = min(x(2,:)) - 0.5;
x_max = max(x(2,:)) + 0.5;
y_min = min(x(3,:)) - 0.5;
y_max = max(x(3,:)) + 0.5;

% Crea una cuadricula en el plano xy 
w1 = linspace(x_min, x_max, 100);
w2 = linspace(y_min, y_max, 100);
[X, Y] = meshgrid(w1, w2);


% Evaluacion del costo en cada uno de puntos de la cuadricula
P = zeros(100, 100);                                                          
  
for i = 1:length(X)^2
    P(i) = hipotesis(w,[1, X(i), Y(i)].');             
end

figure(4)
subplot(1, 2, 1);
mesh(w1, w2, P)
view([0, 0, 1])
xlim([x_min, x_max]), ylim([y_min, y_max]);
title('frontera de decision')

subplot(1, 2, 2);
plot(x(2, :), x(3, :), '+')
title('muestras')
grid on