function C = costo(w, x, T)
    P = hipotesis(w, x);
    C = 0;
    for i = 1:length(P(1,:))
        C = C - sum(T(:,i) .* log(P(:,i)));
    end
