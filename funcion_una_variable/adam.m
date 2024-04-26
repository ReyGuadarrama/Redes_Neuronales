function [x, m, v, m_hat, v_hat] = adam(x, df, m, v, t, lr, beta1, beta2)

    m = beta1 * m + (1 - beta1) * df;
    v = beta2 * v + (1 - beta2) * (df.^2);
    m_hat = m / (1 - beta1^t);
    v_hat = v / (1 - beta2^t);
    x = x - lr * m_hat ./ (sqrt(v_hat) + 1e-8);

end