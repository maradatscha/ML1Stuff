clear all;
close all;

data1 = load('data1.mat');

data2 = load('data2.mat');


% least squares
X = data1.X;
y = data1.y;

w = least_squares(X,y);

wx = linspace(-100,100,2);
plot(wx,(w(1)*wx+w(3))/-w(2),'k');
axis([-4 12 -3 4]);
hold on

X = data2.X;
y = data2.y;

w = least_squares(X,y);
plot(X(:,1),X(:,2),'g.')     
plot(X(1:50,1),X(1:50,2),'.')

plot(wx,(w(1)*wx+w(3))/-w(2),'r');

xlabel('black - without ouliers | red - with outliers');

pause
close all;


%Fisher LDA
wx = linspace(-100,100,2);

X = data1.X;
w = fisher(X(1:50,:), X(51:100,:));

plot(wx,(w(2)*wx/w(1)),'k');
axis([-4 12 -3 4]);
hold on 

X = data2.X;
plot(X(:,1),X(:,2),'g.')     
plot(X(1:50,1),X(1:50,2),'.')

w = fisher(X(1:50,:), X(51:120,:));
plot(wx,(w(2)*wx/w(1)),'r');

xlabel('black - without ouliers | red - with outliers');

pause
close all;

