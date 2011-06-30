function [w,fl] = primal_SVM( x , y )

H = eye(size(x, 2));

f = zeros(1, size(x,2));
b = -1*ones(size(x,1),1);
A = -diag(y)*x;

[w,fval,fl]  = quadprog(H,f, A ,b);

end
