clear all;
close all;

%set means
mu_1 = [0 3.5 0]';
mu_2 = [4 0 0]';
mu_3 = [0 -3.5 0]';

Ntr = 50;
Nte = 100;

%create training data

x1 = randn(3,Ntr)+repmat(mu_1,1,Ntr);
x2 = randn(3,Ntr)+repmat(mu_2,1,Ntr);
x3 = randn(3,Ntr)+repmat(mu_3,1,Ntr);

%plot3(x1(1,:), x1(2,:), x1(3,:), 'r.');
%hold on;
%plot3(x2(1,:), x2(2,:), x2(3,:), 'g.');
%plot3(x3(1,:), x3(2,:), x3(3,:), 'b.');
%pause

%create test data
x1te = randn(3,Nte)+repmat(mu_1,1,Nte);
x2te = randn(3,Nte)+repmat(mu_2,1,Nte);
x3te = randn(3,Nte)+repmat(mu_3,1,Nte);


% two class case, normalize
m = mean([x1,x2,x3,x1te,x2te,x3te],2);

x1  = x1 - repmat(m,1,Ntr);
x2  = x2 - repmat(m,1,Ntr);
x3  = x3 - repmat(m,1,Ntr);

x1te  = x1te - repmat(m,1,Nte);
x2te  = x2te - repmat(m,1,Nte);
x3te  = x3te - repmat(m,1,Nte);


u = 3;                          % number of hidden variables
x = [x1, x2, x3]     ;               % training data
x = [x ; ones(1, length(x))]; 
xte = [x1te, x2te]     ;               % training data
xte = [xte ; ones(1, length(xte))]; 
r = 0.1; % learning rate

l = zeros(2, Ntr*3);    % labels
l(1,1:Ntr) = 1;
l(2,Ntr+1:Ntr*2) = 1;
l(3,Ntr*2+1:end) = 1;

lte = zeros(2, Nte*3);    % labels
lte(1,1:Nte) = 1;
lte(2,Nte+1:Nte*2) = 1;
lte(3,Nte*2+1:end) = 1;

[W1 W2] = mlp( x, l, u );

n = 1;
oldNorm = [1000 ; 1000];
i = 1;
while(n > 0.0000001 && i < 1000)
    i = i +1;
    gW1 = zeros(size(W1));
    gW2 = zeros(size(W2));
    
    for dp = 1:size(x,2)
    
        [t, z] = predict(W1, W2, x(:,dp) , @sig, @sig);

        d = output_error(t, l(:,dp));

        gW2 = gW2 + grad_W2( d, z, @sig_grad);
        gW1 = gW1 + grad_W1(d, W1, W2, z, x , @sig_grad);
    end
    gW2 = gW2 / size(x,2);
    gW1 = gW1 / size(x,2);
    
    W2 = W2 - r * gW2;
    W1 = W1 - r * gW1;

    W1 = W1/sqrt(sum(sum(W1.*W1)));
    W2 = W2/sqrt(sum(sum(W2.*W2)));

    oldNorm = oldNorm - [norm(gW1) ; norm(gW2)];
    n = max(oldNorm);
    oldNorm = [norm(gW1) ; norm(gW2)];
    
end
disp('Training Iterations: ')
disp(i)


disp('predictions on training data... ')
c = 0;
for i = 1:size(x,2)
    [y, d] = max(predict(W1, W2, x(:,i) , @id_x, @id_x));
    if(l(d,i))
        c = c + 1;
    end
end

disp('training error:' )
disp((Ntr*3 - c)/(Ntr*3))



disp('predictions on test data... ')
c = 0;
for i = 1:size(xte,2)
    [y, d] = max(predict(W1, W2, xte(:,i) , @id_x, @id_x));
    if(lte(d,i))
        c = c + 1;
    end
end

disp('test error:' )
disp((Nte*3 - c)/(Nte*3))
