clearvars, clc, close all

x = linspace(-15, 15, 200);
[f, df] = fun(x);

iteraciones = 50;
X = randi(30) - 15;

x0 = X;
lr = 0.05;

figure(1)
subplot(2, 2, 1);
for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    punto = [x0, f_x0];
    plot(x,f, 'Color', 'b')
    hold on 
    if i==1
        plot(punto(1), punto(2), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25)
    elseif i ==iteraciones
        plot(punto(1), punto(2), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25)
    end
    plot(punto(1), punto(2), 'Color', 'r', 'Marker', '.', 'MarkerSize', 15)
    x0 = gradient_descent(x0, df_x0, lr);
end
title('gradient descent')
hold off

x0 = X;
m = 0;
gama = 0.9;  
lr = 0.05;

subplot(2, 2, 2);
for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    punto = [x0, f_x0];
    plot(x,f, 'Color', 'b')
    hold on 
    if i==1
        plot(punto(1), punto(2), 'Color', 'r', 'Marker', '+', 'MarkerSize', 20)
    elseif i ==iteraciones
        plot(punto(1), punto(2), 'Color', 'b', 'Marker', '+', 'MarkerSize', 20)
    end
    plot(punto(1), punto(2), 'Color', 'r', 'Marker', '.', 'MarkerSize', 15)
    [x0, m] = gradient_descent_momentum(x0, df_x0, lr, gama, m);
end
title('momentum')
hold off

x0 = X;
m = 0;
gama = 0.9;  
lr = 0.05;

subplot(2, 2, 3);
for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    punto = [x0, f_x0];
    plot(x,f, 'Color', 'b')
    hold on 
    if i==1
        plot(punto(1), punto(2), 'Color', 'r', 'Marker', '+', 'MarkerSize', 20)
    elseif i ==iteraciones
        plot(punto(1), punto(2), 'Color', 'b', 'Marker', '+', 'MarkerSize', 20)
    end
    plot(punto(1), punto(2), 'Color', 'r', 'Marker', '.', 'MarkerSize', 15)
    [x0, m] = nesterov_accelerated_gradient(x0, lr, gama, m);
end
title('nesterov accelerated gradient')
hold off
