
% XOR points
x = [ 1 1; 1 -1; -1 1;  -1 -1];
x = [x ; 1 2; -1 -2]
% XOR labels

y = [ 1 ; -1; 1; -1  ];
y = [y; 1; -1]
plot(x(:,1), x(:,2), 'r.');

[w, f]  = primal_SVM(x, y);

w
f

% flag is -2, means not solvable
% which is OK because XOR can't be solved with linear


% find lambda
 g = zeros(size(x,1), size(x,1));
 
  for i=1:size(x,1)
     for j=1:size(x,1)
          g(i,j) = norm(x(i,:)-x(j,:));
     end
  end
  g = g.*g;
  l = 1/median(g(:));
  
  
 % try out RBF kernel
 %G = gram_RBF(x,l);
%  [a, f]  = dual_SVM(x, y, G);
%   w = x'*(a.*y)
%   
%   
%  f
%  
% %try out polynomial kernel
%  
%  G = gram_poly(x,1.0, 2);
%  
%  [a, f]  = dual_SVM(x, y, G);
%  
%  w = x'*(a.*y)
%  
%  
%  f
%  
 
 %try out linear kernel
 
 G = gram_linear(x);
 
 [a, f]  = dual_SVM(x, y, G);
 
 sum(a>0.000001)
 w = x'*(a.*y)
 
 
 f
 
 
 
 