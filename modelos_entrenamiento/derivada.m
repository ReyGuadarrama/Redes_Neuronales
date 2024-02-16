function DC = derivada(w, x, T) 
    P = hipotesis(w, x);
    DC = (P-T)*x';
end