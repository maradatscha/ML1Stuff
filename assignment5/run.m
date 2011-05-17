clear all;
close all;
mu_1 = [-3.0 -0.4 0]'
mu_2 = [1.9 -0.3 0]'
mu_3 = [0.9 1 0]'

Ntr = 50;
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




m = mean([x1,x2],2);

x1  = x1 - repmat(m,1,Ntr);
x2  = x2 - repmat(m,1,Ntr);

x1te  = x1te - repmat(m,1,Nte);
x2te  = x2te - repmat(m,1,Nte);




