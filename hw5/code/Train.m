function [W, b] = Train(W, b, train_data, train_labels, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.
[~,N] = size(train_data);
[~,C] = size(train_labels);
assert(size(W{1},2) == N, 'W{1} must be of size [~,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [~,1]');
assert(size(b{end},2) == 1, 'b{end} must be of size [~,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,~]');


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it
D = size(train_labels,1);
order = randperm(D);
train_data = train_data(order,:);
train_labels = train_labels(order,:);
batch_size = 1;

grad_W= cellfun(@(x) x*0, W, 'un',0);
grad_b= cellfun(@(x) x*0, b, 'un',0);

for i = 1:D
    X = train_data(i,:)'; 

    Y = train_labels(i,:)'; 
    [output, act_h, act_a] = Forward(W,b,X);
    [g_W, g_b] = Backward(W, b, X, Y, act_h, act_a);

    grad_W= cellfun(@(x,y) x+y,grad_W, g_W, 'un',0);
    grad_b= cellfun(@(x,y) x+y,grad_b, g_b, 'un',0);

    if mod(i, batch_size) == 0
        grad_W= cellfun(@(x) x/batch_size, grad_W, 'un',0);
        grad_b= cellfun(@(x) x/batch_size, grad_b, 'un',0);

        [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);

        fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
        fprintf('Done %.2f %%', i/size(train_data,1)*100)

        grad_W= cellfun(@(x) x*0, W, 'un',0);
        grad_b= cellfun(@(x) x*0, b, 'un',0);
    end
end
%assert(1==0)
fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')


end
