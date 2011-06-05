function r = primal_SVM( x , y )

H = eye(size(x, 2));

b = 1./y;

A = x;

f = zeros(1, size(x,2));



[r,fval,flag]  = quadprog(H,f,A,b);

flag

end