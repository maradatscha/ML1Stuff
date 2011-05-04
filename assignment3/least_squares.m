function w = least_squares(X,y)

q = ones(size(X,1),1);

Xhat = horzcat(X,q);

w = pinv(Xhat)*y;
