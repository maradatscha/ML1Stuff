function [ a,f ] = dual_SVM( x, y, G )

f = -1*ones(size(x,1), 1);

i = repmat(y,1, size(y,1));
j = repmat(y', size(y,1), 1);

H = i.*G.*j;

b = zeros(size(x,1),1);

A = -1.*eye( size(x,1));

Aeq = y';
beq = 0;


options = optimset('MaxIter', 100000);
s = zeros(size(x,1),1);

[a,fval,f]  = quadprog(H,f,A,b, Aeq, beq, -1,1000, s ,options);

end

