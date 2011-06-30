% RBF
clear all;
close all;

Ntr = 50;

l = 0.5;
  
  mu_1 = [5 5 ]';
    mu_2 = [-5 -5 ]';
sv = [];
for i = 1:50
    mu_1= mu_1-[0.07 0.07]';
    mu_2= mu_2+[0.07 0.07]';
    
    % create training data
    x1 = randn(2,Ntr)+repmat(mu_1,1,Ntr);
    x2 = randn(2,Ntr)+repmat(mu_2,1,Ntr);
    x = [x1 , x2]';
    
    y = zeros(Ntr+Ntr,1);    % labels
    y(1:Ntr+1) = 1;
    y(Ntr+1:end) = -1;

    
    % try out RBF kernel
    G = gram_RBF(x,l);
    [a, f]  = dual_SVM(x, y, G);
    sv = [sv sum(a>0.000001)];
    w = x'*(a.*y);
    f;
end


plot(sv)
