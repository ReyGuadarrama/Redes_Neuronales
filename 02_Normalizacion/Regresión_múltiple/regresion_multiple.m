clearvars, clc, close all

% Importa los datos de un archivo de texto
data = load('datos1.txt');

% Inicializacion de caracteristicas
X = data(2:end,:);

% Inicializacion de datos objetivo
T = data(1,:);

% Inicializacion de parametros
W = randn(1, length(X(:,1)));
W_n1 = W;
W_n2 = W;

alpha = 0.001;


% Caracteristicas normalizadas

% Normalizacion con media y desviacion
X_n1 = ones(length(X(:,1)), length(X));

for fila = 2:length(X(:,1))
    X_n1(fila,:) = (X(fila,:) - mean(X(fila,:))) / std(X(fila,:));
end

% Normalizacion con rango x -> [-1, 1]
X_n2 = ones(length(X(:,1)), length(X));

for fila = 2:length(X(:,1))
    X_n2(fila,:) = 2 * ((X(fila,:) - min(X(fila,:))) / (max(X(fila,:)) - min(X(fila,:))) - 0.5);
end
 


%%

iteraciones = 100;
%valor_costo = zeros(1, iteraciones);
valor_costo_n1 = zeros(1, iteraciones);
valor_costo_n2 = zeros(1, iteraciones);

for iteracion = 1:iteraciones

    % Evaluacion de la funcion de costo
    %valor_costo(iteracion) = costo(W, X, T);
    valor_costo_n1(iteracion) = costo(W_n1, X_n1, T);
    valor_costo_n2(iteracion) = costo(W_n2, X_n2, T);
    
    % Actualizacion de parametros
    %W = W - alpha*derivada(W, X, T);
    W_n1 = W_n1 - alpha*derivada(W_n1, X_n1, T);
    W_n2 = W_n2 - alpha*derivada(W_n2, X_n2, T);

end

%%

%semilogy(1:iteraciones, valor_costo);


semilogy(1:iteraciones, valor_costo_n1);
hold on 
semilogy(1:iteraciones, valor_costo_n2);
hold off

legend('noramlizado mean', 'normalizado range')

