function [ W1 W2] = mlp( x, l, u )
%MLP Summary of this function goes here
%   Detailed explanation goes here

W1 = randn(u, size(x,1));
W2 = randn(size(l,1), u+1);

end

