clearvars, clc

seno = linspace(-1, 1, 100);
x = [ones(1, 100); seno];
T = sin(x(2,:)*2*pi);

neuronas = 1000;
w = randn(3, neuronas);
alpha = 0.001;

%%
iteraciones = 10000;
costo_valor = zeros(1, iteraciones);

for iteracion = 1:iteraciones
    costo_valor(iteracion) = costo(w, x, T); 
    w = w - derivada(w, x, T)*alpha;

   
end

figure(1)
pred = red_neuronal(w, x);
plot(x(2,:), pred, x(2,:), T)

figure(2)
plot(1:iteraciones, costo_valor)

