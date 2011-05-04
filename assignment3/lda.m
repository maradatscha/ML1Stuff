clear all;
close all;

data1 = load('data1.mat');

data2 = load('data2.mat');

X = data2.X;
y = data2.y;

% least squares
q = ones(size(X,1),1);

Xhat = horzcat(X,q);

w = pinv(Xhat)*y;

plot(X(:,1),X(:,2),'g.')     
hold on 
plot(X(1:50,1),X(1:50,2),'.')


wx = linspace(0,6,2);

plot(wx,(w(1)*wx+w(3))/-w(2),'r');

pause
close all;

%Fisher LDA


mean1 = mean(X(1:50,:));
mean2 = mean(X(51:100,:));

cov1 = cov(X(1:50,:));
cov2 = cov(X(51:100,:));

w = pinv(cov1+cov2)*(mean1 - mean2)';

wx = linspace(-2,6,2);
plot(X(:,1),X(:,2),'g.')     
hold on 
plot(X(1:50,1),X(1:50,2),'.')
plot(wx,(w(2)*wx/w(1)),'k');

