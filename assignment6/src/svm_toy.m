clear all;
close all;
mu_1 = [3 3 ]';
mu_2 = [-3 -3 ]';

Ntr = 42;
Nte = 20;

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

y = zeros(Ntr+Ntr,1);
y(1:Ntr+1) = 1;
y(Ntr+1:end) = -1;


%% test primal SVM
disp('primal SVM:')
[w, f]  = primal_SVM(x, y)

w_l = [-10:.01:10]'*[w(2), -w(1)];

plot(w_l(:,1), w_l(:,2), 'b');


%$ test dual SVM
disp('dual SVM linear Kernel:');
% linear kernel
G = gram_linear(x);

[a, f]  = dual_SVM(x, y, G);
num_supvectors = sum(a>0.000001)
w = x'*(a.*y)
f

% RBF kernel

% find lambda
g = zeros(size(x,1), size(x,1));
for i=1:size(x,1)
  for j=1:size(x,1)
      g(i,j) = norm(x(i,:)-x(j,:));
  end
end
g = g.*g;
l = 1/median(g(:));
  
  
G = gram_RBF(x,l);
[a, f]  = dual_SVM(x, y, G);
disp('dual SVM RBF Kernel:');
num_supvectors = sum(a>0.000001)
f

% polynomial kernel
G = gram_poly(x,1.0, 2);
disp('dual SVM polynomial Kernel:');
[a, f]  = dual_SVM(x, y, G);
num_supvectors = sum(a>0.000001)
f
