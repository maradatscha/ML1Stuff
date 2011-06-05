function [w,f] = primal_SVM( x , y )

H = eye(size(x, 2));

b = 1./y;

f = zeros(1, size(x,2));

[w,fval,f]  = quadprog(H,f,x,b);



end