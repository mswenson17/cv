num_epoch = 40;
classes = 26;
layers = [32*32, 400, classes]
learning_rate = .05
load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);
train_acc=[];
valid_acc=[];

for j = 1:num_epoch
    tic
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);
    toc

    fprintf('\n');
    %checkGradient(W,b,grad_W,grad_b,X);
    [train_acc(j), train_loss(j)] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc(j), valid_loss(j)] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc(j), valid_acc(j), train_loss(j), valid_loss(j))
end
epochs = 1:num_epoch;
figure(1)
hold on;
plot(num_epoch, train_acc)
plot(num_epoch, train_loss)
plot(num_epoch, valid_acc)
plot(num_epoch, valid_loss)
save('nist26_model_400_nodes_02lr_new_weights.mat', 'W', 'b', 'train_acc', 'train_loss', 'valid_acc','valid_loss')

%clear all;
%num_epoch= 50;
%classes = 26;
%layers = [32*32, 400, classes];
%learning_rate = .01;

%load('../data/nist26_train.mat', 'train_data', 'train_labels')
%load('../data/nist26_test.mat', 'test_data', 'test_labels')
%load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

%[W, b] = InitializeNetwork(layers);

%for j = 1:num_epoch
    %[W, b] = Train(W, b, train_data, train_labels, learning_rate);

    %%checkGradient(W,b,grad_W,grad_b,X);
    %[train_acc(j), train_loss(j)] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    %[valid_acc(j), valid_loss(j)] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    %fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc(j), valid_acc(j), train_loss(j), valid_loss(j))
%end

%plot(num_epoch, train_acc)
%plot(num_epoch, train_loss)
%plot(num_epoch, valid_acc)
%plot(num_epoch, valid_loss)
%save('nist26_model.mat', 'W', 'b', 'train_acc', 'train_loss', 'valid_acc','valid_loss')


