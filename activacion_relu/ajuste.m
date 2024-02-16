function [a, w] = ajuste(f, x, puntos)

    w = ones(1, length(puntos) - 1);
    a = zeros(length(puntos) - 1, length(x));
    y0 = recta_dos_puntos(f, x, puntos(1), puntos(2));
    a(1,:) = max(y0, 0);

    for punto = 3:length(puntos)
        x0 = puntos(punto - 1);
        x1 = puntos(punto);

        y = recta_dos_puntos(f, x, x0, x1);
        aux = y - y0;

        if aux(1) > aux(2)
            w(punto - 1) = -1;
        end

        y0 = y;

        relu = max(w(punto - 1)*aux, 0);

        a(punto - 1,:) = relu;
    
    end
end