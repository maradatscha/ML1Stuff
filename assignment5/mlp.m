function [ W1 W2] = mlp( x, l, u )
%MLP Summary of this function goes here
%   Detailed explanation goes here

W1 = ones(u, size(x,1));
W2 = ones(size(l,1), u+1);

end

