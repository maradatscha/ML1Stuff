function [ output_args ] = dual_SVM( x, y, G )


H = eye(size(x, 2));

b = zeros(size(x,2),1);

A = -1.*eye(size(x,2))

Aeq = y;
beq = zeros(1, size(y,2));



end

