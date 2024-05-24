clearvars, clc, close all

x = linspace(-15, 15, 200);
[f, df] = fun(x);

iteraciones = 100;
zona1 = -10; % Gradiente pequeño crece lento
zona2 = -2; % Gradiente pequeño crece rapido
zona3 = -1; % Gradiente grande crece rapido
zona4 = 2; % Gradiente pequeño crece lento, mínimo local
zona5 = 7.6; % Gradiente grande crece rapido, mínimo local
zona6 = 11.4; % zona de mínimos locales


X = zona4;

figure(1)
plot(x, f, x, df);
xline(X)
legend('funcion de costo', 'derivada costo')

x0 = X;
lr = 0.05;
puntos = zeros(1, iteraciones);
gradients = zeros(1, iteraciones);
gd_history = zeros(1, iteraciones);
c = 1:length(puntos);
map = 'Autumn';


gcf = figure(2);
set(gcf,'position',[200,200,1200,800])

for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    gd_history(i) = f_x0;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    x0 = gradient_descent(x0, df_x0, lr);
end

subplot(3, 4, 1)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, gd_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gd_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gd_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('gradient descent')
hold off
grid
legend([s, e])

subplot(3, 4, 5)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('gradient descent')
hold off
grid
legend([s, e])

subplot(3, 4, 9)
plot(1:iteraciones, gradients)
title('gradient descent')
legend('gradiente')
grid

% Gradiente Descendente con momento

x0 = X;
m = 0;
gama = 0.9;  
lr = 0.05;
momentum_history = zeros(1, iteraciones);
m_history = zeros(1, iteraciones);


for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    momentum_history(i) = f_x0;
    m_history(i) = m;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, m] = gradient_descent_momentum(x0, df_x0, lr, gama, m);
end

subplot(3, 4, 2)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, momentum_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), momentum_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), momentum_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('momentum')
hold off
grid
legend([s, e])

subplot(3, 4, 6)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('momentum')
hold off
grid
legend([s, e])

subplot(3, 4, 10)
plot(1:iteraciones, gradients, 1:iteraciones, m_history/lr)
title('momentum')
legend('gradiente', 'momentum')
grid

% Nesterov Accelerated gradient

x0 = X;
m = 0;
gama = 0.9;  
lr = 0.05;
nag_history = zeros(1, iteraciones);


for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    nag_history(i) = f_x0;
    m_history(i) = m;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, m] = nesterov_accelerated_gradient(x0, lr, gama, m);
end

subplot(3, 4, 3)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, nag_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), nag_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), nag_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('NAG')
hold off
grid
legend([s, e])

subplot(3, 4, 7)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('NAG')
hold off
grid
legend([s, e])

subplot(3, 4, 11)
plot(1:iteraciones, gradients, 1:iteraciones, m_history/lr)
title('NAG')
legend('gradiente', 'momentum')
grid

% Adaptative Gradient

x0 = X;
v = 0;
lr = 0.05;
adagrad_history = zeros(1, iteraciones);
lr_history = zeros(1, iteraciones);

for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    adagrad_history(i) = f_x0;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, v] = adaptative_gradient(x0, df_x0, lr, v);
    lr_history(i) = (1 ./ sqrt(v + 1e-8)*lr);
end
subplot(3, 4, 4)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, adagrad_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), adagrad_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), adagrad_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adagrad')
hold off
grid
legend([s, e])

subplot(3, 4, 8)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adagrad')
hold off
grid
legend([s, e])

subplot(3, 4, 12)
plot( 1:iteraciones, lr_history)
title('adagrad')
legend('learning rate')
grid


gcf = figure(3);
set(gcf,'position',[200,200,1200,800])

x0 = X;
v = 0;
lr = 0.05;
gama = 0.9;
rmsprop_history = zeros(1, iteraciones);
velocity_history = zeros(1, iteraciones);


for i = 1:iteraciones
   [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    rmsprop_history(i) = f_x0;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, v] = RMS_prop(x0, df_x0, lr, v, gama);
    velocity_history(i) = v;
end

subplot(3, 3, 1)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, rmsprop_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), rmsprop_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), rmsprop_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('rms prop')
hold off
grid
legend([s, e])

subplot(3, 3, 4)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('rms prop')
hold off
grid
legend([s, e])

subplot(3, 3, 7)
plot(1:iteraciones, gradients, 1:iteraciones, velocity_history)
title('rms prop')
legend('gradiente', 'velocity')
grid


x0 = X;
v = 0;
delta_x = 0;
gama = 0.999;
adadelta_history = zeros(1, iteraciones);
delta_x_history = zeros(1, iteraciones);


for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    adadelta_history(i) = f_x0;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, v, delta_x] = ada_delta(x0, df_x0, v, gama, delta_x);
    velocity_history(i) = v;
    delta_x_history(i) = delta_x;
end

subplot(3, 3, 2)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, adadelta_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), adadelta_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), adadelta_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adadelta')
hold off
grid
legend([s, e])

subplot(3, 3, 5)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adadelta')
hold off
grid
legend([s, e])

subplot(3, 3, 8)
plot(1:iteraciones, gradients, 1:iteraciones, velocity_history, 1:iteraciones, delta_x_history)
title('adadelta')
legend('gradiente', 'velocity', '\Delta x')
grid


x0 = X;
v = 0;
m = 0;
beta1 = 0.9;
beta2 = 0.999;
adam_history  = zeros(1, iteraciones);
m_norm_history = zeros(1, iteraciones);
v_norm_history = zeros(1, iteraciones);

for i = 1:iteraciones
    [f_x0, df_x0] = fun(x0);
    puntos(i) = x0;
    adam_history(i) = f_x0;
    gradients(i) = df_x0;
    punto = [x0, f_x0];
    [x0, m, v, m_norm, v_norm] = adam(x0, df_x0, m, v, i, lr, beta1, beta2);
    m_history(i) = m;
    velocity_history(i) = v;
    m_norm_history(i) = m_norm;
    v_norm_history(i) = v_norm;
end

subplot(3, 3, 3)
plot(x,f, 'Color', 'b')
hold on 
scatter(puntos, adam_history, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), adam_history(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), adam_history(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adam')
hold off
grid
legend([s, e])

subplot(3, 3, 6)
plot(x,df, 'Color', 'b')
hold on 
scatter(puntos, gradients, 20, c, 'filled')
colormap(map)
s = plot(puntos(1), gradients(1), 'Color', 'r', 'Marker', '+', 'MarkerSize', 25, 'DisplayName', 'start');
e = plot(puntos(end), gradients(end), 'Color', 'b', 'Marker', '+', 'MarkerSize', 25,  'DisplayName', 'finish');
title('adam')
hold off
grid
legend([s, e])

subplot(3, 3, 9)
plot(1:iteraciones, gradients, 1:iteraciones, velocity_history, 1:iteraciones, m_history, 1:iteraciones, m_norm_history, 1:iteraciones, v_norm_history)
title('adam')
legend('gradiente', 'velocity', 'momentum', 'mom nomalizado', 'vel normalizada')
grid

figure()
plot(1:iteraciones, gd_history, ...
    1:iteraciones, momentum_history, ...
    1:iteraciones, nag_history, ...
    1:iteraciones, adagrad_history, ...
    1:iteraciones, rmsprop_history, ...
    1:iteraciones, adadelta_history, ...
    1:iteraciones, adam_history)

legend('gd', 'momentum', 'nag', 'adagrad', 'rmsprop', 'adadelta', 'adam')
grid
title('costo')