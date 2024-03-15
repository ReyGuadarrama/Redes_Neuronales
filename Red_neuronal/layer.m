classdef layer
    %LAYER Creates a layer for a neural network.
    %
    %   layer properties:
    %       weights   - The weights of the layer.
    %       bias      - The bias of the layer.
    %       activation- The activation function of the layer.
    %
    %   layer methods:
    %       layer      - Constructor method to create a new layer object.
    %
    %   Example:
    %       % Create a layer with 10 input neurons, 5 output neurons, and
    %       % 'relu' activation function.
    %       layer1 = layer(10, 5, 'relu');

    properties
        weights;
        bias;
        activation; 
    end

    methods
        function obj = layer(input_size, n_neurons, activ_func)
            %LAYER Construct an instance of the layer class.
            %
            %   obj = LAYER(input_size, n_neurons, activ_func) creates a
            %   layer object with randomly initialized weights and biases
            %   and the specified activation function.
            %
            %   input_size  - The number of input neurons.
            %   n_neurons   - The number of neurons in the layer.
            %   activ_func  - A function handle for the activation
            
            obj.weights = randn(input_size, n_neurons);
            obj.bias = zeros(n_neurons, 1);
            obj.activation = activ_func;
        end

    end
end