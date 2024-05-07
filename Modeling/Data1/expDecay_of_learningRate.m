function lr_values = expDecay_of_learningRate(initial_learning_rate, final_learning_rate, total_epochs)
    % Calculate the decay factor
    decay_factor = final_learning_rate / initial_learning_rate;
    % Calculate the decay rate per epoch
    decay_rate = decay_factor ^ (1 / total_epochs);
    
    % Create an array of epochs
    epochs = 1:total_epochs;

    % Calculate learning rates for each epoch using the exponential decay formula
    lr_values = initial_learning_rate * (decay_rate .^ epochs);

    % % Plotting the learning rate schedule
    % figure;
    % plot(epochs, lr_values, 'o-');
    % title('Exponential Decay Learning Rate Schedule');
    % xlabel('Epoch');
    % ylabel('Learning Rate');
    % grid on;
    % legend('Learning Rate');
end
