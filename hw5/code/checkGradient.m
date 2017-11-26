[avg_err] = checkGradient(W,b,grad_W,grad_b,data,labels);

[~,N] = size(data);
epsilon = .0001;

grad_W

W_1= cellfun(@(x) x+epsilon, W, 'un',0);
W_2= cellfun(@(x) x-epsilon, W, 'un',0);
b_1= cellfun(@(x) x+epsilon, b, 'un',0);
b_2= cellfun(@(x) x-epsilon, b, 'un',0);


outputs =   Forward(W,b,    data');
outputs_1 = Forward(W_1,b_1,data');
outputs_2 = Forward(W_2,b_2,data');


loss1 = -log(dot(labels,outputs_1));
loss2 = -log(dot(labels,outputs_2));

num_dC = (loss1-loss2)/(2*epsilon);

%err = num_dC - 
%num_dW = cellfun(@(x,y) (x-y)/epsilon, W_1,W_2,'un',0);
%num_dW = cellfun(@(x,y) (x-y)/epsilon, W_1,W_2,'un',0);
%num_db = cellfun(@(x,y) (x-y)/epsilon, b_1,b_2,'un',0);
%[acc loss]=ComputeAccuracyAndLoss(W_1,b_1,data(j,:),labels(j,:))
for i=1:100
    j = randi(N,1,1);
    num_err(i) = (loss1-loss2)/(2*epsilon);
end

W{end}- 



% Your code here.
