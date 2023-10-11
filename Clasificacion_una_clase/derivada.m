function DC = derivada(w, x, T)
    P = hipotesis(w, x);
    DC_DP = P .* ((T - P) ./ (1 - P));
    DP_DW = x .* exp(-(w*x)); 
    DC = - DC_DP * DP_DW.';

end