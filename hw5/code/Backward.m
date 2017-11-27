function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'
N = size(X,1);
H = size(W{1},1);
C = size(b{end},1);
assert(size(W{1},2) == N, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'b{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');
assert(all(size(act_a{1}) == [H,1]), 'act_a{1} must be of size [H,1]');
assert(all(size(act_h{end}) == [C,1]), 'act_h{end} must be of size [C,1]');

% Your code here
%z:= pre activation = act_a
%a:= post activation = act_h = sigmoid(z)

o = act_h{end};

function [y]=dsig(x)
    y = x.*(1-x);
end


dCda = o - Y;

delta{numel(W)} = dCda.*dsig(act_h{end});

grad_b{numel(W)} = delta{end};
grad_W{numel(W)} = delta{end}*act_h{end-1}';

%WEND: dCda*sigprime(last layer activations)
%Wbegin: W(end)*dCda*sigprime*sigprime(hidden layer activations)

%delta{end}
%delta{2}
%act_a{end}
for i=numel(W)-1:-1:1
    delta{i} = (W{i+1}'*delta{i+1}).*dsig(act_h{i});
    if i == 1
        %X W_2 dCda.*dsig(sigmoid(hidden activations)) * dsig(input activations)
        grad_W{i} = (X*delta{i}')';
    else
        grad_W{i} = (act_h{i-1}*delta{i}')';
    end
    grad_b{i} = delta{i};

end
    assert(~isnan(sum(sum(delta{end}))))

%grad_W
%grad_b

assert(size(grad_W{1},2) == N, 'grad_W{1} must be of size [H,N]');
assert(size(grad_W{end},1) == C, 'grad_W{end} must be of size [C,N]');
assert(size(grad_b{1},1) == H, 'grad_b{1} must be of size [H,1]');
assert(size(grad_b{end},1) == C, 'grad_b{end} must be of size [C,1]');

end
