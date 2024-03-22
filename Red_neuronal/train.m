classdef train 
    %TRAIN Summary of this class goes here
    %   Detailed explanation goes here

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

        function [train_data, val_data] = split_data(data, ratio)
            n_samples = size(data, 2);
            n_val_samples = floor(n_samples*ratio);
            val_data = data(:, 1:n_val_samples);
            train_data = data(:, n_val_samples:end);
            
        end
        

        function SGD(model, input, target, learningRate, batchSize, epochs, loss)
            %SGD Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(model.layers, 2);
            [train_data, val_data] = train.split_data(input, 0.2);
            [train_labels, val_labels] = train.split_data(target, 0.2);
            n_train_samples = size(train_data, 2);
            
            iterations = floor(n_train_samples/batchSize);

            for epoch = 1:epochs
                
                [shuffled_input, shuffled_target] = train.shuffle(train_data, train_labels); 
                model.metrics.epoch_metrics(train_data, train_labels, val_data, val_labels, loss, epoch);
                model.metrics.show(epoch);
                
                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    derivatives = model.back_propagation(batch, batch_labels, loss);
    
                    for layer = 1:n_layers
                
                        model.layers(layer).weights = model.layers(layer).weights - (learningRate * derivatives{1, layer});
                        model.layers(layer).bias = model.layers(layer).bias - (learningRate * derivatives{2, layer});
                
                    end
                end
            end
        end

        function Momentum(model, input, target, learningRate, batchSize, epochs, loss)
            %MOMENTUM Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(model.layers, 2);
            [train_data, val_data] = train.split_data(input, 0.2);
            [train_labels, val_labels] = train.split_data(target, 0.2);
            n_train_samples = size(train_data, 2);
            momentum = train.auxiliar_parameters(model);
            momParam = 0.9;
            
            iterations = floor(n_train_samples/batchSize);

            for epoch = 1:epochs
                
                [shuffled_input, shuffled_target] = train.shuffle(train_data, train_labels); 
                model.metrics.epoch_metrics(train_data, train_labels, val_data, val_labels, loss, epoch);
                model.metrics.show(epoch);

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
        
        function NAG(model, input, target, learningRate, batchSize, epochs, loss)
            %NAG Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(model.layers, 2);
            [train_data, val_data] = train.split_data(input, 0.2);
            [train_labels, val_labels] = train.split_data(target, 0.2);
            n_train_samples = size(train_data, 2);
            momentum = train.auxiliar_parameters(model);
            past_params  = train.auxiliar_parameters(model);
            momParam = 0.9;
            
            iterations = floor(n_train_samples/batchSize);

            for epoch = 1:epochs
                
                [shuffled_input, shuffled_target] = train.shuffle(train_data, train_labels); 
                model.metrics.epoch_metrics(train_data, train_labels, val_data, val_labels, loss, epoch);
                model.metrics.show(epoch);

                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
    
                    for layer = 1:n_layers
                        past_params{1, layer} = model.layers(layer).weights;
                        past_params{2, layer} = model.layers(layer).bias;

                        model.layers(layer).weights = past_params{1, layer} - (momParam*momentum{1, layer});
                        model.layers(layer).bias = past_params{2, layer} - (momParam*momentum{2, layer});
                       
                    end
                    
                    derivatives = model.back_propagation(batch, batch_labels, loss);

                    for layer = 1:n_layers
                        momentum{1, layer} = (momParam * momentum{1, layer}) + (learningRate * derivatives{1, layer});
                        momentum{2, layer} = (momParam * momentum{2, layer}) + (learningRate * derivatives{2, layer});
    
                        model.layers(layer).weights = past_params{1, layer} - momentum{1, layer};
                        model.layers(layer).bias = past_params{2, layer} - momentum{2, layer};
    
                    end
                end
            end
        end

        function AdaGrad(model, input, target, learningRate, batchSize, epochs, loss)
            %ADAGRAD Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(model.layers, 2);
            [train_data, val_data] = train.split_data(input, 0.2);
            [train_labels, val_labels] = train.split_data(target, 0.2);
            gradients_squared = train.auxiliar_parameters(model);
            n_train_samples = size(train_data, 2);
            epsilon = 1e-8;

            
            iterations = floor(n_train_samples/batchSize);

            for epoch = 1:epochs
                
                [shuffled_input, shuffled_target] = train.shuffle(train_data, train_labels); 
                model.metrics.epoch_metrics(train_data, train_labels, val_data, val_labels, loss, epoch);
                model.metrics.show(epoch);

                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    derivatives = model.back_propagation(batch, batch_labels, loss);
    
                    for layer = 1:n_layers
                        
                        gradients_squared{1, layer} = gradients_squared{1, layer} + derivatives{1, layer} .^2;
                        gradients_squared{2, layer} = gradients_squared{2, layer} + derivatives{2, layer} .^2;
    
                        model.layers(layer).weights = model.layers(layer).weights - (learningRate ./ sqrt(gradients_squared{1, layer} + epsilon)) .* derivatives{1, layer};
                        model.layers(layer).bias = model.layers(layer).bias - (learningRate ./ sqrt(gradients_squared{2, layer} + epsilon)) .* derivatives{2, layer};
    
                    end
                end
            end
        end

        function RMSProp(model, input, target, learningRate, batchSize, epochs, loss)
            %RMSPROP Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(model.layers, 2);
            [train_data, val_data] = train.split_data(input, 0.2);
            [train_labels, val_labels] = train.split_data(target, 0.2);
            exp_decayRate = 0.99;
            momentum = train.auxiliar_parameters(model);
            n_train_samples = size(train_data, 2);
            epsilon = 1e-8;

            
            iterations = floor(n_train_samples/batchSize);

            for epoch = 1:epochs
                
                %flag = 0;
                [shuffled_input, shuffled_target] = train.shuffle(train_data, train_labels); 
                model.metrics.epoch_metrics(train_data, train_labels, val_data, val_labels, loss, epoch);
                model.metrics.show(epoch);

                for iteration =1:iterations
                    batch = shuffled_input(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    batch_labels = shuffled_target(:,batchSize*(iteration - 1) + 1 : batchSize*iteration);
                    derivatives = model.back_propagation(batch, batch_labels, loss);
    
                    for layer = 1:n_layers
                       
                        momentum{1, layer} = exp_decayRate*momentum{1, layer} + (1 - exp_decayRate)*(derivatives{1, layer}.^2);
                        momentum{2, layer} = exp_decayRate*momentum{2, layer} + (1 - exp_decayRate)*(derivatives{2, layer}.^2);
    
                        model.layers(layer).weights = model.layers(layer).weights - (learningRate ./ sqrt(momentum{1, layer} + epsilon)) .* derivatives{1, layer};
                        model.layers(layer).bias = model.layers(layer).bias - (learningRate ./ sqrt(momentum{2, layer} + epsilon)) .* derivatives{2, layer};
    
                    end

                    % P = model.prediction(train_data);
                    % if  sum(isnan(P), 'all')  ~= 0
                    %     disp('NaN');
                    %     disp(num2str(iteration));
                    %     flag = 1;
                    %     break
                    % end
                end

            % if flag == 1
            %     break
            % end

            end
        end
        
        % function SGD()
        %     %SGD Summary of this method goes here
        %     %   Detailed explanation goes here
        % end


        
    end
end