function X = polinomio(n, x)
n_caracteristicas = length(x(:,1));

% vector de potencias
p = [1, repelem(1:n, n_caracteristicas)];

% matriz de valores de x repetida n veces
mat_x = [ones(1, length(x(1,:))); repmat(x(1:n_caracteristicas,:), n, 1)]; 
X = mat_x.^(p.');




    