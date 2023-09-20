clc, clearvars, close all

x = linspace(0, 4*pi, 100);
x_norm = (x-mean(x))/std(x);
T = sin(x);
w = [6, 2, 4, 5, 7, 5, 8];
alpha = 0.0001;

%%

for i = 1:100000
    derivada = derivada_w_norm(w, x, T);
    w = w - alpha*derivada;
end

%%
 
plot(x, hipotesis_norm(w, x), 'r');
    hold on
    plot(x, T, 'bo')
    xlim([-2, 14]), ylim([-2, 2])
    hold off
%%
iteraciones = 1000000;
figure(1)
cost = zeros(1, iteraciones);

for iteracion = 1:iteraciones/20000

    plot(x, hipotesis_norm(w, x), 'r');
    hold on
    plot(x, T, 'bo')
    xlim([-2, 14]), ylim([-2, 2])
    hold off

    for i = 1:20000
    derivada = derivada_w_norm(w, x, T);
    w = w - alpha*derivada;
    cost(iteracion) = costo(w, x, T);
    end
   
    pause(0.001)
end

%%

iteraciones = 1000000;
figure(1)
cost = zeros(1, iteraciones);

for iteracion = 1:iteraciones/20000

    plot(x, hipotesis_norm(w, x), 'r');
    hold on
    plot(x, T, 'bo')
    xlim([-2, 14]), ylim([-2, 2])
    hold off

    for i = 1:20000
    derivada = derivada_w(w, x_norm, T);
    w = w - alpha*derivada;
    cost(iteracion) = costo(w, x_norm, T);
    end
   
    pause(0.001)
end



