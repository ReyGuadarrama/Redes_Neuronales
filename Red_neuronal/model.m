classdef model < handle
    %MODELO creates an instance of a neural network
    %   Detailed explanation goes here

    properties
        layers;
        history = struct;
    end

    methods
        function obj = model(layers)
            %MODEL Construct an instance of this class
            %   Detailed explanation goes here
            obj.layers = layers;
        end

        function layers_output = pass_forward(obj, input)
            %PASS_FORWARD Summary of this method goes here
            %   Detailed explanation goes here
             
            n_layers = size(obj.layers, 2) + 1;
            layers_output = cell(3, n_layers);
            layers_output{1, 1} = input;
            layers_output{2, 1} = input;
            layers_output{3, 1} = ones(size(input));
            
            for layer = 2:n_layers 
                z = obj.layers(layer - 1).weights' * layers_output{2, layer - 1} + obj.layers(layer - 1).bias;
                [a, da_dz] = activation(z, obj.layers(layer - 1).activation);
                
                layers_output{1, layer} = z;
                layers_output{2, layer} = a;
                layers_output{3, layer} = da_dz; 

            end
        end


        function derivatives = back_propagation(obj, input, target, loss)
            %BACK_PROPAGATION Summary of this method goes here
            %   Detailed explanation goes here

            n_layers = size(obj.layers, 2) + 1;
            layers_output = obj.pass_forward(input);
            %z = layers_output{1,:};
            a = layers_output(2,:);
            da_dz = layers_output(3, :);
            
            derivatives = cell(2, n_layers - 1);

            for layer = flip(2:n_layers)
                if layer == n_layers
                    [~, dC_da] = cost(a{layer}, target, loss);
                    dC_dz = dC_da .* da_dz{layer};
                    derivatives{1, layer - 1} = a{layer - 1} *dC_dz'; 
                    derivatives{2, layer - 1} = sum(dC_dz, 2);
                else
                    dC_dz = (obj.layers(layer).weights * dC_dz) .* da_dz{layer};
                    derivatives{1, layer - 1} = a{layer - 1} * dC_dz';
                    derivatives{2, layer - 1} = sum(dC_dz, 2);
                end
            end

        end

        function pred = prediction(obj, input)
            n_layers = size(obj.layers, 2) + 1;
            a = input; 

            for layer = 2:n_layers 
                z = obj.layers(layer - 1).weights' * a + obj.layers(layer - 1).bias;
                [a, ~] = activation(z, obj.layers(layer - 1).activation);
            end

            pred = a;

        end

        function plot_cost(obj)
            plot(obj.history.cost);
        end

        function plot_accuracy(obj)
            plot(obj.history.accuracy);
        end

    end
end