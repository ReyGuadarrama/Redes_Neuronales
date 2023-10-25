function p = hipotesis(w, x)
    z = w*x;
    p = zeros(length(z(:,1)), length(z(1,:)));
    for i = 1:length(z(1,:))
        p(:,i) = exp(z(:,i)) ./ sum(exp(z(:,i)));
    end