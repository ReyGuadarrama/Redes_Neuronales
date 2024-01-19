function C = costo(w)
    C = - 300 * cos(w(1)/50 - 2) - 300 * cos(w(2)/50) - 50 * cos(w(1)/10 - 10) - 50 * cos(w(2)/10) + 700; 
end