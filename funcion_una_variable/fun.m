function [f, df] = fun(x)
    f = -10*exp(-2*x.^2)+exp(-0.1*x)+exp(0.19*x)+cos(exp(0.21*x));
    df = 40*x .* exp(-2*x.^2) - 0.1*exp(-0.1*x) +0.19*exp(0.19*x) - 0.21*exp(0.21*x).*sin(exp(0.21*x));
end