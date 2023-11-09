% Función para generar la ecuación del ajuste
function ecuacion = generar_ecuacion(coeficientes)
    grado = length(coeficientes) - 1;
    ecuacion = sprintf('y = ');
    
    for i = 1:grado+1
        ecuacion = [ecuacion, sprintf('%.2f', coeficientes(i))];
        
        if i < grado+1
            ecuacion = [ecuacion, sprintf('x^%d', grado - i + 1)];
            if coeficientes(i+1) >= 0
                ecuacion = [ecuacion, '+'];
            else
                ecuacion = [ecuacion, ''];
            end
        else
            ecuacion = [ecuacion, sprintf('')];
        end
    end
end