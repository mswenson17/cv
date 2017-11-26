function [output, act_h, act_a] = Forward(W, b, X)
% [OUT, act_h, act_a] = Forward(W, b, X) performs forward propogation on the
% input data 'X' uisng the network defined by weights and biases 'W' and 'b'
% (as generated by InitializeNetwork(..)).
%
% This function should return the final softmax output layer activations in OUT,
% as well as the hidden layer post activations in 'act_h', and the hidden layer
% pre activations in 'act_a'.
C = size(b{end},1);
N = size(X,1);
H = size(W{1},1);
%size(W{1})
%size(X)
assert(size(X,2) == 1, 'X must be of size [N,1]');
assert(size(W{1},2) == N, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'b{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');

% My code here

act_a={};
X_orig = X;

for i = 1:numel(W)
    act_a{i} = W{i}*X+b{i};
    %actasize=size(act_a{i})
    X = sigmf(act_a{i},[1 0]);
    act_h{i} = X;
end

output = softmax(act_a{end});
act_h{end} = output;

assert(all(size(act_a{1}) == [H,1]), 'act_a{1} must be of size [H,1]');
assert(all(size(act_h{end}) == [C,1]), 'act_h{end} must be of size [C,1]');
assert(all(size(output) == [C,1]), 'output must be of size [C,1]');
end
