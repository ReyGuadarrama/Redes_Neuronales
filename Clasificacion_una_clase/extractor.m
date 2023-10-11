    
function [x, t] = extractor(caracterristica_1, caracteristica_2)

    [x,t] = simpleclass_dataset;
    counter = 1;
    
    for i = 1:length(t)
        if t(caracterristica_1, i) || t(caracteristica_2, i)
            X(:,counter) = x(:,i);
            T(:,counter) = t(1:2,i);
            counter = counter + 1;
         end
    end

    x = X;
    t = T;

end

