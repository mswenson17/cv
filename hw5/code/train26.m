num_epoch = 15;
classes = 26;
layers = [32*32, 400, classes]
learning_rate = .01
load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);
%load('./nist26_model_best.mat', 'W', 'b');
train_acc=[];
valid_acc=[];

Wold={};
bold={};
Wbest={};
bbest={};
best_acc=0;

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);
    Wold{j} =W;
    bold{j} =b;

    fprintf('\n');
    %checkGradient(W,b,grad_W,grad_b,X);
    [train_acc(j), train_loss(j)] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc(j), valid_loss(j)] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    if(valid_acc(j)> best_acc)
        Wbest = W;
        bbest = b;
        best_acc = valid_acc(j);
    end
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc(j), valid_acc(j), train_loss(j), valid_loss(j))
end

save('nist26_model_400_nodes_01lr_50weights.mat', 'Wold','bold','Wbest', 'bbest', 'train_acc', 'train_loss', 'valid_acc','valid_loss')
epochs = 1:num_epoch;
figure(1)
hold off
hold on;
plot(epochs, train_acc)
hold on;
plot(epochs, valid_acc)

figure(2);
hold off
plot(epochs, train_loss)
hold on;
plot(epochs, valid_loss)


