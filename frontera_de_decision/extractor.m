    
function [x, t] = extractor(clase_1, clase_2)

    [x,t] = simpleclass_dataset;
    counter = 1;
    
    for i = 1:length(t)
        if t(clase_1, i) == 1 || t(clase_2, i) == 1
            X(:,counter) = x(:,i);
            T(:,counter) = t(clase_1,i);
            counter = counter + 1;
         end
    end

    x = X;
    t = T;

end

