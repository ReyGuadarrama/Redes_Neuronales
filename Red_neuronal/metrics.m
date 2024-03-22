classdef metrics < handle
    %METRICS Summary of this class goes here
    %   Detailed explanation goes here

    properties
        epochs;
        train_loss;
        train_accuracy;
        validation_loss;
        validation_accuracy;
        model;
    end

    methods 

        function obj = metrics(model)
            %METRICS Construct an instance of this class
            %   Detailed explanation goes here
            obj.epochs = [];
            obj.train_loss = [];
            obj.train_accuracy = [];
            obj.validation_loss = [];
            obj.validation_accuracy = [];
            obj.model = model;
        end

        function epoch_metrics(obj, train_data, train_labels, val_data, val_labels,  loss, epoch)
            % Add metrics for a new epoch
            P_train = obj.model.prediction(train_data);
            P_val = obj.model.prediction(val_data);
            obj.epochs(end+1) = epoch;
            obj.train_loss(end+1) = cost(P_train, train_labels, loss);
            obj.train_accuracy(end+1) = train.accuracy(obj.model, train_data, train_labels);
            obj.validation_loss(end+1) = cost(P_val, val_labels, loss);
            obj.validation_accuracy(end+1) = train.accuracy(obj.model, val_data, val_labels);
        end

        function show(obj, epoch)
            val_cost = obj.validation_loss(epoch);
            val_acc = obj.validation_accuracy(epoch);
            train_cost = obj.train_loss(epoch);
            train_acc = obj.train_accuracy(epoch);
            fprintf('Epoch: %-5d validation loss: %-10.4f validation acc: %-10.4f train loss: %-10.4f train acc: %-6.4f \n', epoch, val_cost, val_acc, train_cost, train_acc);
        end

        function plot_loss(obj)
            plot(obj.epochs, obj.validation_loss)

        end

        function plot_accuracy(obj)
            plot(obj.epochs, obj.validation_accuracy)
   
        end

    end
end