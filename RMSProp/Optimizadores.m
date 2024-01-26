clearvars

limInferior = -100;
limSuperior = 100;
x = linspace(limInferior, limSuperior, 100);


x1 = linspace(limInferior, limSuperior, 100);
x2 = linspace(limInferior, limSuperior, 100);


[W1,W2] = meshgrid(x1, x2);


%%
w = randi([-200, 200]) * 0.1;
v = 0;
alpha = 0.2;
beta = 0.9;
camino = ones(3, 1);

iteraciones = 20;
%camino = zeros(2, iteraciones);

for iteracion = 1:iteraciones
    
    [C, DC_DW] = funcion2D(w);
    camino(1, iteracion) = w;
    camino(2, iteracion) = C;

    % Gradiente descendente
    w = w - alpha*DC_DW;

    % Gradiente descendente con momento
    % v = v * beta + alpha * DC_DW;
    % w = w - v;

    % RMSProp
    % v = beta * v +(1 - beta)*DC_DW^2;
    % w = w - alpha * (DC_DW/sqrt(v + 1e-7));

    figure(1)
    plot(x, funcion2D(x), '-', camino(1,:), camino(2,:), '-o')

    pause(0.5)

end

%%
camino = ones(3, 1);

w1 = randi([-1000, 1000]) * 0.1;
w2 = randi([-1000, 1000]) * 0.1;

v1 = 0;
v2 = 0;

beta = 0.9;
alpha = 0.1;

iteraciones = 30;
%camino = zeros(2, iteraciones);

for iteracion = 1:iteraciones
    
    [C, DC_DW1, DC_DW2] = funcion3D(w1, w2);
    camino(1, iteracion) = w1;
    camino(2, iteracion) = w2;
    camino(3, iteracion) = C;

    % Gradiente descendente
    % w1 = w1 - alpha*DC_DW1;
    % w2 = w2 - alpha*DC_DW2;

    % Gradiente descendente con momento
    v1 = beta*v1 + alpha * DC_DW1;
    v2 = beta*v2 + alpha * DC_DW2;

    w1 = w1 - v1;
    w2 = w2 - v2;

    % RMS Prop
    % v1 = (beta * v1) + (1 - beta)*(DC_DW1^2);
    % v2 = (beta * v2) + (1 - beta)*(DC_DW2^2);
    % 
    % w1 = w1 - alpha*(DC_DW1/sqrt(v1 + 1e-7));
    % w2 = w2 - alpha*(DC_DW2/sqrt(v2 + 1e-7));

    figure(1)
    contour(W1, W2, funcion3D(W1, W2))
    hold on
    plot(camino(1,:), camino(2,:), '-o');
    hold off

    pause(0.5)

end


    