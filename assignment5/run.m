clear all;
close all;
mu_1 = [-3.0 -0.4 0]';
mu_2 = [1.9 -0.3 0]';
mu_3 = [0.9 1 0]';

Ntr = 4;
Nte = 100;

x1 = randn(3,Ntr)+repmat(mu_1,1,Ntr);
x2 = randn(3,Ntr)+repmat(mu_2,1,Ntr);
x3 = randn(3,Ntr)+repmat(mu_3,1,Ntr);



%plot3(x1(1,:), x1(2,:), x1(3,:), 'r.');
%hold on;
%plot3(x2(1,:), x2(2,:), x2(3,:), 'g.');
%plot3(x3(1,:), x3(2,:), x3(3,:), 'b.');

x1te = randn(3,Nte)+repmat(mu_1,1,Nte);
x2te = randn(3,Nte)+repmat(mu_2,1,Nte);
x3te = randn(3,Nte)+repmat(mu_3,1,Nte);


% two class case, normalize
m = mean([x1,x2],2);

x1  = x1 - repmat(m,1,Ntr);
x2  = x2 - repmat(m,1,Ntr);

x1te  = x1te - repmat(m,1,Nte);
x2te  = x2te - repmat(m,1,Nte);



u = 3;                          % number of hidden variables
x = [x1, x2]     ;               % training data
x = [x ; ones(1, length(x))];
l = zeros(2, Ntr+Ntr);    % labels
r = 0.1; % learning rate

l(1,1:Ntr) = 1;
l(2,Ntr+1:end) = 1;

[W1 W2] = mlp( x, l, u );

p = zeros(size(l));

[t, z] = predict(W1, W2, x(:,1) , @id_x, @id_x);

d = output_error(t, l(:,1))

W2 = W2 - r * grad_W2( d, z, @(x)(1));
W1 = W1 - r* grad_W1(d, W1, W2, z, x , @(x)(ones(size(x,1),1)));

W1 = W1/norm(W1);
W2 = W2/norm(W2);

