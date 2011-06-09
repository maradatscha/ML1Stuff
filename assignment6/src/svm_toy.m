clear all;
close all;
mu_1 = [4 4 ]';
mu_2 = [-4 -4 ]';

Ntr = 100;
Nte = 200;

% create training data
x1 = randn(2,Ntr)+repmat(mu_1,1,Ntr);
x2 = randn(2,Ntr)+repmat(mu_2,1,Ntr);

plot(x1(1,:), x1(2,:), 'r.');
hold on;
plot(x2(1,:), x2(2,:), 'g.');


% create test data
x1te = randn(2,Nte)+repmat(mu_1,1,Nte);
x2te = randn(2,Nte)+repmat(mu_2,1,Nte);

x = [x1, x2]';

y = zeros(Ntr+Ntr,1);    % labels
y(1:Ntr+1) = 1;
y(Ntr+1:end) = -1;



[w, f]  = primal_SVM(x, y)

w_l = [-10:.01:10]'*[w(2), -w(1)];

plot(w_l(:,1), w_l(:,2), 'b');

% linear

G = gram_linear(x);

[a, f]  = dual_SVM(x, y, G);

sum(a>0.0001)

w = x'*(a.*y)
f

% RBF

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
 G = gram_RBF(x,l);
 [a, f]  = dual_SVM(x, y, G);
 sum(a>0.000001)
 
 w = x'*(a.*y);
  
  
 f
