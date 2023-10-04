clearvars, clc, close all

% Declaracion de caracteristicas

X = [1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000    1.0000;
     1.7400    6.3200    6.2200   10.5200    1.1900    1.2200    4.1000    6.3200    4.0800    4.1500   10.1500    1.7200    1.7000;
     5.3000    5.4200    8.4100    4.6300   11.6000    5.8500    6.6200    8.7200    4.4200    7.6000    4.8300    3.1200    5.3000;
    10.8000    9.4000    7.2000    8.5000    9.4000    9.9000    8.0000    9.1000    8.7000    9.2000    9.4000    7.6000    8.2000];

% Caracteristicas normalizadas

X_n1 = ones(4, length(X));

for fila = 2:4
    X_n1(fila,:) = (X(fila,:) - mean(X(fila,:))) / std(X(fila,:));
end

X_n2 = ones(4, length(X));

for fila = 2:4
    X_n2(fila,:) = (X(fila,:) - min(X(fila,:))) / (max(X(fila,:)) - min(X(fila,:)));
end
 
% Declaracion de valores objetivo

T = [25.5000   31.2000   25.9000   38.4000   18.4000   26.7000   26.4000   25.9000   32.0000   25.2000   39.7000   35.7000   26.5000];

% Declaracion de parametros

W = randn(1, 4);
W_n1 = W;
W_n2 = W;

alpha = 0.01;

%%



%%

iteraciones = 100;
valor_costo = zeros(1, iteraciones);
valor_costo_n1 = zeros(1, iteraciones);
valor_costo_n2 = zeros(1, iteraciones);

for iteracion = 1:iteraciones

    % Evaluacion de la funcion de costo
    valor_costo(iteracion) = costo(W, X, T);
    valor_costo_n1(iteracion) = costo(W_n1, X_n1, T);
    valor_costo_n2(iteracion) = costo(W_n2, X_n2, T);
    
    % Actualizacion de parametros
    W = W - alpha*derivada(W, X, T);
    W_n1 = W_n1 - alpha*derivada(W_n1, X_n1, T);
    W_n2 = W_n2 - alpha*derivada(W_n2, X_n2, T);

end

%%

semilogy(1:iteraciones, valor_costo);

hold on 
semilogy(1:iteraciones, valor_costo_n1);
semilogy(1:iteraciones, valor_costo_n2);
hold off

legend('no normalizado', 'noramlizado mean', 'normalizado range')

