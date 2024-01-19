function DC = derivada(w)

    dw0 = 6 * sin(w(1)/50 - 2) + 5 * sin(w(1)/10 - 10);
    dw1 = 6 * sin(w(2)/50) + 5 * sin(w(2)/10);

    DC = [dw0, dw1];
end