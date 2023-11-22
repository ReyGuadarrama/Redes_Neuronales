function R = relu(P)

    R = P .* (P > 0);
    
end