function [ W1 W2] = mlp( x, l, u )
%MLP Summary of this function goes here
%   Detailed explanation goes here

W1 = ones(u,length(x));
W2 = ones(length(l), u);

end

