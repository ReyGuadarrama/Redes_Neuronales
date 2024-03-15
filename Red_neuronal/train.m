classdef train 
    %TRAIN Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods (Static)

        function [shuffled_input, shuffled_target] = shuffle(input, target)
        %SHUFFLE Summary of this method goes here
        %   Detailed explanation goes here
    
        n_samples = size(input, 2);
        shuffled_indices = randperm(n_samples);
        shuffled_input = input(:, shuffled_indices);
        shuffled_target = target(:, shuffled_indices);

        end

        function aux_parameters = auxiliar_parameters(model)
            n_layers = size(model.layers, 2);
            aux_parameters = cell(2, n_layers);

            for layer = 1:n_layers
                aux_parameters{1, layer} = zeros(size(model.layers(layer).weights));
                aux_parameters{2, layer} = zeros(size(model.layers(layer).bias));
            end

        end

        function accuracy = accuracy(model, input, target)
            n_samples = size(input, 2);
            prediction = model.prediction(input);
            out_label = prediction == max(prediction);
            if size(target, 1) > 1
                n_errors = sum(target ~= out_label, "all")/2;
            else
                n_errors = sum(target ~= out_label, 'all');
            end
            accuracy = 1 - n_errors/n_samples;

        end


        

        function SGD(model, input, target, learningRate, batchSize, epochs, loss)
            %SGD Summary of this method goes here
            %   Detailed explanation goes here

            model.history.cost = zeros(1, epochs);
            model.history.accuracy = zeros(1, epochs);
            n_layers = size(model.layers, 2);
            n_samples = size(input, 2);
            iterations = floor(n_samples/batchSize);

            for epoch = 1:epochs
                
                [shuffled_input, shuffled_target] = train.shuffle(input, target); 
                P = model.prediction(input);
                train_cost = cost(P, target, loss);
                train_accuracy = train.accuracy(model, input, target);
                model.history.cost(epoch) = train_cost;
                model.history.accuracy(epoch) = train_accuracy;
                fprintf('Epoch: %-5d Loss: %-10.4f Accuracy: %-6.2f%%\n', epoch, train_cost, train_accuracy);

    
                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    derivatives = model.back_propagation(batch, batch_labels, loss);
    
                    for layer = 1:n_layers
                
                        model.layers(layer).weights = model.layers(layer).weights - (learningRate * derivatives{1, layer});
                        model.layers(layer).bias = model.layers(layer).bias - (learningRate * derivatives{2, layer});
                
                    end
                
                % P = model.prediction(input);
                % if  sum(isnan(P), 'all')  ~= 0
                %     disp('NaN');
                %     break
                % end
    
                end
            end
        end

        function SGDMomentum(model, input, target, learningRate, momParam, batchSize, epochs, loss)
            %SGDMOMENTUM Summary of this method goes here
            %   Detailed explanation goes here
            model.history.cost = zeros(1, epochs);
            model.history.accuracy = zeros(1, epochs);
            n_layers = size(model.layers, 2);
            n_samples = size(input, 2);
            iterations = floor(n_samples/batchSize);

            for epoch = 1:epochs
                [shuffled_input, shuffled_target] = train.shuffle(input, target); 
                momentum = train.auxiliar_parameters(model);
                P = model.prediction(input);
                train_cost = cost(P, target, loss);
                train_accuracy = train.accuracy(model, input, target);
                model.history.cost(epoch) = train_cost;
                model.history.accuracy(epoch) = train_accuracy;
                fprintf('Epoch: %-5d Loss: %-10.4f Accuracy: %-6.2f%%\n', epoch, train_cost, train_accuracy);

                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    derivatives = model.back_propagation(batch, batch_labels, loss);
    
                    for layer = 1:n_layers
                        
                        momentum{1, layer} = (momParam * momentum{1, layer}) + (learningRate * derivatives{1, layer});
                        momentum{2, layer} = (momParam * momentum{2, layer}) + (learningRate * derivatives{2, layer});
    
                        model.layers(layer).weights = model.layers(layer).weights - momentum{1, layer};
                        model.layers(layer).bias = model.layers(layer).bias - momentum{2, layer};
    
                    end
                end
            end
        end

        % function SGD()
        %     %SGD Summary of this method goes here
        %     %   Detailed explanation goes here
        % end


        
    end
end