function [avg_err] = checkGradient(W,b,grad_W,grad_b,data,labels);
% Your code here.
epsilon = .0001;

    %[out_min act_h act_a] = Forward(W,b,X);
    %[g_W, g_b] = Backward(W, b, X, Y, act_h, act_a);

for j = 1:numel(W)
for i =1:3
    ind = randi(numel(W{j}),1,1);    
    W_min  = W; 
    W_max  = W; 
    W_min{j}(ind) = W{j}(ind)-epsilon;
    W_max{j}(ind) = W{j}(ind)+epsilon;
    [~, train_loss_min] = ComputeAccuracyAndLoss(W_min, b, data, labels);
    [~, train_loss_max] = ComputeAccuracyAndLoss(W_max, b, data, labels);
    num_diff =  (train_loss_max-train_loss_min)/(2*epsilon);
    g_w = grad_W{j};
    grad_error(j) = abs(num_diff-grad_W{j}(ind));
end
avg_err_W = sum(grad_error)/numel(grad_error)
end

for j = 1:numel(b)
for i =1:3
    ind = randi(numel(b{1},1,1));    
    b_min  = b; 
    b_max  = b; 
    b_min{j}(ind) = b{j}-epsilon;
    b_max{j}(ind) = b{j}+epsilon;
    [~, train_loss_min] = ComputeAccuracyAndLoss(W, b_min, data, labels);
    [~, train_loss_max] = ComputeAccuracyAndLoss(W, b_max, data, labels);

    num_diff =  (train_loss_max-train_loss_min)/(2*epsilon);
    grad_error(j) = abs(num_diff-grad_b{j}(ind));
end
avg_err_b(i) = sum(grad_error)/numel(grad_error);
end

avg_err_W
avg_err_b

avg_err = [avg_err_W avg_err_b]

